Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3498AC11F65
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19E6261C9A
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhF3Jir (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:38:47 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48439 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233944AbhF3Jir (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Jun 2021 05:38:47 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lyWdj-001xla-1j; Wed, 30 Jun 2021 11:36:15 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lyWdi-0013Qy-RC; Wed, 30 Jun 2021 11:36:15 +0200
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <20210627220544.8757-4-rdunlap@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
Date:   Wed, 30 Jun 2021 11:36:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627220544.8757-4-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/28/21 12:05 AM, Randy Dunlap wrote:
> kernel.h defines READ and WRITE, so rename the SH math-emu macros
> to MREAD and MWRITE.
> 
> Fixes these warnings:
> 
> ../arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
>    54 | #define WRITE(d,a) ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> In file included from ../arch/sh/math-emu/math.c:10:
> ../include/linux/kernel.h:37: note: this is the location of the previous definition
>    37 | #define WRITE   1
> ../arch/sh/math-emu/math.c:55: warning: "READ" redefined
>    55 | #define READ(d,a) ({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> In file included from ../arch/sh/math-emu/math.c:10:
> ../include/linux/kernel.h:36: note: this is the location of the previous definition
>    36 | #define READ   0
> 
> Fixes: 4b565680d163 ("sh: math-emu support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: Takashi YOSHII <takasi-y@ops.dti.ne.jp>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2: renumber patches, otherwise no change;
> 
>  arch/sh/math-emu/math.c |   44 +++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> --- linux-next-20210625.orig/arch/sh/math-emu/math.c
> +++ linux-next-20210625/arch/sh/math-emu/math.c
> @@ -51,8 +51,8 @@
>  #define Rn	(regs->regs[n])
>  #define Rm	(regs->regs[m])
>  
> -#define WRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> -#define READ(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> +#define MWRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
> +#define MREAD(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>  
>  #define PACK_S(r,f)	FP_PACK_SP(&r,f)
>  #define UNPACK_S(f,r)	FP_UNPACK_SP(f,&r)
> @@ -157,11 +157,11 @@ fmov_idx_reg(struct sh_fpu_soft_struct *
>  {
>  	if (FPSCR_SZ) {
>  		FMOV_EXT(n);
> -		READ(FRn, Rm + R0 + 4);
> +		MREAD(FRn, Rm + R0 + 4);
>  		n++;
> -		READ(FRn, Rm + R0);
> +		MREAD(FRn, Rm + R0);
>  	} else {
> -		READ(FRn, Rm + R0);
> +		MREAD(FRn, Rm + R0);
>  	}
>  
>  	return 0;
> @@ -173,11 +173,11 @@ fmov_mem_reg(struct sh_fpu_soft_struct *
>  {
>  	if (FPSCR_SZ) {
>  		FMOV_EXT(n);
> -		READ(FRn, Rm + 4);
> +		MREAD(FRn, Rm + 4);
>  		n++;
> -		READ(FRn, Rm);
> +		MREAD(FRn, Rm);
>  	} else {
> -		READ(FRn, Rm);
> +		MREAD(FRn, Rm);
>  	}
>  
>  	return 0;
> @@ -189,12 +189,12 @@ fmov_inc_reg(struct sh_fpu_soft_struct *
>  {
>  	if (FPSCR_SZ) {
>  		FMOV_EXT(n);
> -		READ(FRn, Rm + 4);
> +		MREAD(FRn, Rm + 4);
>  		n++;
> -		READ(FRn, Rm);
> +		MREAD(FRn, Rm);
>  		Rm += 8;
>  	} else {
> -		READ(FRn, Rm);
> +		MREAD(FRn, Rm);
>  		Rm += 4;
>  	}
>  
> @@ -207,11 +207,11 @@ fmov_reg_idx(struct sh_fpu_soft_struct *
>  {
>  	if (FPSCR_SZ) {
>  		FMOV_EXT(m);
> -		WRITE(FRm, Rn + R0 + 4);
> +		MWRITE(FRm, Rn + R0 + 4);
>  		m++;
> -		WRITE(FRm, Rn + R0);
> +		MWRITE(FRm, Rn + R0);
>  	} else {
> -		WRITE(FRm, Rn + R0);
> +		MWRITE(FRm, Rn + R0);
>  	}
>  
>  	return 0;
> @@ -223,11 +223,11 @@ fmov_reg_mem(struct sh_fpu_soft_struct *
>  {
>  	if (FPSCR_SZ) {
>  		FMOV_EXT(m);
> -		WRITE(FRm, Rn + 4);
> +		MWRITE(FRm, Rn + 4);
>  		m++;
> -		WRITE(FRm, Rn);
> +		MWRITE(FRm, Rn);
>  	} else {
> -		WRITE(FRm, Rn);
> +		MWRITE(FRm, Rn);
>  	}
>  
>  	return 0;
> @@ -240,12 +240,12 @@ fmov_reg_dec(struct sh_fpu_soft_struct *
>  	if (FPSCR_SZ) {
>  		FMOV_EXT(m);
>  		Rn -= 8;
> -		WRITE(FRm, Rn + 4);
> +		MWRITE(FRm, Rn + 4);
>  		m++;
> -		WRITE(FRm, Rn);
> +		MWRITE(FRm, Rn);
>  	} else {
>  		Rn -= 4;
> -		WRITE(FRm, Rn);
> +		MWRITE(FRm, Rn);
>  	}
>  
>  	return 0;
> @@ -445,11 +445,11 @@ id_sys(struct sh_fpu_soft_struct *fregs,
>  	case 0x4052:
>  	case 0x4062:
>  		Rn -= 4;
> -		WRITE(*reg, Rn);
> +		MWRITE(*reg, Rn);
>  		break;
>  	case 0x4056:
>  	case 0x4066:
> -		READ(*reg, Rn);
> +		MREAD(*reg, Rn);
>  		Rn += 4;
>  		break;
>  	default:
> 

This one no longer applies to Linus' tree:

glaubitz@node54:/data/home/glaubitz/linux> git am ../sh-patches-2021/\[PATCH\ 3_3\ v2\]\ sh\:\ fix\ READ_WRITE\ redefinition\ warnings.eml
Applying: sh: fix READ/WRITE redefinition warnings
error: patch failed: arch/sh/math-emu/math.c:51
error: arch/sh/math-emu/math.c: patch does not apply
Patch failed at 0001 sh: fix READ/WRITE redefinition warnings
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
glaubitz@node54:/data/home/glaubitz/linux>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
