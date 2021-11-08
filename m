Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF9EC433F5
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259B2611C4
	for <linux-sh@archiver.kernel.org>; Mon,  8 Nov 2021 10:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbhKHKP7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 8 Nov 2021 05:15:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38518 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237913AbhKHKPV (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:21 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DA9DC1EC0523;
        Mon,  8 Nov 2021 11:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6udaEpyG8h+J9wXmKHEY7Likmk6gPzBuHNHMnjS5i9I=;
        b=G70gieGbrDi80a4ea+alShmWaZEh/CzfR9/ZMcmuuUX2GmpeyZsCEhKNpUW9ELcwZBC6Tf
        tPumkuqo9DxF2gxOQi3DakERJnbJCkSh87UubytVLuva0Eoyp3J+taG4aMAzuYA98iqCmS
        +lGzt7IMi0DoDp1t+FC4ceXTSuaUywo=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-sh@vger.kernel.org
Subject: [PATCH v0 35/42] sh: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:50 +0100
Message-Id: <20211108101157.15189-36-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 0d990ab1ba2a..8dfbb8149f66 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -1277,11 +1277,14 @@ static struct notifier_block sh7724_post_sleep_notifier = {
 
 static int __init sh7724_sleep_setup(void)
 {
-	atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
-				       &sh7724_pre_sleep_notifier);
+	if (atomic_notifier_chain_register(&sh_mobile_pre_sleep_notifier_list,
+					   &sh7724_pre_sleep_notifier))
+		pr_warn("SH7724 pre-sleep notifier already registered\n");
+
+	if (atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
+					   &sh7724_post_sleep_notifier))
+		pr_warn("SH7724 pre-sleep notifier already registered\n");
 
-	atomic_notifier_chain_register(&sh_mobile_post_sleep_notifier_list,
-				       &sh7724_post_sleep_notifier);
 	return 0;
 }
 arch_initcall(sh7724_sleep_setup);
-- 
2.29.2

