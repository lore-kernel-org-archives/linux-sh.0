Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79608C433ED
	for <linux-sh@archiver.kernel.org>; Fri,  9 Apr 2021 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4CA61165
	for <linux-sh@archiver.kernel.org>; Fri,  9 Apr 2021 07:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhDIHMx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 9 Apr 2021 03:12:53 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:26968 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhDIHMx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 9 Apr 2021 03:12:53 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id ADF43400160;
        Fri,  9 Apr 2021 15:12:38 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] sh: boards: Remove unnecessary break
Date:   Fri,  9 Apr 2021 15:12:11 +0800
Message-Id: <20210409071222.1097104-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGktITFYaHhpJHUpOH0hPGh9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6PTo6HT8NGhoOVkoyNhUJ
        LTMaCyhVSlVKTUpMQk5JSE5CSk5OVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTk5LNwY+
X-HM-Tid: 0a78b579c1b4d991kuwsadf43400160
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

There is a return above the break.
The break here is unnecessary. Remove it.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/sh/boards/mach-landisk/gio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-landisk/gio.c b/arch/sh/boards/mach-landisk/gio.c
index ff2200fec29a..fd7a3283942f 100644
--- a/arch/sh/boards/mach-landisk/gio.c
+++ b/arch/sh/boards/mach-landisk/gio.c
@@ -106,7 +106,6 @@ static long gio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		break;
 	default:
 		return -EFAULT;
-		break;
 	}
 
 	if ((cmd & 0x01) == 0) {	/* read */
-- 
2.25.1

