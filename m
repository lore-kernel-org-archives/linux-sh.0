Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13135C11F65
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E513661CA3
	for <linux-sh@archiver.kernel.org>; Wed, 30 Jun 2021 09:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbhF3Jhj (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 30 Jun 2021 05:37:39 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51537 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233653AbhF3Jhj (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 30 Jun 2021 05:37:39 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lyWcg-001x23-39; Wed, 30 Jun 2021 11:35:10 +0200
Received: from p57bd964c.dip0.t-ipconnect.de ([87.189.150.76] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lyWcf-0013GZ-Sr; Wed, 30 Jun 2021 11:35:10 +0200
Subject: Re: [PATCH 2/3 v2] sh: define __BIG_ENDIAN for math-emu
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20210627220544.8757-1-rdunlap@infradead.org>
 <20210627220544.8757-3-rdunlap@infradead.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <7126f059-baaa-0bd6-68ea-c4a24827592e@physik.fu-berlin.de>
Date:   Wed, 30 Jun 2021 11:35:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627220544.8757-3-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.150.76
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 6/28/21 12:05 AM, Randy Dunlap wrote:
> Fix this by defining both ENDIAN macros in
> <asm/sfp-machine.h> so that they can be utilized in
> <math-emu/soft-fp.h> according to the latter's comment:
> /* Allow sfp-machine to have its own byte order definitions. */
> 
> (This is what is done in arch/nds32/include/asm/sfp-machine.h.)
> 
> This placates these build warnings:
> 
> In file included from ../arch/sh/math-emu/math.c:23:
> ../include/math-emu/single.h:50:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>    50 | #if __BYTE_ORDER == __BIG_ENDIAN
> In file included from ../arch/sh/math-emu/math.c:24:
> ../include/math-emu/double.h:59:21: warning: "__BIG_ENDIAN" is not defined, evaluates to 0 [-Wundef]
>    59 | #if __BYTE_ORDER == __BIG_ENDIAN
> 
> Fixes: 4b565680d163 ("sh: math-emu support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: linux-sh@vger.kernel.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2: use same preprocessor method that nds32 does;
>     add Geert's Reviewed-by;
>     renumber patches;
>     add more Cc's;
> 
>  arch/sh/include/asm/sfp-machine.h |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- linux-next-20210625.orig/arch/sh/include/asm/sfp-machine.h
> +++ linux-next-20210625/arch/sh/include/asm/sfp-machine.h
> @@ -13,6 +13,14 @@
>  #ifndef _SFP_MACHINE_H
>  #define _SFP_MACHINE_H
>  
> +#ifdef __BIG_ENDIAN__
> +#define __BYTE_ORDER __BIG_ENDIAN
> +#define __LITTLE_ENDIAN 0
> +#else
> +#define __BYTE_ORDER __LITTLE_ENDIAN
> +#define __BIG_ENDIAN 0
> +#endif
> +
>  #define _FP_W_TYPE_SIZE		32
>  #define _FP_W_TYPE		unsigned long
>  #define _FP_WS_TYPE		signed long
> 

Boot-tested on my SH-7785LCR without any issues.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
