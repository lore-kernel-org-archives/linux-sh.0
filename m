Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F6C43381
	for <linux-sh@archiver.kernel.org>; Mon, 25 Jan 2021 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A9522240
	for <linux-sh@archiver.kernel.org>; Mon, 25 Jan 2021 10:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbhAYKHy (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 25 Jan 2021 05:07:54 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:32263 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbhAYKCg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 25 Jan 2021 05:02:36 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 05:02:34 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1611568669;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:From:
        Subject:Sender;
        bh=RKpYXMZtHAVytssmr8eSFrV8Qp7aV1k2+6gtB3yYm8M=;
        b=cfYZjtADTTRTcB9qqhsk8e5QMUJPAYiZEN7Ge7w7vI/+paftbLWxu+WNRx0Zvc2qwu
        47Oc5gTY+MZL5WQBcn8HN96NXJADyeApvp4mUaSh+xduQT4y7zHH7kjHBGr3tjyQUGPn
        Ks4tANsQG9RjL2tDrXBQsID+dtUO/yxnfzgTIcmNxGrp0IQhXBKyKpKXCv0pU6FhniGz
        9sC4EA8RczeTRQaG8dwySlASJyOEgag7sRe3+NNLZGrye77yuNtFz/VNHbu8t79VeKY7
        Lp8ArtWWnYWpsqexjh09UdtsEHA63MG62nsCExM5mcoP0yNw2Biu8aycOAnHqcIL61Wi
        Bl+g==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR/J8xty10="
X-RZG-CLASS-ID: mo00
Received: from [192.168.10.137]
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id k075acx0P9pSxEa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 25 Jan 2021 10:51:28 +0100 (CET)
Subject: Re: [PATCH] sh: fix sparse annotation in SH's __get_user_check()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210123173237.91670-1-luc.vanoostenryck@gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <3ad4b001-0aed-bbca-b57a-9957091b64e7@hartkopp.net>
Date:   Mon, 25 Jan 2021 10:51:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123173237.91670-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 23.01.21 18:32, Luc Van Oostenryck wrote:
> The pointer in get_user() and friends is supposed to be a __user pointer.
> But in SH's implementation of __get_user_check(), the pointer is
> assigned to a local variable __gu_addr which is lacking the __user
> annotation. As consequence, a warning is issued for every of its uses.
> 
> So, add the missing __user annotation (this remove ~700 warnings when
> using defconfig).

Many thanks that you were able to spot this issue, Luc!

Best regards,
Oliver

> 
> Link: https://lore.kernel.org/r/202101141753.ropIZ9nh-lkp@intel.com
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>   arch/sh/include/asm/uaccess.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
> index 73f3b48d4a34..e2623fe2ac09 100644
> --- a/arch/sh/include/asm/uaccess.h
> +++ b/arch/sh/include/asm/uaccess.h
> @@ -68,7 +68,7 @@ struct __large_struct { unsigned long buf[100]; };
>   ({									\
>   	long __gu_err = -EFAULT;					\
>   	unsigned long __gu_val = 0;					\
> -	const __typeof__(*(ptr)) *__gu_addr = (ptr);			\
> +	const __typeof__(*(ptr)) __user *__gu_addr = (ptr);		\
>   	if (likely(access_ok(__gu_addr, (size))))		\
>   		__get_user_size(__gu_val, __gu_addr, (size), __gu_err);	\
>   	(x) = (__force __typeof__(*(ptr)))__gu_val;			\
> 
> base-commit: 5c8fe583cce542aa0b84adc939ce85293de36e5e
> 
