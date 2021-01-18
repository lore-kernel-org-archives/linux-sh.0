Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA79C433E0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 17:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B91622C9E
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393603AbhARR2R (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 12:28:17 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:48733 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393730AbhARR2C (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 12:28:02 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1YJE-0016xF-Iv; Mon, 18 Jan 2021 18:27:20 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1YJD-001Lj5-Rm; Mon, 18 Jan 2021 18:27:20 +0100
Subject: Re: [PATCH 1/2] sh: boot: add intermediate vmlinux.bin* to targets
 instead of extra-y
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210117111632.2392635-1-masahiroy@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <55b6adf4-e95a-cfd8-447f-4a11f6a1f3b9@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 18:27:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210117111632.2392635-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/17/21 12:16 PM, Masahiro Yamada wrote:
> You do not need to build all of vmlinux.bin*
> 
> They are built on demand as prerequsites of uImage.bin*, hence should
> be added to targets instead of extra-y.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/sh/boot/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
> index 58592dfa5cb6..dded61296c9a 100644
> --- a/arch/sh/boot/Makefile
> +++ b/arch/sh/boot/Makefile
> @@ -27,8 +27,8 @@ suffix-$(CONFIG_KERNEL_XZ)	:= xz
>  suffix-$(CONFIG_KERNEL_LZO)	:= lzo
>  
>  targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz \
> -	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin
> -extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> +	   uImage.bz2 uImage.lzma uImage.xz uImage.lzo uImage.bin \
> +	   vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  	   vmlinux.bin.xz vmlinux.bin.lzo
>  subdir- := compressed romimage

Successfully boot-tested on my SH-7785LCR. No regressions.

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

