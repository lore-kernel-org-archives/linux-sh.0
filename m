Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC7DC433EF
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 16:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiEYQOG (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 12:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiEYQOG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 12:14:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A4B41D3;
        Wed, 25 May 2022 09:14:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id t25so36774320lfg.7;
        Wed, 25 May 2022 09:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FuRnLqkxZX1XoQqzQ6fbAw2NRkC3Q8V0ituZ9djG+sg=;
        b=dmjQmErzRySILSpT53XcroDXdo+CzlIM4bQ1eHjCjSIK40tO92k+NYM5e/Sdia6NZp
         68Nvr0BjmHAv2PoaG5Ubjp+eFZA9rBt3VI/y40uTdDGBQHMy3dPSuJZWUNrqsd0MmqXw
         HBDLj9sRGNLDZ2Epnoy4843pjDquGsFC/BEHQ2bwOjZg46TrMNlcj9zRDyGsvFRw8dCV
         DKN+5NvzFwU9kizKZpMLeP7OtbWSCTaIK2yDgub9f0iY2UvynuUU5vNbAjeGdKUAUit9
         +RsTIy0U7/6wmu1aS9Qydztthwq9no1PVMaKwfVWIejoMhzmVyRDNOY8TcxUDX4J/guf
         5Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FuRnLqkxZX1XoQqzQ6fbAw2NRkC3Q8V0ituZ9djG+sg=;
        b=BsSd748fm27ZqTTs0LCKCN8634ZQlbde0oFkjUz17cPZOfIUGhULwuNKhcpAJKxSj1
         2O4DZC+b8aR6oXa6nCfJC27RQd7GMwsxjyQZZjWMBK6H6DkkF4jKgPuiUTD3lq0RRVxy
         1J+/aEyLywRG9ardEwrzpPWh+4erIfhKup9n6iw0WV78SorPYYTAOSI0IlGI4Jrq7AsW
         qJD0wDlMwRpJawT14JvC9Y9csTmj6Xy+cPUVFHlrO/R9rDl6ulF8yqL5xOoFpXfEV67S
         ZH7hvBXFmtyUETj3f78vaALTQvBX/b5ystqiQvwKZbfpEWd2XciezonW/HyExpCmfKlR
         2bfA==
X-Gm-Message-State: AOAM532D5uQLurkqcz3Djk8EwmIecKIcAQfldhO4VElhY6wPPEwK3arQ
        WWpMCrDxX1taDaQaL1nH92lOwihdWCY=
X-Google-Smtp-Source: ABdhPJyKPTY3beV8FKihcju6ARZ2ptuhITr+L4vlZyZBNaxyPOHTXoB8Lx5hWmwT72GYRkAz7aG7xA==
X-Received: by 2002:a05:6512:3d0f:b0:478:5897:5ea3 with SMTP id d15-20020a0565123d0f00b0047858975ea3mr16882506lfv.231.1653495243191;
        Wed, 25 May 2022 09:14:03 -0700 (PDT)
Received: from [192.168.1.103] ([178.176.76.139])
        by smtp.gmail.com with ESMTPSA id j9-20020ac25509000000b00477a7c8a0f0sm3172060lfk.295.2022.05.25.09.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 09:14:02 -0700 (PDT)
Subject: Re: [PATCH 2/4] sh: Kconfig.cpu: Fix indentation
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
 <20220525124007.45328-3-juerg.haefliger@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <0ef0b83b-64d5-82fa-0b31-fbf714c75470@gmail.com>
Date:   Wed, 25 May 2022 19:14:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220525124007.45328-3-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/25/22 3:40 PM, Juerg Haefliger wrote:

> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  arch/sh/Kconfig.cpu | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/Kconfig.cpu b/arch/sh/Kconfig.cpu
> index fff419f3d757..7b0bea483eab 100644
> --- a/arch/sh/Kconfig.cpu
> +++ b/arch/sh/Kconfig.cpu
> @@ -2,7 +2,7 @@
>  menu "Processor features"
>  
>  choice
> -	prompt "Endianness selection" 
> +	prompt "Endianness selection"

  You're not fixing indentation, you're fixing trailing whitespace
Please fix up your subject/description accordingly.

[...]

MBR, Sergey
