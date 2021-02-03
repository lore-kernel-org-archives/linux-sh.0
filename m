Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033E4C433DB
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC50964F41
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 17:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhBCR7c (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 Feb 2021 12:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhBCR71 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 Feb 2021 12:59:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6BC0613ED;
        Wed,  3 Feb 2021 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=7mrOlF9oQUMuUA5cuK1fXu1TKdZcT6QXDxMY3y52duY=; b=I2TC9mcaJ7H9jng9XYs+DqERU7
        wAFA2yHUU4T3ugdmS8q1rKLsfkrxuy11BOAnUEKnTtxEXFaf0+7GhxD1DeCJ72A4cAeQFzNIc4itY
        +oMnOsvZckmIFbEhtp5SdS5TU2GoSo7QH8cDv7gTud75vJUZkBsqsX3BumiS2wZ/UHMtu9i0LJoBt
        KkgJ2snENJfs4aDA0ckWtJ/nVa8Gkvr9SQV3qm97arvOVYr26UDdA2si5PHl70E9ickh6fQF9iSyW
        leGhEK9Qi4i2GSjpnp5xEt4QbHVyDZSFYiDTWPWDlwdBqeiy5+EiS9fMUk/D/MC9rqMEIkIf5lMQH
        vyL2H0Qw==;
Received: from [2601:1c0:6280:3f0::aec2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l7MQL-00034I-Ka; Wed, 03 Feb 2021 17:58:41 +0000
Subject: Re: [PATCH] arch: sh: kernel: Change to correct spelling archtecture
 to architecture in the file relocate_kernel.S
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210203152521.16776-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31ad117d-b025-2214-cccb-deeaee6036be@infradead.org>
Date:   Wed, 3 Feb 2021 09:58:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210203152521.16776-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 2/3/21 7:25 AM, Bhaskar Chowdhury wrote:

Normally a patch description is required <here>.

If the patch committer wants to take it as is, the typo
fix LGTM.

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
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

-- 
~Randy

