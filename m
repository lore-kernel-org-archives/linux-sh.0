Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32FFC433DB
	for <linux-sh@archiver.kernel.org>; Tue, 16 Mar 2021 08:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C52165002
	for <linux-sh@archiver.kernel.org>; Tue, 16 Mar 2021 08:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhCPIf7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbhCPIfi (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 16 Mar 2021 04:35:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90066C06175F
        for <linux-sh@vger.kernel.org>; Tue, 16 Mar 2021 01:35:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dx17so70742465ejb.2
        for <linux-sh@vger.kernel.org>; Tue, 16 Mar 2021 01:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CjLHqcRLXQ6dUznEJBtg7nu1kYjN9GGJK8Vh/4Q1wzA=;
        b=OEJpKcLPxwWKVbTLwSSr7+MNyb9zdWFY/fF18jofgn4mxQMADe2HQsPAkkHa86yGnc
         y41M7m8CU7Ge6P42bbOxRSyGne/uCklsiZ23yXnW+6QiZlZBOkJLJ8VK+WNVDDC1JJYd
         slfwgL6ElRonbWkeqSvLi8yBukPzwNQ35X5iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjLHqcRLXQ6dUznEJBtg7nu1kYjN9GGJK8Vh/4Q1wzA=;
        b=VG5dvgXUTXUXrqKXtyhbqKJVmTMBQKUsWEWl6DNnb8ZeNumDQilA54TbyZ55TI0/ff
         VLPZh3l9orn/uF+tlB+Q3r0XjFAs6l9/PJLbsOVeL+qWn0axynCEcUc+BhlQq1iznDiS
         ZkV8/7ig73cwtQoAzOKjZPxh6n1VLIaNcy0UUjdtKQHVCsx2WDghxCosbQhmHF5iC+B8
         UqtYcjuSzxVVBZ+dywaJxrkamiTRNNTBw0YNoiodwTcQNzGpTyxjVdFvL0T44GUDA2H7
         syCrm8/UwWasA6eHmhUeitTuMV8H7e94I4IJyikhGGHz59zeQYFa0WsPC4gb6MQ3gRQE
         E8kQ==
X-Gm-Message-State: AOAM532aVuoy6EnOfnJtFqXXJ1Z4LtdQ74hdW+leHGX0FMhLXZomkzgr
        FxrwS0syEqjgNl8VsK1x63dCMQ==
X-Google-Smtp-Source: ABdhPJx2FIa6y6g2mUb7m2samZia0k53B/8UOt9Jnn0p4GBRcSqsjeN3Lhlp2gQkf624Vh9osC/gsg==
X-Received: by 2002:a17:906:aada:: with SMTP id kt26mr27652274ejb.137.1615883737275;
        Tue, 16 Mar 2021 01:35:37 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id gj26sm8825176ejb.67.2021.03.16.01.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 01:35:36 -0700 (PDT)
Subject: Re: [PATCH 04/13] lib: introduce BITS_{FIRST,LAST} macro
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
References: <20210316015424.1999082-1-yury.norov@gmail.com>
 <20210316015424.1999082-5-yury.norov@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8021faab-e592-9587-329b-817ae007b89a@rasmusvillemoes.dk>
Date:   Tue, 16 Mar 2021 09:35:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316015424.1999082-5-yury.norov@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 16/03/2021 02.54, Yury Norov wrote:
> BITMAP_{LAST,FIRST}_WORD_MASK() in linux/bitmap.h duplicates the
> functionality of GENMASK(). The scope of BITMAP* macros is wider
> than just bitmaps. This patch defines 4 new macros: BITS_FIRST(),
> BITS_LAST(), BITS_FIRST_MASK() and BITS_LAST_MASK() in linux/bits.h
> on top of GENMASK() and replaces BITMAP_{LAST,FIRST}_WORD_MASK()
> to avoid duplication and increase the scope of the macros.
> 
> This change doesn't affect code generation. On ARM64:
> scripts/bloat-o-meter vmlinux.before vmlinux
> add/remove: 1/2 grow/shrink: 2/0 up/down: 17/-16 (1)
> Function                                     old     new   delta
> ethtool_get_drvinfo                          900     908      +8
> e843419@0cf2_0001309d_7f0                      -       8      +8
> vermagic                                      48      49      +1
> e843419@0d45_000138bb_f68                      8       -      -8
> e843419@0cc9_00012bce_198c                     8       -      -8

[what on earth are those weird symbols?]


> diff --git a/include/linux/bits.h b/include/linux/bits.h
> index 7f475d59a097..8c191c29506e 100644
> --- a/include/linux/bits.h
> +++ b/include/linux/bits.h
> @@ -37,6 +37,12 @@
>  #define GENMASK(h, l) \
>  	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
>  
> +#define BITS_FIRST(nr)		GENMASK((nr), 0)
> +#define BITS_LAST(nr)		GENMASK(BITS_PER_LONG - 1, (nr))
> +
> +#define BITS_FIRST_MASK(nr)	BITS_FIRST((nr) % BITS_PER_LONG)
> +#define BITS_LAST_MASK(nr)	BITS_LAST((nr) % BITS_PER_LONG)

I don't think it's a good idea to propagate the unusual closed-range
semantics of GENMASK to those wrappers. Almost all C and kernel code
uses the 'inclusive lower bound, exclusive upper bound', and I'd expect
BITS_FIRST(5) to result in a word with five bits set, not six. So I
think these changes as-is make the code much harder to read and understand.

Regardless, please add some comments on the valid input ranges to the
macros, whether that ends up being 0 <= nr < BITS_PER_LONG or 0 < nr <=
BITS_PER_LONG or whatnot.

It would also be much easier to review if you just redefined the
BITMAP_LAST_WORD_MASK macros etc. in terms of these new things, so you
wouldn't have to do a lot of mechanical changes at the same time as
introducing the new ones - especially when those mechanical changes
involve adding a "minus 1" everywhere.

Rasmus
