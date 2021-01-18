Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF03C43381
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15D822D49
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390173AbhARUHC (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:07:02 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47487 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394159AbhARUGL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 15:06:11 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1amH-001sJb-0B; Mon, 18 Jan 2021 21:05:28 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1amG-001eR9-7v; Mon, 18 Jan 2021 21:05:28 +0100
Subject: Re: [PATCH] sh: kernel: traps: remove unused variable
To:     Anders Roxell <anders.roxell@linaro.org>,
        ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201210124422.3858524-1-anders.roxell@linaro.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <0c036e4f-837c-c854-ef28-24cb55153a55@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 21:05:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201210124422.3858524-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 12/10/20 1:44 PM, Anders Roxell wrote:
> When building defconfig the following warning shows up:
> 
> arch/sh/kernel/traps.c: In function 'nmi_trap_handler':
> arch/sh/kernel/traps.c:183:15: warning: unused variable 'cpu' [-Wunused-variable]
>   unsigned int cpu = smp_processor_id();
>                ^~~
> 
> Remove an unused variable 'cpu'.
> 
> Fixes: fe3f1d5d7cd3 ("sh: Get rid of nmi_count()")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/sh/kernel/traps.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
> index f5beecdac693..e76b22157099 100644
> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
> @@ -180,7 +180,6 @@ static inline void arch_ftrace_nmi_exit(void) { }
>  
>  BUILD_TRAP_HANDLER(nmi)
>  {
> -	unsigned int cpu = smp_processor_id();
>  	TRAP_HANDLER_DECL;
>  
>  	arch_ftrace_nmi_enter();

Good catch. Now I have one warning less when building the kernel for my SH-7785LCR ;-).

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

