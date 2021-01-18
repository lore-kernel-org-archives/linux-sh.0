Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC531C433DB
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B472225E
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 18:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407291AbhARSjx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:39:53 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:54447 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729629AbhARSjk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 13:39:40 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1ZQE-001UUh-Oj; Mon, 18 Jan 2021 19:38:38 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1ZQE-001UoU-4V; Mon, 18 Jan 2021 19:38:38 +0100
Subject: Re: [PATCH] arch: sh: remove duplicate include
To:     Wang Qing <wangqing@vivo.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <623ffd16-2737-7bf6-bf1d-9c7ab1381c31@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 19:38:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1604889952-30841-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/9/20 3:45 AM, Wang Qing wrote:
> Remove duplicate header which is included twice.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  arch/sh/kernel/cpu/sh3/entry.S | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.S
> index 25eb809..e48b3dd
> --- a/arch/sh/kernel/cpu/sh3/entry.S
> +++ b/arch/sh/kernel/cpu/sh3/entry.S
> @@ -14,7 +14,6 @@
>  #include <cpu/mmu_context.h>
>  #include <asm/page.h>
>  #include <asm/cache.h>
> -#include <asm/thread_info.h>
>  
>  ! NOTE:
>  ! GNU as (as of 2.9.1) changes bf/s into bt/s and bra, when the address

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

