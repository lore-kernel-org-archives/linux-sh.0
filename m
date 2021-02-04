Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D643DC433E0
	for <linux-sh@archiver.kernel.org>; Thu,  4 Feb 2021 00:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B31964F55
	for <linux-sh@archiver.kernel.org>; Thu,  4 Feb 2021 00:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhBDA7w (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234366AbhBDA7s (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 Feb 2021 19:59:48 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CFC0613D6;
        Wed,  3 Feb 2021 16:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=0HeVTQ+ZGeks5Sti3IrPW/lfwuJJN8fuz7nNyWizFOE=; b=Ka0djaTGy5uImi1hQ8/bXZ5s75
        L/nwAJ23L/hV6+wWhm1MkgM5dA/TzlJmePp7DxjAUxv4d0uxeJjshKwLRS849RvuNwsrxAqt68J7o
        5Dvw0PrwuaKW6y3gdmbCuhMKhfIZCTIc36ZG78a92xoIwllrwLQXdnXsmtX7p+JuNan4+6YplIsmb
        sQVsFh6Ppv9+p893BkNzw1OVAA2CjcX3t3SOUxbV+JSGtm69jLeOGngVgT2EqvgnNJbivZVpDeCNt
        Ktj8LKXvtzWMD4VlMyZ3DqfAH4rbBGoHpnnDybGDzt+ZA5+bBnyuAi02ohV+eqMNfzg4cPyDv3o9j
        0QxN6UXg==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7SzA-0005OT-2T; Thu, 04 Feb 2021 00:59:04 +0000
Subject: Re: [PATCH V2] arch: sh: kernel: Fix a spelling archtecture to
 architecture in the file relocate_kernel.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210204005046.21462-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <934fea12-0d1f-fc4c-3f73-70874fa2e2ca@infradead.org>
Date:   Wed, 3 Feb 2021 16:59:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210204005046.21462-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 2/3/21 4:50 PM, Bhaskar Chowdhury wrote:
> 
> s/archtecture/architecture/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Changes from V1 :
>   Missed the changelog text,now included
> 
>  arch/sh/kernel/relocate_kernel.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_kernel.S
> index d9bf2b727b42..deda2f60a8f2 100644
> --- a/arch/sh/kernel/relocate_kernel.S
> +++ b/arch/sh/kernel/relocate_kernel.S
> @@ -3,7 +3,7 @@
>   * relocate_kernel.S - put the kernel image in place to boot
>   * 2005.9.17 kogiidena@eggplant.ddo.jp
>   *
> - * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
> + * LANDISK/sh4 is supported. Maybe, SH architecture works well.
>   *
>   * 2009-03-18 Magnus Damm - Added Kexec Jump support
>   */
> --
> 2.26.2
> 


-- 
~Randy

