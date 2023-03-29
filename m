Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7299CC6FD18
	for <linux-sh@archiver.kernel.org>; Wed, 29 Mar 2023 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC2QDS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 29 Mar 2023 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjC2QCJ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 29 Mar 2023 12:02:09 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CD47D8A
        for <linux-sh@vger.kernel.org>; Wed, 29 Mar 2023 09:01:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id jy12so358674plb.8
        for <linux-sh@vger.kernel.org>; Wed, 29 Mar 2023 09:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680105349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62ZIWkSy5tZoUHv/2BRxXjvjKExsY1hv+Zfd9ZYJQ4E=;
        b=JIzwc/PPgD9FCDFJYTHvMGdll81Yy+Il11SGjq4TDHYyRp4vcl6+PK2PB0jlmtGzdY
         vkQxVu1kTgp02/fCCHxLG9cSDGgzJ63Hlu5a3NsPe3EpHPmcyy8QhZrX3jHzqX+jKyyP
         pz2NzrcY+iiNFttxcmMcBvnNW2feiv3IWKCqLH4DNyumdBQuKpJl51EjWLujDYv8iqxO
         rgybuuDM4VvrK4HlMSDEm+7NkuIlQsgbvVYDFNKmIFcBuZNvIkuawv41+TZYUmshyDGV
         HYonbtJ/pl5FjZuag9pBhoNjhyt0u2NeEfBZk3LjjvsDDMsY8ey6/aqkj00WgdZpfs0c
         UuIw==
X-Gm-Message-State: AAQBX9dhlNEZ7PzPeiyg/nai/k3/ZqC16FajGp74kElHnKoyd4GBzz/W
        Or8rNVhItiRAALBuUoht5PJhO+6U3FnWWzLHpRJfgw==
X-Google-Smtp-Source: AKy350aLDH5YR9t419L5OiinTR+6vLBCDmWiJH85fFWabTVqFHlXOqvkdPLNLHEa0183i9K3F9W0CuWctZ/RgFAniww=
X-Received: by 2002:a17:902:c3c6:b0:1a1:b318:2776 with SMTP id
 j6-20020a170902c3c600b001a1b3182776mr7729184plj.0.1680105349103; Wed, 29 Mar
 2023 08:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
In-Reply-To: <20230325060828.2662773-3-rppt@kernel.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Wed, 29 Mar 2023 10:55:37 -0500
Message-ID: <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, Mar 25, 2023 at 1:09 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> It is not a good idea to change fundamental parameters of core memory
> management. Having predefined ranges suggests that the values within
> those ranges are sensible, but one has to *really* understand
> implications of changing MAX_ORDER before actually amending it and
> ranges don't help here.
>
> Drop ranges in definition of ARCH_FORCE_MAX_ORDER and make its prompt
> visible only if EXPERT=y

I do not like suddenly hiding this behind EXPERT for a couple of
reasons.  Most importantly, it will silently change the config for
users building with an old kernel config.  If a user has for instance
"13" set and building with 4K pages, as is the current configuration
for Fedora and RHEL aarch64 builds, an oldconfig build will now set it
to 10 with no indication that it is doing so.  And while I think that
10 is a fine default for many aarch64 users, there are valid reasons
for choosing other values. Putting this behind expert makes it much
less obvious that this is an option.

Justin

> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/arm64/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e60baf7859d1..7324032af859 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1487,11 +1487,9 @@ config XEN
>  # 16K |       27          |      14      |       13        |         11         |
>  # 64K |       29          |      16      |       13        |         13         |
>  config ARCH_FORCE_MAX_ORDER
> -       int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
> +       int "Maximum zone order" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
>         default "13" if ARM64_64K_PAGES
> -       range 11 13 if ARM64_16K_PAGES
>         default "11" if ARM64_16K_PAGES
> -       range 10 15 if ARM64_4K_PAGES
>         default "10"
>         help
>           The kernel memory allocator divides physically contiguous memory
> --
> 2.35.1
>
>
