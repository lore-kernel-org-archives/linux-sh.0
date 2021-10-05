Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4038C433EF
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8833461247
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhJEAVJ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhJEAVH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Oct 2021 20:21:07 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF05CC061749;
        Mon,  4 Oct 2021 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=M0GxxOUNM2NCgc5+UlE92aSv5qcyndOY+ydhMBjsJuA=; b=M+samDPbBs8WEBQlqyC8UWsnso
        INCEEuWpzxdztDVkEkDFALllDIhLEKOPKjtTuukoxlVvHLGoFybt7rNachompFDKZml05SSXoak5r
        FbhV85DZu4RtQOBuBPEYun553dRabsESNB/rmeKuay40gpvCclDfl6wsii8lIRNDgm6S+kukWAXl6
        yAXqLn//QbBzuuXYSdO98dEhs8MCFMojhIoKi4iSV3YyeIw0vt5upSiu7dajuyC6S5WZiWB+tmwb9
        wUlrNSJfDYQrZoklRhhcAEEbiiQBgyWUcopSsUVMAE36hB4/42HeLtF3tigAD9LCZdI6EfJG3E78E
        tI3oyb/A==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXYAv-008SGi-GY; Tue, 05 Oct 2021 00:19:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Subject: [PATCH 5/5 v3] sh: fix READ/WRITE redefinition warnings
Date:   Mon,  4 Oct 2021 17:19:14 -0700
Message-Id: <20211005001914.28574-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211005001914.28574-1-rdunlap@infradead.org>
References: <20211005001914.28574-1-rdunlap@infradead.org>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2: renumber patches, otherwise no change;
v3: renumber, rebase, & resend;
    add Rev-by: Geert;

 arch/sh/math-emu/math.c |   44 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- linux-next-20211001.orig/arch/sh/math-emu/math.c
+++ linux-next-20211001/arch/sh/math-emu/math.c
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
