Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A33CC43462
	for <linux-sh@archiver.kernel.org>; Thu,  6 May 2021 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABEF613E3
	for <linux-sh@archiver.kernel.org>; Thu,  6 May 2021 11:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhEFL5Q (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 6 May 2021 07:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbhEFL5P (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 6 May 2021 07:57:15 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065E3C061574
        for <linux-sh@vger.kernel.org>; Thu,  6 May 2021 04:56:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso4636921oti.2
        for <linux-sh@vger.kernel.org>; Thu, 06 May 2021 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QseWDJD7yxOU5rG3+na4aQGSjg/EdTCgN17vCsxG6Y=;
        b=mlbBVVOHOhncgw4lopPiGHy6NNG+4vZNsw5TbuB+kL97hTTKGxe5M48hp1hvmqSvnF
         TSbCiiwh7InDzzaKZVtA3pjlysz37bVZGSCyJ5xA5NXZELSzieFVupzlCzENCfXyLVJ8
         lQ9ClTaR8Gyxc8SmKu694ilUnDrjFcHKBD5EfnDMKjtMldRlGlU6ijU33bbZRQ7i5eML
         dvNfjxZc8a2KIIzUY8fEf70ryxOfYQn5p1meuFhSQI+sR7voUjNDnM0cjo9fXGauaAkY
         tdgwC8B68IfrCM00egmCeciw+m5i3CcQKpiCdhAAe24DXvHylSzVuunNLT65gIvMce3o
         mJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QseWDJD7yxOU5rG3+na4aQGSjg/EdTCgN17vCsxG6Y=;
        b=HoiMbPfYjLrdDdyHIKAznFxuFbSG0+j6DbYYgf3OaQc7kOjm4xNygylpy4B0kwX3qY
         MJ8VW4MBZUusZQCsaLB2nbH7U/XXYQV2Z5FVEdIDTmwzTUjo2tGrx/0VgKqGZ3yEsA10
         d3RIB9rreO/nWulw7NRQVfBHDUu+9x2MUuSVr6/BV5CIHMP6gRT8LIdQJ7XU31SS8aGc
         nNwGxxbtw1Yi+eu2naFT58dsABZKgkcHJ645Z46TSwKm6akwwXYfa+bL6SGXguzxzETj
         kDlSk+zcAv+Cah07C2KKzhskfq5SnfTzrH0pvGbicp5cXTvh/AUlHpskPLYJYOe6ni23
         /JDw==
X-Gm-Message-State: AOAM53179rzuhr/d1+iROJrmBENyQsBtrUpK8o19/R6fHj6fQ+CFzDIw
        yT+Q2B/sFSk/A4THxiYmWhHvcQ==
X-Google-Smtp-Source: ABdhPJw9TnD7fJ5mwyTc0krHc+cYRAlG0zHj8GY6A4eINag7hGLuvphIDB2gNYjb4J55cRecfnyT/g==
X-Received: by 2002:a9d:6242:: with SMTP id i2mr3187364otk.273.1620302176492;
        Thu, 06 May 2021 04:56:16 -0700 (PDT)
Received: from [192.168.101.238] ([172.58.96.242])
        by smtp.gmail.com with ESMTPSA id q2sm14055ool.3.2021.05.06.04.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 04:56:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] arch: use cross_compiling to check whether it is a
 cross build or not
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org
References: <20210501172437.156926-1-masahiroy@kernel.org>
 <20210501172437.156926-2-masahiroy@kernel.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <664383ae-8ab2-da1d-601d-365d507f47db@landley.net>
Date:   Thu, 6 May 2021 07:11:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210501172437.156926-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 5/1/21 12:24 PM, Masahiro Yamada wrote:
> 'cross_compiling' is defined by the top Makefile and available for
> arch Makefiles to check whether it is a cross build or not. A good
> thing is the variable name 'cross_compiling' is self-documenting.
> 
> This is a simple replacement for m68k, mips, sh, for which $(ARCH)
> and $(SRCARCH) always match.
> 
> No functional change is intended for xtensa, either.
> 
> This is rather a fix for parisc because arch/parisc/Makefile defines
> UTS_MATCHINE depending on CONFIG_64BIT, therefore cc-cross-prefix
> is not working in Kconfig time.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tried the patch in my sh build, the result built and booted.

Tested-by: Rob Landley <rob@landley.net>

Rob
