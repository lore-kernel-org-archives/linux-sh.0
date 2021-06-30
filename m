Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F8BC11F65
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E305961CAD
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhF3JfK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:35:10 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56483 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233911AbhF3JfJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Jun 2021 05:35:09 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lyWaB-001vyl-MJ; Wed, 30 Jun 2021 11:32:35 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lyWaB-0012uY-DW; Wed, 30 Jun 2021 11:32:35 +0200
Subject: Re: [PATCH 1/3 v2] sh: fix kconfig unmet dependency warning for
 FRAME_POINTER
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matt Fleming <matt@console-pimps.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <20210627220544.8757-2-rdunlap@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <e1f5e3c2-67da-429a-4382-f011c8cd9655@physik.fu-berlin.de>
Date:   Wed, 30 Jun 2021 11:32:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627220544.8757-2-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/28/21 12:05 AM, Randy Dunlap wrote:
> FRAME_POINTER depends on DEBUG_KERNEL so DWARF_UNWINDER should
> depend on DEBUG_KERNEL before selecting FRAME_POINTER.
> 
> WARNING: unmet direct dependencies detected for FRAME_POINTER
>   Depends on [n]: DEBUG_KERNEL [=n] && (M68K || UML || SUPERH [=y]) || ARCH_WANT_FRAME_POINTERS [=n]
>   Selected by [y]:
>   - DWARF_UNWINDER [=y]
> 
> Fixes: bd353861c735 ("sh: dwarf unwinder support.")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2: drop Paul Mundt from Cc: list;
>     add this previously sent patch to the series;
>     add more Cc's;
> 
>  arch/sh/Kconfig.debug |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20210625.orig/arch/sh/Kconfig.debug
> +++ linux-next-20210625/arch/sh/Kconfig.debug
> @@ -57,6 +57,7 @@ config DUMP_CODE
>  
>  config DWARF_UNWINDER
>  	bool "Enable the DWARF unwinder for stacktraces"
> +	depends on DEBUG_KERNEL
>  	select FRAME_POINTER
>  	default n
>  	help
> 

Boot-tested on my SH-7785LCR without any issues (as expected).

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
