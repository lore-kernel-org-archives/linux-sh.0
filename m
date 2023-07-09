Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC76CEB64DC
	for <linux-sh@archiver.kernel.org>; Sun,  9 Jul 2023 12:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGIMfN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 9 Jul 2023 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjGIMfN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 9 Jul 2023 08:35:13 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCCA129
        for <linux-sh@vger.kernel.org>; Sun,  9 Jul 2023 05:35:10 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzRRb3pXxzBJBgF
        for <linux-sh@vger.kernel.org>; Sun,  9 Jul 2023 20:35:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688906107; x=1691498108; bh=mjXTHNdHAU+xS5sfdZYN0S62k7a
        JHZJWnjIbQuU5p7A=; b=oWuCm1q/QTLpYYbNzAAN8Jxv6YUE0bOSrxULpz9lrmc
        hX4qTLv2X65rAVMrn+O+atPYlJfT6zHg0s4rWsxoht9GzUAdmb57/RBN2PlTAZ98
        +PnidPMY+aI8Z0ABqrrscQSEPHXtytBlrPF1iL/pB4z+O31XRuIvpBChFKpm4qUM
        afIRfzIVeAQV4lK/aiSie/5cn99D77CUp6D21A5+iZNmJ3/7Qlf03F9EFH/PQXtw
        5a9RDN7puQLZufkNPjUKTsaeNhgq5IZMmVqRqdD2wXqgPLuXYbxd4naehbNnVvDO
        EMhf1blJziCiU0IZtj7DBXlcb1YhAIEOx1TGTcJc0lQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZtXf2p8cSGUQ for <linux-sh@vger.kernel.org>;
        Sun,  9 Jul 2023 20:35:07 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzRRZ6c6lzBHXkb;
        Sun,  9 Jul 2023 20:35:06 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 20:35:06 +0800
From:   xuanzhenggang001@208suo.com
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sh: heartbeat: prefer 'unsigned int' to bare use of
 'unsigned'
In-Reply-To: <20230709123329.33674-1-denghuilong@cdjrlc.com>
References: <20230709123329.33674-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7554aadc5afb915ee1065cea56053cb6@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fix the following warnings reported by checkpatch:

arch/sh/drivers/heartbeat.c:33: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/sh/drivers/heartbeat.c:62: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/sh/drivers/heartbeat.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index 24391b444b28..07f04ed0d517 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -30,7 +30,7 @@
  static unsigned char default_bit_pos[] = { 0, 1, 2, 3, 4, 5, 6, 7 };

  static inline void heartbeat_toggle_bit(struct heartbeat_data *hd,
-                    unsigned bit, unsigned int inverted)
+                    unsigned int bit, unsigned int inverted)
  {
      unsigned int new;

@@ -59,7 +59,7 @@ static inline void heartbeat_toggle_bit(struct 
heartbeat_data *hd,
  static void heartbeat_timer(struct timer_list *t)
  {
      struct heartbeat_data *hd = from_timer(hd, t, timer);
-    static unsigned bit = 0, up = 1;
+    static unsigned int bit = 0, up = 1;

      heartbeat_toggle_bit(hd, bit, hd->flags & HEARTBEAT_INVERTED);
