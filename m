Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F82C433E0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159FD22CA1
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 18:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393787AbhARStL (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:49:11 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59337 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393782AbhARStJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 13:49:09 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1ZYX-001WqZ-Nn; Mon, 18 Jan 2021 19:47:13 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1ZYX-001ViE-05; Mon, 18 Jan 2021 19:47:13 +0100
Subject: Re: [PATCH] maple: fix wrong return value of maple_bus_init().
To:     Lu Wei <luwei32@huawei.com>, dalias@libc.org, lethal@linux-sh.org,
        adrian@mcmen.demon.co.uk, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201126024311.292908-1-luwei32@huawei.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <2fd68783-c1c3-7218-c83e-2f15a207ede0@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 19:47:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201126024311.292908-1-luwei32@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/26/20 3:43 AM, Lu Wei wrote:
> If KMEM_CACHE or maple_alloc_dev failed, the maple_bus_init() will return 0
> rather than error, because the retval is not changed after KMEM_CACHE or
> maple_alloc_dev failed.
> 
> Fixes: 17be2d2b1c33 ("sh: Add maple bus support for the SEGA Dreamcast.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Lu Wei <luwei32@huawei.com>
> ---
>  drivers/sh/maple/maple.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index e5d7fb81ad66..44a931d41a13 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -835,8 +835,10 @@ static int __init maple_bus_init(void)
>  
>  	maple_queue_cache = KMEM_CACHE(maple_buffer, SLAB_HWCACHE_ALIGN);
>  
> -	if (!maple_queue_cache)
> +	if (!maple_queue_cache) {
> +		retval = -ENOMEM;
>  		goto cleanup_bothirqs;
> +	}
>  
>  	INIT_LIST_HEAD(&maple_waitq);
>  	INIT_LIST_HEAD(&maple_sentq);
> @@ -849,6 +851,7 @@ static int __init maple_bus_init(void)
>  		if (!mdev[i]) {
>  			while (i-- > 0)
>  				maple_free_dev(mdev[i]);
> +			retval = -ENOMEM;
>  			goto cleanup_cache;
>  		}
>  		baseunits[i] = mdev[i];
> 

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

