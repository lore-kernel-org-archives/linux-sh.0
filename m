Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E8ECAAD3
	for <linux-sh@archiver.kernel.org>; Thu, 15 Sep 2022 01:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIOBud (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 14 Sep 2022 21:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIOBub (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 14 Sep 2022 21:50:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33F87F105
        for <linux-sh@vger.kernel.org>; Wed, 14 Sep 2022 18:50:30 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSg5X50PmzNmHl;
        Thu, 15 Sep 2022 09:45:52 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 15 Sep 2022 09:50:28 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 15 Sep
 2022 09:50:28 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
CC:     <linux-sh@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] sh: use DEFINE_SHOW_ATTRIBUTE to simplify tlb_debugfs
Date:   Thu, 15 Sep 2022 10:24:07 +0800
Message-ID: <20220915022407.3116920-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/sh/mm/tlb-debugfs.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/arch/sh/mm/tlb-debugfs.c b/arch/sh/mm/tlb-debugfs.c
index 11c6148283f3..20837ae4bf83 100644
--- a/arch/sh/mm/tlb-debugfs.c
+++ b/arch/sh/mm/tlb-debugfs.c
@@ -36,7 +36,7 @@ static struct {
 	{ 0xc, " 64MB" },
 };
 
-static int tlb_seq_show(struct seq_file *file, void *iter)
+static int tlb_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int tlb_type = (unsigned int)file->private;
 	unsigned long addr1, addr2, data1, data2;
@@ -133,19 +133,7 @@ static int tlb_seq_show(struct seq_file *file, void *iter)
 
 	return 0;
 }
-
-static int tlb_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tlb_seq_show, inode->i_private);
-}
-
-static const struct file_operations tlb_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= tlb_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tlb_debugfs);
 
 static int __init tlb_debugfs_init(void)
 {
-- 
2.25.1

