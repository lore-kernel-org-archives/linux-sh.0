Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7EC4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 08:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjKNIoo (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 03:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjKNIon (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 03:44:43 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70D1AC
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:44:39 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a3b8b113so7512911e87.0
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699951477; x=1700556277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alsjgVukxAaaCRca5VGVXkwLAgcro42wCnZAne3nZjU=;
        b=IKvEJVjQc4U3T4h3XnyU7asmc7nbCfSdniOba7+i6AYP7eeaygtGpQ9W0svr6GI8w9
         dKf/L2rZ68BPU/xKoxr7fFWpJElnx6ZPkhjZe9cQhMjGa0/RiIxsqIC72pPWyXyL4lOw
         hlEk4RdTKORLDxzkYCj8slF0y/aQf/pc5OdTPkxDRxR1/63CrTpL8X8A7c9BhKkdGtYQ
         J5GpA0OMyTYvoEenohFU9qRGOvziUjOPgYczStE6SAZSTPamtf/YP3Ok6at+AVqLOJuk
         /Ts+22CIuwavgIdKshaUET3ojoa8IImh5pHQSUHNPWcxIaDsouH2upmvxgEDfBuy8gN9
         +/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699951477; x=1700556277;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=alsjgVukxAaaCRca5VGVXkwLAgcro42wCnZAne3nZjU=;
        b=gFqaw8oY9laekdapD6CmBS2oRpQI1Rnb2QHSA4be/NiaLt/Fqtn1DS+sc6RmMP0Rn8
         OX0RBmfjDwugQZJuWeQI1kbqxkzHRSEPlHtXxNfRDezKf4am7JcrY46KrsTFfP5ClOAs
         9YfEivyYb9ZmZrOoJJSdsFV+5BRPpPqrVVDYClOG+3kvRSYhIYLMxOZhsb/LOS1Z0za8
         S7sjzXchA+ZZ53IpKvyWJtpXUFFE1KuPeEmMyXmIgMJMDQZvaF3Xw/U+Qbdi7SzCfD7n
         kBn29PlERPeJBd7AzxHtMVvxvYoaNA3Wl/GCvu29DmvCd2m3UP2XqKU+AG94nyB3xY2R
         tzKg==
X-Gm-Message-State: AOJu0Yx21a/1sUupyNWSP1XfgToFjkID5y7wFs8Sf3UU5CN9BfCTzPd0
        dWnjtbtbioarhdWlo0uj0aN3kK+xoXw=
X-Google-Smtp-Source: AGHT+IF0GWwIa/uKhnPG0eflGMIj1Ext006rI7C4pc7m7sC4OLVvi3mX3gSwxpe2imbqK9lBig8N8A==
X-Received: by 2002:a19:7507:0:b0:509:4559:27a9 with SMTP id y7-20020a197507000000b00509455927a9mr5866700lfe.8.1699951477113;
        Tue, 14 Nov 2023 00:44:37 -0800 (PST)
Received: from [192.168.1.103] ([178.176.75.241])
        by smtp.gmail.com with ESMTPSA id s30-20020a195e1e000000b005079a3c872esm1268987lfb.240.2023.11.14.00.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 00:44:36 -0800 (PST)
Subject: Re: [PATCH v4 01/37] sh: passing FDT address to kernel startup.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <3b24a5ce5ecd00f8d48654ee2eff8340e2827169.1699856600.git.ysato@users.sourceforge.jp>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <ae70a113-f37c-c2c7-306e-53b7c169f403@gmail.com>
Date:   Tue, 14 Nov 2023 11:44:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <3b24a5ce5ecd00f8d48654ee2eff8340e2827169.1699856600.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/14/23 10:59 AM, Yoshinori Sato wrote:

> R4 is caller saved in SH ABI.
> Save it so it doesn't get corrupted until it's needed for initialization.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boot/compressed/head_32.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
> index 7bb168133dbb..b5ff297145b6 100644
> --- a/arch/sh/boot/compressed/head_32.S
> +++ b/arch/sh/boot/compressed/head_32.S
> @@ -15,7 +15,8 @@ startup:
>  	/* Load initial status register */
>  	mov.l   init_sr, r1
>  	ldc     r1, sr
> -
> +	/* Save FDT address */
> +	mov	r4, r13
>  	/* Move myself to proper location if necessary */
>  	mova	1f, r0
>  	mov.l	1f, r2
> @@ -84,7 +85,7 @@ l1:
>  	/* Jump to the start of the decompressed kernel */
>  	mov.l	kernel_start_addr, r0
>  	jmp	@r0
> -	nop
> +	 mov	r13,r4

   Space after comma still missing...

[...]

MBR, Sergey
