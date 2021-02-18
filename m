Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA490C433E6
	for <linux-sh@archiver.kernel.org>; Thu, 18 Feb 2021 22:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5DB64E22
	for <linux-sh@archiver.kernel.org>; Thu, 18 Feb 2021 22:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbhBRWw2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 18 Feb 2021 17:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbhBRWw0 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 18 Feb 2021 17:52:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CACC061788
        for <linux-sh@vger.kernel.org>; Thu, 18 Feb 2021 14:51:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id e13so5178327ejl.8
        for <linux-sh@vger.kernel.org>; Thu, 18 Feb 2021 14:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vrc627xbuX2TMgkXGGkkQoTFvSmbGef3PT5dPjYaHq4=;
        b=G+VppJXi/ZOG8gHCQ6TFEVZSG0VMgwjTbKRWl1GBBX3e9vwfVqsXJnB+Swrbm9Mbki
         HeZGAKA758jQl1Wchle/AFqcf2AjQAMFFj13bi28/2IH0R2ELAAHaO0ZWoqacamBBtzs
         uUGJ8VNz+ZknAy1z21qDfTSQ4nYI2gdZIrkck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vrc627xbuX2TMgkXGGkkQoTFvSmbGef3PT5dPjYaHq4=;
        b=AAKgCgHDqMAUt5SanQ8AMdc5C87ivxLmLM/qWP94Q3sivaLreFNXV9fQahWaPNQhIt
         wSEMu0tmcl0xLwzevAWnMYkQWJ06VlgGgk/UQjWg9tGZm/tTdJzZ5TKfFdLmZ0zdeEo9
         1xns4rEdK8Msd46s3wRCoLGkbQ9taglXhMMwq6Nc9tnKYyksfx4ShNbLIB84yQ/Xm25O
         7ulB9muUFwj5yRwnnbfuIWRRkufTAn54X2kIzqrOjuuKu2NWcm+dXvFBM6tMAt8suMFV
         gdHydCo4XV7x48Q3b63REw0xzMDURxF+rrA8Oy4gr0qQuSgr5eeSgX5jFoHWjIJvsd38
         w5ew==
X-Gm-Message-State: AOAM531XDvuXMmUnkLII4GerpDYNoESI/uLnmaqdN7MQW+KFx/Lq8+D7
        0YRH0J0lV5QC0/doBMSde1s12w==
X-Google-Smtp-Source: ABdhPJyKhm7W7GiwYBIDb8MWNmpDRdcqaFasH1pPiX6+4A01bLs1vLg+znuOAZacAYcYbAiyu87wIA==
X-Received: by 2002:a17:906:301b:: with SMTP id 27mr2584079ejz.230.1613688705192;
        Thu, 18 Feb 2021 14:51:45 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id m7sm3279119ejk.52.2021.02.18.14.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 14:51:44 -0800 (PST)
Subject: Re: [PATCH 04/14] lib: introduce BITS_{FIRST,LAST} macro
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210218040512.709186-1-yury.norov@gmail.com>
 <20210218040512.709186-5-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <b371c94c-7480-5af4-d2bd-481436f535eb@rasmusvillemoes.dk>
Date:   Thu, 18 Feb 2021 23:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210218040512.709186-5-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 18/02/2021 05.05, Yury Norov wrote:
> BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
> functionality of GENMASK(). The scope of there macros is wider
> than just bitmap. This patch defines 4 new macros: BITS_FIRST(),
> BITS_LAST(), BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h
> on top of GENMASK() and replaces BITMAP_{LAST,FIRST}_WORD_MASK()
> to avoid duplication and increase the scope of the macros.
> 

Please include some info on changes in generated code, if any. When the
parameter to the macro is a constant I'm sure it all folds to a
compile-time constant either way, but when it's not, I'm not sure gcc
can do the same optimizations when the expressions become more complicated.

Rasmus
