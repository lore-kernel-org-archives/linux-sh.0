Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B18CDB465
	for <linux-sh@archiver.kernel.org>; Sat, 14 Oct 2023 17:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjJNRLN (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Oct 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNRLN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Oct 2023 13:11:13 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD1B7
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 10:11:11 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso6566021fa.1
        for <linux-sh@vger.kernel.org>; Sat, 14 Oct 2023 10:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697303469; x=1697908269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnpFYxcYbX/wkh2C1lVXSa7KxQnZsX9geyIhDRGDPtg=;
        b=kug36SsNLSS9NvYGHVLmE7H1U4YO1tVK9SmVYTPVN0sNycCjGQJj5v3ZXFM0BV8jER
         PjuLsMME6wYbQq8w0lV/B7G/kVNKB9zTcgMRPx9JkJji4RdCyJFFqqRwt9OWahxo6XwO
         RDJJ+/iGVmYb81MzBxy02J9uWUS8jOp2nt0DjDqa8QU0Z/8cnhDGMpG51dLLoI4CMcMl
         QNZh9qhvDrWd+PYpMgzkRzAdjZhHpFs9t3+7CASI0uaDrBJsMyEakyFJaxlGMz7dZt2u
         yQvJwIU+EY41nqvHhVUyM4wy8wd0/qDI8rO4CeodbjArM5I5LEXcZNlW6xr6cTiWgnHR
         dfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697303469; x=1697908269;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xnpFYxcYbX/wkh2C1lVXSa7KxQnZsX9geyIhDRGDPtg=;
        b=gu8b5tE4spVJD9HS7AJTnChrvFa2sCnwmKPVQkxz7l9+dcUIojQPRuj2Nq2BgYWyW7
         AKyXnZK5rb3lmhjpP9p5wpPYQf4wx8jiAMtFvmOThKHavnwx2NVytJ8iQ18dEJt5RCJO
         L3rsqkF7lSNLlHroBXtveVmro3BNdGYITqD3dOliv53h4tit+aQDN3NJJO4Le1I5z14j
         JdbOK0i4oX1XrcNu9zid1hF0JgRl/lzSmXYuJ1qkyYJy7ijlk3y6HJ0fdiMq323ZL8Vm
         wSaaLcP1O2jrLF88OPHRgRYzxkrmrNtSpNYNEVNh+1y516natVCoc2zR79nsbaKEgUc0
         bjrQ==
X-Gm-Message-State: AOJu0Yw0ZGp2ExADWn/3j5MuLEy11MpFmcWTLbfHUqUpw3ZATTdwKAg6
        21LOV6Fw9RCd4lSe9gSknngQAQZd3C8=
X-Google-Smtp-Source: AGHT+IF6eHeWrHKi+0MSeSs/GK+2hrXY9vaKpYWpb6bis9qr46wDjMNsS404Ef0iiYQxJVgt27bqUg==
X-Received: by 2002:a2e:b896:0:b0:2c5:72e:6ff7 with SMTP id r22-20020a2eb896000000b002c5072e6ff7mr4194541ljp.24.1697303469087;
        Sat, 14 Oct 2023 10:11:09 -0700 (PDT)
Received: from [192.168.1.103] ([31.173.84.69])
        by smtp.gmail.com with ESMTPSA id c9-20020a2e9d89000000b002b9ef00b10csm446249ljj.2.2023.10.14.10.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Oct 2023 10:11:08 -0700 (PDT)
Subject: Re: [RFC PATCH v3 01/35] arch/sh/boot/compressed/head_32.S: passing
 FDT address to initialize function.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <ab4b20d4e37c0dc2f3baafc5a72971fc475db5fc.1697199949.git.ysato@users.sourceforge.jp>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <785bec80-7ffa-ed85-9b4f-87a68cc62abf@gmail.com>
Date:   Sat, 14 Oct 2023 20:11:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ab4b20d4e37c0dc2f3baafc5a72971fc475db5fc.1697199949.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 10/14/23 5:53 PM, Yoshinori Sato wrote:

> R4 is caller saved in SH ABI.
> Save it so it doesn't get corrupted until it's needed for initialization.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boot/compressed/head_32.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boot/compressed/head_32.S b/arch/sh/boot/compressed/head_32.S
> index 7bb168133dbb..c5227ef636c3 100644
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
> +	  mov	r13,r4

   I thought the usual convention for the delay slots is to do extra indentation
with 1 space, no? And you need a space after comma too... :-)

[...]

MBR, Sergey
