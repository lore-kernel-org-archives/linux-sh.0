Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E698AC433F5
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E1261247
	for <linux-sh@archiver.kernel.org>; Tue,  5 Oct 2021 00:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJEAVL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJEAVH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 4 Oct 2021 20:21:07 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00CC061745;
        Mon,  4 Oct 2021 17:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EYFqAnmJiXkU9369rqhDh+53a9v29IG/nWtmm5Q/gvQ=; b=AT1k0439f8p6RELnkh79tTzSV1
        1Yda1H4YkGk++E+A6YzpnF0NvVVj4wYnn8h8W060JsqSAC6DzBWu5+V5HLK9S6C8yqs/8tZCb6xbT
        HlTOgq0TayllThZ05pG9qOkMJAa/CEwW6KwCSL4Pd2ZMMoZOCYugC/BA9HqVjyF9MiFdp6TOZEMvz
        SwRAQaxyeDsYY0vFBVdNajDJQTKw6luvZsf1R5V4Ns6RCL7sXmr9xPn7k/aOgJ40MU1TdV4Nr9vwO
        Lj4W58ZT74J/0XeAziIdn9BSWkTIZceib3NRignsGKV0VEWww+bMJYjUK3by/b+H2QEVweQw5DUiC
        ZSe98IqQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXYAu-008SGi-Mw; Tue, 05 Oct 2021 00:19:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Subject: [PATCH 3/5 v3] sh: math-emu: drop unused functions
Date:   Mon,  4 Oct 2021 17:19:12 -0700
Message-Id: <20211005001914.28574-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211005001914.28574-1-rdunlap@infradead.org>
References: <20211005001914.28574-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Delete ieee_fpe_handler() since it is not used. After that is done,
delete denormal_to_double() since it is not used:

../arch/sh/math-emu/math.c:505:12: error: 'ieee_fpe_handler' defined but not used [-Werror=unused-function]
  505 | static int ieee_fpe_handler(struct pt_regs *regs)

../arch/sh/math-emu/math.c:477:13: error: 'denormal_to_double' defined but not used [-Werror=unused-function]
  477 | static void denormal_to_double(struct sh_fpu_soft_struct *fpu, int n)

Fixes: 4b565680d163 ("sh: math-emu support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Takashi YOSHII <takasi-y@ops.dti.ne.jp>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3: new patch in this series;

 arch/sh/math-emu/math.c |  103 --------------------------------------
 1 file changed, 103 deletions(-)

--- linux-next-20211001.orig/arch/sh/math-emu/math.c
+++ linux-next-20211001/arch/sh/math-emu/math.c
@@ -468,109 +468,6 @@ static int fpu_emulate(u16 code, struct
 }
 
 /**
- *	denormal_to_double - Given denormalized float number,
- *	                     store double float
- *
- *	@fpu: Pointer to sh_fpu_soft structure
- *	@n: Index to FP register
- */
-static void denormal_to_double(struct sh_fpu_soft_struct *fpu, int n)
-{
-	unsigned long du, dl;
-	unsigned long x = fpu->fpul;
-	int exp = 1023 - 126;
-
-	if (x != 0 && (x & 0x7f800000) == 0) {
-		du = (x & 0x80000000);
-		while ((x & 0x00800000) == 0) {
-			x <<= 1;
-			exp--;
-		}
-		x &= 0x007fffff;
-		du |= (exp << 20) | (x >> 3);
-		dl = x << 29;
-
-		fpu->fp_regs[n] = du;
-		fpu->fp_regs[n+1] = dl;
-	}
-}
-
-/**
- *	ieee_fpe_handler - Handle denormalized number exception
- *
- *	@regs: Pointer to register structure
- *
- *	Returns 1 when it's handled (should not cause exception).
- */
-static int ieee_fpe_handler(struct pt_regs *regs)
-{
-	unsigned short insn = *(unsigned short *)regs->pc;
-	unsigned short finsn;
-	unsigned long nextpc;
-	int nib[4] = {
-		(insn >> 12) & 0xf,
-		(insn >> 8) & 0xf,
-		(insn >> 4) & 0xf,
-		insn & 0xf};
-
-	if (nib[0] == 0xb ||
-	    (nib[0] == 0x4 && nib[2] == 0x0 && nib[3] == 0xb)) /* bsr & jsr */
-		regs->pr = regs->pc + 4;
-
-	if (nib[0] == 0xa || nib[0] == 0xb) { /* bra & bsr */
-		nextpc = regs->pc + 4 + ((short) ((insn & 0xfff) << 4) >> 3);
-		finsn = *(unsigned short *) (regs->pc + 2);
-	} else if (nib[0] == 0x8 && nib[1] == 0xd) { /* bt/s */
-		if (regs->sr & 1)
-			nextpc = regs->pc + 4 + ((char) (insn & 0xff) << 1);
-		else
-			nextpc = regs->pc + 4;
-		finsn = *(unsigned short *) (regs->pc + 2);
-	} else if (nib[0] == 0x8 && nib[1] == 0xf) { /* bf/s */
-		if (regs->sr & 1)
-			nextpc = regs->pc + 4;
-		else
-			nextpc = regs->pc + 4 + ((char) (insn & 0xff) << 1);
-		finsn = *(unsigned short *) (regs->pc + 2);
-	} else if (nib[0] == 0x4 && nib[3] == 0xb &&
-		 (nib[2] == 0x0 || nib[2] == 0x2)) { /* jmp & jsr */
-		nextpc = regs->regs[nib[1]];
-		finsn = *(unsigned short *) (regs->pc + 2);
-	} else if (nib[0] == 0x0 && nib[3] == 0x3 &&
-		 (nib[2] == 0x0 || nib[2] == 0x2)) { /* braf & bsrf */
-		nextpc = regs->pc + 4 + regs->regs[nib[1]];
-		finsn = *(unsigned short *) (regs->pc + 2);
-	} else if (insn == 0x000b) { /* rts */
-		nextpc = regs->pr;
-		finsn = *(unsigned short *) (regs->pc + 2);
-	} else {
-		nextpc = regs->pc + 2;
-		finsn = insn;
-	}
-
-	if ((finsn & 0xf1ff) == 0xf0ad) { /* fcnvsd */
-		struct task_struct *tsk = current;
-
-		if ((tsk->thread.xstate->softfpu.fpscr & (1 << 17))) {
-			/* FPU error */
-			denormal_to_double (&tsk->thread.xstate->softfpu,
-					    (finsn >> 8) & 0xf);
-			tsk->thread.xstate->softfpu.fpscr &=
-				~(FPSCR_CAUSE_MASK | FPSCR_FLAG_MASK);
-			task_thread_info(tsk)->status |= TS_USEDFPU;
-		} else {
-			force_sig_fault(SIGFPE, FPE_FLTINV,
-					(void __user *)regs->pc);
-		}
-
-		regs->pc = nextpc;
-		return 1;
-	}
-
-	return 0;
-}
-
-/**
  * fpu_init - Initialize FPU registers
  * @fpu: Pointer to software emulated FPU registers.
  */
