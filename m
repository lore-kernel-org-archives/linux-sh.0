Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE9C48BC2
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5606144E
	for <linux-sh@archiver.kernel.org>; Sun, 27 Jun 2021 22:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhF0WIR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 27 Jun 2021 18:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhF0WIM (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 27 Jun 2021 18:08:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B67C061574;
        Sun, 27 Jun 2021 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N/w1aU+qVBv4lNTFdznqZeT9wglcp1r9+KgSLWCT+oA=; b=Cy2U+kCexLBHFaEiTQr0AEcb/J
        Z0p4Nk99gV0UILHh4APaDWnWohAx4+FhGmTDpA97Jj1f5RWGZ/dr4ZYVhVCjyi5wLVycnOIGaOTO4
        +m6ADMoMFWpoKtHIW4urdx5TqtFhul8XLzCJk1W7s0YdB0XcrHIWjcLkkKCbDoK9deuzocWywDihy
        z1xVqq8cCh/7LmUxT6VaRIi7pVs2lwzyrYTWyYUPUYhrUk3QyXUypbjEmF8crucs5m4dO2ueVhf3Z
        VnjxNkX7iZWPAEQlfZSvjatggzG8S9fPqZTbJKVVghgBVYx1yLDPqjk3uCmSmowaQWa5ohAPtGdEr
        V4B8CaaQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxcuQ-006CHh-Oi; Sun, 27 Jun 2021 22:05:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Subject: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
Date:   Sun, 27 Jun 2021 15:05:44 -0700
Message-Id: <20210627220544.8757-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210627220544.8757-1-rdunlap@infradead.org>
References: <20210627220544.8757-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

kernel.h defines READ and WRITE, so rename the SH math-emu macros
to MREAD and MWRITE.

Fixes these warnings:

../arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
   54 | #define WRITE(d,a) ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
In file included from ../arch/sh/math-emu/math.c:10:
../include/linux/kernel.h:37: note: this is the location of the previous definition
   37 | #define WRITE   1
../arch/sh/math-emu/math.c:55: warning: "READ" redefined
   55 | #define READ(d,a) ({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
In file included from ../arch/sh/math-emu/math.c:10:
../include/linux/kernel.h:36: note: this is the location of the previous definition
   36 | #define READ   0

Fixes: 4b565680d163 ("sh: math-emu support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2: renumber patches, otherwise no change;

 arch/sh/math-emu/math.c |   44 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- linux-next-20210625.orig/arch/sh/math-emu/math.c
+++ linux-next-20210625/arch/sh/math-emu/math.c
@@ -51,8 +51,8 @@
 #define Rn	(regs->regs[n])
 #define Rm	(regs->regs[m])
 
-#define WRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
-#define READ(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
+#define MWRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
+#define MREAD(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
 
 #define PACK_S(r,f)	FP_PACK_SP(&r,f)
 #define UNPACK_S(f,r)	FP_UNPACK_SP(f,&r)
@@ -157,11 +157,11 @@ fmov_idx_reg(struct sh_fpu_soft_struct *
 {
 	if (FPSCR_SZ) {
 		FMOV_EXT(n);
-		READ(FRn, Rm + R0 + 4);
+		MREAD(FRn, Rm + R0 + 4);
 		n++;
-		READ(FRn, Rm + R0);
+		MREAD(FRn, Rm + R0);
 	} else {
-		READ(FRn, Rm + R0);
+		MREAD(FRn, Rm + R0);
 	}
 
 	return 0;
@@ -173,11 +173,11 @@ fmov_mem_reg(struct sh_fpu_soft_struct *
 {
 	if (FPSCR_SZ) {
 		FMOV_EXT(n);
-		READ(FRn, Rm + 4);
+		MREAD(FRn, Rm + 4);
 		n++;
-		READ(FRn, Rm);
+		MREAD(FRn, Rm);
 	} else {
-		READ(FRn, Rm);
+		MREAD(FRn, Rm);
 	}
 
 	return 0;
@@ -189,12 +189,12 @@ fmov_inc_reg(struct sh_fpu_soft_struct *
 {
 	if (FPSCR_SZ) {
 		FMOV_EXT(n);
-		READ(FRn, Rm + 4);
+		MREAD(FRn, Rm + 4);
 		n++;
-		READ(FRn, Rm);
+		MREAD(FRn, Rm);
 		Rm += 8;
 	} else {
-		READ(FRn, Rm);
+		MREAD(FRn, Rm);
 		Rm += 4;
 	}
 
@@ -207,11 +207,11 @@ fmov_reg_idx(struct sh_fpu_soft_struct *
 {
 	if (FPSCR_SZ) {
 		FMOV_EXT(m);
-		WRITE(FRm, Rn + R0 + 4);
+		MWRITE(FRm, Rn + R0 + 4);
 		m++;
-		WRITE(FRm, Rn + R0);
+		MWRITE(FRm, Rn + R0);
 	} else {
-		WRITE(FRm, Rn + R0);
+		MWRITE(FRm, Rn + R0);
 	}
 
 	return 0;
@@ -223,11 +223,11 @@ fmov_reg_mem(struct sh_fpu_soft_struct *
 {
 	if (FPSCR_SZ) {
 		FMOV_EXT(m);
-		WRITE(FRm, Rn + 4);
+		MWRITE(FRm, Rn + 4);
 		m++;
-		WRITE(FRm, Rn);
+		MWRITE(FRm, Rn);
 	} else {
-		WRITE(FRm, Rn);
+		MWRITE(FRm, Rn);
 	}
 
 	return 0;
@@ -240,12 +240,12 @@ fmov_reg_dec(struct sh_fpu_soft_struct *
 	if (FPSCR_SZ) {
 		FMOV_EXT(m);
 		Rn -= 8;
-		WRITE(FRm, Rn + 4);
+		MWRITE(FRm, Rn + 4);
 		m++;
-		WRITE(FRm, Rn);
+		MWRITE(FRm, Rn);
 	} else {
 		Rn -= 4;
-		WRITE(FRm, Rn);
+		MWRITE(FRm, Rn);
 	}
 
 	return 0;
@@ -445,11 +445,11 @@ id_sys(struct sh_fpu_soft_struct *fregs,
 	case 0x4052:
 	case 0x4062:
 		Rn -= 4;
-		WRITE(*reg, Rn);
+		MWRITE(*reg, Rn);
 		break;
 	case 0x4056:
 	case 0x4066:
-		READ(*reg, Rn);
+		MREAD(*reg, Rn);
 		Rn += 4;
 		break;
 	default:
