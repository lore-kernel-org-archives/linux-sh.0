Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76DEC433E0
	for <linux-sh@archiver.kernel.org>; Sun, 17 Jan 2021 11:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6668E206EC
	for <linux-sh@archiver.kernel.org>; Sun, 17 Jan 2021 11:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbhAQLUS (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 17 Jan 2021 06:20:18 -0500
Received: from condef-01.nifty.com ([202.248.20.66]:62422 "EHLO
        condef-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbhAQLUR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 17 Jan 2021 06:20:17 -0500
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-01.nifty.com with ESMTP id 10HBI1AM004965
        for <linux-sh@vger.kernel.org>; Sun, 17 Jan 2021 20:18:01 +0900
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 10HBGXEL004053;
        Sun, 17 Jan 2021 20:16:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10HBGXEL004053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610882194;
        bh=mDGcqBe4GubK8SZYhFUOU4mOtTxrvJNR8QEIK9mA4JE=;
        h=From:To:Cc:Subject:Date:From;
        b=uRubQVESizv1JcVWK18rxQkxwW78tBZRJDjRU0UFjLbxoa1DYXdwKW3T1mKXMxAmq
         s4aXJatVgTlsnGJQ0vm2pAYmIxsEO4aq9lFOz0yFWk2CQAMCVeItDaCBiktG+Hnqwj
         TL9PabmCM+6k023E6MEmxLiqunWGQ/t+Z/2MkLfAmdZwXV12Ctib6umZtOpLON9TLP
         LtioelFOAdQFvxZRcLeB9apa17iqqNLC5D1yGirLvi6uvBivA42APJfXW6DFC4uWFG
         dUMZOyRT+Fy5bCiL7J9D6LaJgSNAzym+r+gNzB7LoG3sbqHWuV13BvCNymICirA+3Q
         ti1sV72NTQtqQ==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sh: boot: add intermediate vmlinux.bin* to targets instead of extra-y
Date:   Sun, 17 Jan 2021 20:16:31 +0900
Message-Id: <20210117111632.2392635-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

You do not need to build all of vmlinux.bin*

They are built on demand as prerequsites of uImage.bin*, hence should
be added to targets instead of extra-y.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/boot/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 58592dfa5cb6..dded61296c9a 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -27,8 +27,8 @@ suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO)	:= lzo
 
 targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
-	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin
-extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
+	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin \
+	   vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	   vmlinux.bin.xz vmlinux.bin.lzo
 subdir- := compressed romimage
 
-- 
2.27.0

