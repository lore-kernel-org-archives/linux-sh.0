Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB015C001DF
	for <linux-sh@archiver.kernel.org>; Wed,  2 Aug 2023 03:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHBDjM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 1 Aug 2023 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBDjK (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 1 Aug 2023 23:39:10 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 490141712;
        Tue,  1 Aug 2023 20:39:06 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [218.12.19.119])
        by mail-app2 (Coremail) with SMTP id by_KCgAXbhiCz8lkx8zpCg--.8405S2;
        Wed, 02 Aug 2023 11:37:52 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     ysato@users.sourceforge.jp
Cc:     dalias@libc.org, glaubitz@physik.fu-berlin.de, kvalo@kernel.org,
        pavel@ucw.cz, pabeni@redhat.com, rostedt@goodmis.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] sh: push-switch: reorder cleanup operations to avoid UAF bug
Date:   Wed,  2 Aug 2023 11:37:37 +0800
Message-Id: <20230802033737.9738-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgAXbhiCz8lkx8zpCg--.8405S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rAw4xZr45WFyDur43trb_yoW8GF4Dpr
        Z5XFn7GrW0qrWqk34UGwn7uFW5WanFgry7XrWfu3WxXwn8XF95J34ftryfKF47Cr97XF43
        Jr1Fqw1fWa4DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
        n2kIc2xKxwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUYnYwUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMPAWTIYfoZuQA5sg
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The original code puts flush_work() before timer_shutdown_sync()
in switch_drv_remove(). Although we use flush_work() to stop
the worker, it could be re-scheduled in switch_timer. As a result,
the UAF bug will happen. The detail is shown below:

      (cpu 0)                    |      (cpu 1)
switch_drv_remove()              |
 flush_work()                    |
  ...                            |  switch_timer //timer
                                 |   schedule_work(&psw->work)
 timer_shutdown_sync()           |
 ...                             |  switch_work_handler //worker
 kfree(psw) //free               |
                                 |   psw->state = 0 //use

This patch puts timer_shutdown_sync() before flush_work() to
mitigate the bugs. As a result, the worker and timer could
be stopped safely before the deallocate operations.

Fixes: 9f5e8eee5cfe ("sh: generic push-switch framework.")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 arch/sh/drivers/push-switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index c95f48ff3f6..6ecba5f521e 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -101,8 +101,8 @@ static int switch_drv_remove(struct platform_device *pdev)
 		device_remove_file(&pdev->dev, &dev_attr_switch);
 
 	platform_set_drvdata(pdev, NULL);
-	flush_work(&psw->work);
 	timer_shutdown_sync(&psw->debounce);
+	flush_work(&psw->work);
 	free_irq(irq, pdev);
 
 	kfree(psw);
-- 
2.17.1

