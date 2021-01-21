Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5566CC433E0
	for <linux-sh@archiver.kernel.org>; Thu, 21 Jan 2021 12:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02ADA2395A
	for <linux-sh@archiver.kernel.org>; Thu, 21 Jan 2021 12:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAUMJR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 21 Jan 2021 07:09:17 -0500
Received: from m12-18.163.com ([220.181.12.18]:40232 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730597AbhAUMFV (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Thu, 21 Jan 2021 07:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=tTrwY
        CctdIiTn6NkLOKxsV7O3wl8KqpDKzWjYvatom0=; b=cAclFv6/pkYMPlIvENN7x
        DydVGGQh9rciRzHjU9B/D5/z+oSMl3bh8P5/b7wyFABcSHJcFW+TR9BjztHlPqG2
        QiLyeR9XfHMX7xDFsfumelPclYppWcJvYGaleHXo0/FFRMFsl6HEK3UcqdxOC/9T
        Rl8FNJE6IX35MMYYhj/OYg=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowACHv9f0awlg4TkpQQ--.34102S2;
        Thu, 21 Jan 2021 19:56:40 +0800 (CST)
From:   zuoqilin1@163.com
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] sh/mm: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Thu, 21 Jan 2021 19:56:33 +0800
Message-Id: <20210121115633.469-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowACHv9f0awlg4TkpQQ--.34102S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrZFWDGF45trW7Xr15Gw4rKrg_yoW8Jr4Dpa
        n3Cw18Jr4rJryDCr9FyrZrZ34Sga95tr1Igas093yfAFyDZ34YqFyrWFW09ry8KrW8CFyx
        t3yY9a4UGw4UA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jd3ktUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/xtbBRRghiVPAJqnBqgAAsC
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 arch/sh/mm/asids-debugfs.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index 4c1ca19..d16d6f5 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -26,7 +26,7 @@
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 
-static int asids_seq_show(struct seq_file *file, void *iter)
+static int asids_debugfs_show(struct seq_file *file, void *iter)
 {
 	struct task_struct *p;
 
@@ -48,18 +48,7 @@ static int asids_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int asids_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, asids_seq_show, inode->i_private);
-}
-
-static const struct file_operations asids_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= asids_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(asids_debugfs);
 
 static int __init asids_debugfs_init(void)
 {
-- 
1.9.1


