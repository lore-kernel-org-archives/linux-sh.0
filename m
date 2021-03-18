Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59307C433E0
	for <linux-sh@archiver.kernel.org>; Thu, 18 Mar 2021 18:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9F664F4D
	for <linux-sh@archiver.kernel.org>; Thu, 18 Mar 2021 18:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhCRSQO (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 18 Mar 2021 14:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhCRSQH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 18 Mar 2021 14:16:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32A1C06174A;
        Thu, 18 Mar 2021 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=gZMZdjXDN+l4F4l9qVN7E8hE4ihLPn0kW+X8DcE+T3Q=; b=sn9QwGb2fP4kn8z6VZtkUIiQT6
        sND2fITDKmAjG6oK4FrdSMkziZm7HNnyXUn1+povLrVJeSFaBXMYTvOyEDg/E86g4vVoFZrpNc4zm
        KROQ7sfVGZxERAf/GAydMsrV4h4dDl2kscRc5JMe1DOHZeuuTvExOZpvQYa7DdatGURauHBF1WEbw
        XH04s8uLixrY0/jR/BlXJJbWlq74tDnYovxdFRgMTmZ1Bl5v7V4JMoSQd7eu91e32El3y+76Ptrlm
        005X5XEO0ZPoIcjUcFM7M6yga4/6POYmyuTpu3gdBDzavvHfA9TO6qdw0Xpq2HTZAdAHjt90cfxal
        IJz/+2Ag==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMxBR-003Kxv-0F; Thu, 18 Mar 2021 18:15:51 +0000
Subject: Re: [PATCH] sh: kernel: Fix a typo
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210318104437.21793-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c57bc4b-7ee9-547d-cb31-3e8f47432659@infradead.org>
Date:   Thu, 18 Mar 2021 11:15:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318104437.21793-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 3/18/21 3:44 AM, Bhaskar Chowdhury wrote:
> 
> s/archtecture/architecture/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

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


-- 
~Randy

