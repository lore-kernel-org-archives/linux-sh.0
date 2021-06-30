Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E535BC11F65
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 19:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C564A613ED
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 19:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhF3TgF (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Jun 2021 15:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhF3TgF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Jun 2021 15:36:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB9FC061756;
        Wed, 30 Jun 2021 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=h1HKpdFt57m/IR7DT+L+iCTEOgN2fLV6XAOnfPyMLd8=; b=Omg5C+f/caQ4Ez8s67jrjJw2NV
        ZPaQtiHSdMzLCt1Qgcp6139b2pTawusc2VuhRhmZy+BZycQAZItbUaAiNYoA8ZcIslLRRclW3E3+Z
        q3mD2Lg2YD9Se4WRkemJeDXjZoi2IzJhzAt9Swo0341O7Z3UDf1xa4Sw8LT06+WlCGtPhrIi9GKdq
        EzpMpIF5toFsZmEnB4vv0euY6Hk+MQKpSEtVyBR2WKelOetmH19XVJrIFBpg4fYlW65gzcuGmWcEH
        HZc2n/qGpMswvkC/aX6gmvFvlQs+nAQpiLpDTqvEvlE7rDNFdbNeNbwuZFQJ0ySuvjXZF1gE9Kk9w
        ExNBOfWw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lyfxd-00F7cH-Im; Wed, 30 Jun 2021 19:33:28 +0000
Subject: Re: [PATCH 3/3 v2] sh: fix READ/WRITE redefinition warnings
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Takashi YOSHII <takasi-y@ops.dti.ne.jp>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <20210627220544.8757-4-rdunlap@infradead.org>
 <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8efd6e1d-9949-9598-9e6b-41d9b2f4ea7a@infradead.org>
Date:   Wed, 30 Jun 2021 12:33:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6af41806-e715-4084-418f-4a8924d26c07@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/30/21 2:36 AM, John Paul Adrian Glaubitz wrote:
> On 6/28/21 12:05 AM, Randy Dunlap wrote:
>> kernel.h defines READ and WRITE, so rename the SH math-emu macros
>> to MREAD and MWRITE.
>>
>> Fixes these warnings:
>>
>> ../arch/sh/math-emu/math.c:54: warning: "WRITE" redefined
>>    54 | #define WRITE(d,a) ({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>> In file included from ../arch/sh/math-emu/math.c:10:
>> ../include/linux/kernel.h:37: note: this is the location of the previous definition
>>    37 | #define WRITE   1
>> ../arch/sh/math-emu/math.c:55: warning: "READ" redefined
>>    55 | #define READ(d,a) ({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>> In file included from ../arch/sh/math-emu/math.c:10:
>> ../include/linux/kernel.h:36: note: this is the location of the previous definition
>>    36 | #define READ   0
>>
>> Fixes: 4b565680d163 ("sh: math-emu support")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> Cc: Takashi YOSHII <takasi-y@ops.dti.ne.jp>
>> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2: renumber patches, otherwise no change;
>>
>>  arch/sh/math-emu/math.c |   44 +++++++++++++++++++-------------------
>>  1 file changed, 22 insertions(+), 22 deletions(-)
>>
>> --- linux-next-20210625.orig/arch/sh/math-emu/math.c
>> +++ linux-next-20210625/arch/sh/math-emu/math.c
>> @@ -51,8 +51,8 @@
>>  #define Rn	(regs->regs[n])
>>  #define Rm	(regs->regs[m])
>>  
>> -#define WRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>> -#define READ(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>> +#define MWRITE(d,a)	({if(put_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>> +#define MREAD(d,a)	({if(get_user(d, (typeof (d) __user *)a)) return -EFAULT;})
>>  
>>  #define PACK_S(r,f)	FP_PACK_SP(&r,f)
>>  #define UNPACK_S(f,r)	FP_UNPACK_SP(f,&r)
>> @@ -157,11 +157,11 @@ fmov_idx_reg(struct sh_fpu_soft_struct *
>>  {
>>  	if (FPSCR_SZ) {
>>  		FMOV_EXT(n);
>> -		READ(FRn, Rm + R0 + 4);
>> +		MREAD(FRn, Rm + R0 + 4);
>>  		n++;
>> -		READ(FRn, Rm + R0);
>> +		MREAD(FRn, Rm + R0);
>>  	} else {
>> -		READ(FRn, Rm + R0);
>> +		MREAD(FRn, Rm + R0);
>>  	}
>>  
>>  	return 0;
>> @@ -173,11 +173,11 @@ fmov_mem_reg(struct sh_fpu_soft_struct *
>>  {
>>  	if (FPSCR_SZ) {
>>  		FMOV_EXT(n);
>> -		READ(FRn, Rm + 4);
>> +		MREAD(FRn, Rm + 4);
>>  		n++;
>> -		READ(FRn, Rm);
>> +		MREAD(FRn, Rm);
>>  	} else {
>> -		READ(FRn, Rm);
>> +		MREAD(FRn, Rm);
>>  	}
>>  
>>  	return 0;
>> @@ -189,12 +189,12 @@ fmov_inc_reg(struct sh_fpu_soft_struct *
>>  {
>>  	if (FPSCR_SZ) {
>>  		FMOV_EXT(n);
>> -		READ(FRn, Rm + 4);
>> +		MREAD(FRn, Rm + 4);
>>  		n++;
>> -		READ(FRn, Rm);
>> +		MREAD(FRn, Rm);
>>  		Rm += 8;
>>  	} else {
>> -		READ(FRn, Rm);
>> +		MREAD(FRn, Rm);
>>  		Rm += 4;
>>  	}
>>  
>> @@ -207,11 +207,11 @@ fmov_reg_idx(struct sh_fpu_soft_struct *
>>  {
>>  	if (FPSCR_SZ) {
>>  		FMOV_EXT(m);
>> -		WRITE(FRm, Rn + R0 + 4);
>> +		MWRITE(FRm, Rn + R0 + 4);
>>  		m++;
>> -		WRITE(FRm, Rn + R0);
>> +		MWRITE(FRm, Rn + R0);
>>  	} else {
>> -		WRITE(FRm, Rn + R0);
>> +		MWRITE(FRm, Rn + R0);
>>  	}
>>  
>>  	return 0;
>> @@ -223,11 +223,11 @@ fmov_reg_mem(struct sh_fpu_soft_struct *
>>  {
>>  	if (FPSCR_SZ) {
>>  		FMOV_EXT(m);
>> -		WRITE(FRm, Rn + 4);
>> +		MWRITE(FRm, Rn + 4);
>>  		m++;
>> -		WRITE(FRm, Rn);
>> +		MWRITE(FRm, Rn);
>>  	} else {
>> -		WRITE(FRm, Rn);
>> +		MWRITE(FRm, Rn);
>>  	}
>>  
>>  	return 0;
>> @@ -240,12 +240,12 @@ fmov_reg_dec(struct sh_fpu_soft_struct *
>>  	if (FPSCR_SZ) {
>>  		FMOV_EXT(m);
>>  		Rn -= 8;
>> -		WRITE(FRm, Rn + 4);
>> +		MWRITE(FRm, Rn + 4);
>>  		m++;
>> -		WRITE(FRm, Rn);
>> +		MWRITE(FRm, Rn);
>>  	} else {
>>  		Rn -= 4;
>> -		WRITE(FRm, Rn);
>> +		MWRITE(FRm, Rn);
>>  	}
>>  
>>  	return 0;
>> @@ -445,11 +445,11 @@ id_sys(struct sh_fpu_soft_struct *fregs,
>>  	case 0x4052:
>>  	case 0x4062:
>>  		Rn -= 4;
>> -		WRITE(*reg, Rn);
>> +		MWRITE(*reg, Rn);
>>  		break;
>>  	case 0x4056:
>>  	case 0x4066:
>> -		READ(*reg, Rn);
>> +		MREAD(*reg, Rn);
>>  		Rn += 4;
>>  		break;
>>  	default:
>>
> 
> This one no longer applies to Linus' tree:
> 
> glaubitz@node54:/data/home/glaubitz/linux> git am ../sh-patches-2021/\[PATCH\ 3_3\ v2\]\ sh\:\ fix\ READ_WRITE\ redefinition\ warnings.eml
> Applying: sh: fix READ/WRITE redefinition warnings
> error: patch failed: arch/sh/math-emu/math.c:51
> error: arch/sh/math-emu/math.c: patch does not apply
> Patch failed at 0001 sh: fix READ/WRITE redefinition warnings
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> glaubitz@node54:/data/home/glaubitz/linux>

OK. Thanks for all of the testing.

-- 
~Randy

