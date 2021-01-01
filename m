Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B6C433DB
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 13:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D280221FE
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 13:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbhAANvJ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 08:51:09 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:45561 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbhAANvJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 08:51:09 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kvKp0-001cjd-BP; Fri, 01 Jan 2021 14:50:25 +0100
Received: from p5b13a2ad.dip0.t-ipconnect.de ([91.19.162.173] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kvKoz-003BdA-JL; Fri, 01 Jan 2021 14:50:25 +0100
Subject: Re: [PATCH] sh: check return code of request_irq
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201212161831.GA28098@roeck-us.net>
 <20201222205402.2269377-1-ndesaulniers@google.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <fe77cdc9-7ef1-a300-259b-65b451b2551a@physik.fu-berlin.de>
Date:   Fri, 1 Jan 2021 14:50:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222205402.2269377-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.173
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Nick!

On 12/22/20 9:54 PM, Nick Desaulniers wrote:
> request_irq is marked __must_check, but the call in shx3_prepare_cpus
> has a void return type, so it can't propagate failure to the caller.
> Follow cues from hexagon and just print an error.
> 
> Fixes: c7936b9abcf5 ("sh: smp: Hook in to the generic IPI handler for SH-X3 SMP.")
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/sh/kernel/cpu/sh4a/smp-shx3.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
> index f8a2bec0f260..1261dc7b84e8 100644
> --- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
> +++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
> @@ -73,8 +73,9 @@ static void shx3_prepare_cpus(unsigned int max_cpus)
>  	BUILD_BUG_ON(SMP_MSG_NR >= 8);
>  
>  	for (i = 0; i < SMP_MSG_NR; i++)
> -		request_irq(104 + i, ipi_interrupt_handler,
> -			    IRQF_PERCPU, "IPI", (void *)(long)i);
> +		if (request_irq(104 + i, ipi_interrupt_handler,
> +			    IRQF_PERCPU, "IPI", (void *)(long)i))
> +			pr_err("Failed to request irq %d\n", i);
>  
>  	for (i = 0; i < max_cpus; i++)
>  		set_cpu_present(i, true);
> 

Verified on my SH-7785LCR board. Boots fine.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

