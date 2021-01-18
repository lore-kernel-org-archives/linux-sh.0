Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D80C433E0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B758322DA7
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbhARUJV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:09:21 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:55465 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388785AbhARUJG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 15:09:06 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1ap6-001t61-Tb; Mon, 18 Jan 2021 21:08:24 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1ap6-001eo0-9b; Mon, 18 Jan 2021 21:08:24 +0100
Subject: Re: [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro
To:     Jinyang He <hejinyang@loongson.cn>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <668e2039-b17e-64e3-30a9-ad019ba3af93@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 21:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1602474624-3225-1-git-send-email-hejinyang@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 10/12/20 5:50 AM, Jinyang He wrote:
> Fixes: 	e1cc9d8d596e ("sh: switch to copy_thread_tls()")
> Signed-off-by: Jinyang He <hejinyang@loongson.cn>
> ---
>  arch/sh/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d209271..165f291 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -30,7 +30,6 @@ config SUPERH
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_SECCOMP_FILTER
>  	select HAVE_ARCH_TRACEHOOK
> -	select HAVE_COPY_THREAD_TLS
>  	select HAVE_DEBUG_BUGVERBOSE
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DYNAMIC_FTRACE

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

