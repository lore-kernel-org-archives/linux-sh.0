Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3691EC43216
	for <linux-sh@archiver.kernel.org>; Wed,  4 Aug 2021 11:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26BDC60FC4
	for <linux-sh@archiver.kernel.org>; Wed,  4 Aug 2021 11:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbhHDLNh (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 4 Aug 2021 07:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236584AbhHDLNc (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 4 Aug 2021 07:13:32 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18ACC06179F
        for <linux-sh@vger.kernel.org>; Wed,  4 Aug 2021 04:13:17 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id bg4so790466vsb.6
        for <linux-sh@vger.kernel.org>; Wed, 04 Aug 2021 04:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1t0SNn5x7f6Dj4MvLfPbAe/nFhEaNG0D5+fMN+d0a4=;
        b=Nf2KyfVLFfCtc3VuPIByG76ejagI+MoZoGEbfaqyQkA4Edo4g7jlqu/TWtLlZBzI2Z
         s/nx4C8zYdl+AXVtju2jqdk0NwvbRNpbMn7sJOtpBwATeiCEHms9sG0ky0iednIbrJje
         8ErulyiXYP6SX4XSHeQER6RRMpM4uVyDS3WvWceptahkfNpmAaeCos8+6XMsuDosj3Yd
         au34bdb0Q+VMDOHYvMgodwhSP5NRwqRF5rIdxF/LQH5Mqif1pck1+6eRAWRmnVj+viJe
         OZWCpHHFesk0dsxMLa6m7NXG+cBA/KMcQaOeYi4wnGW8EyM+xI2+ucKP1wcogYE6UXEz
         wnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1t0SNn5x7f6Dj4MvLfPbAe/nFhEaNG0D5+fMN+d0a4=;
        b=aCA6dRa3iHQPSFdl3A8JnCirl3eg+L63KYVQIbRys4oExUniQaQM3LsYejZtqTEM8E
         DL5BppRaC8SCa8U+T+J7MoSHeSf7uypD/rn273xd892/2nk+1zsprMN/+4/PVCUeJUOy
         4zM0z4yhKe0gif9BHONOpgVHsSl+a9ndlbvMyhxGQj28kgDrijy2Nc+gO2gfIYigDCCH
         nvhwy/5L+KjupGu788oHOLmBq5P+ZrnRiqkCxmMz8rXgiioJ94VppPrM9UR+cskv8zr6
         pazJb8vCmhwVHwy08BWPch/vOE0RTABp7udf3VLLmKw3uw7mDRT6uEvdsG/8Gwfd20Bu
         +2vg==
X-Gm-Message-State: AOAM533c5e2wqPYXRCwW1/mPoiad+Hhq5mh0TIR/URFCpDWBfM+Htgdg
        /EpYX7XjwA/KWegXTrP18wAADIDjCxRlsnLTC5tyww==
X-Google-Smtp-Source: ABdhPJyvlEJk0kPUpk5hZjg1GBcfvcfyWBefSBKSC5X0FVKU1TS5OavoWFYJ7J3TB54jujHaG0St1s/ayVgY/H/S0V0=
X-Received: by 2002:a67:7c14:: with SMTP id x20mr9690293vsc.42.1628075596862;
 Wed, 04 Aug 2021 04:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060928.4161649-1-hch@lst.de> <20210712060928.4161649-3-hch@lst.de>
In-Reply-To: <20210712060928.4161649-3-hch@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:12:40 +0200
Message-ID: <CAPDyKFpo2kjAH6tRDdo_B3JnKGvuR_+3A9Fe6bCtuP12Lfqd2w@mail.gmail.com>
Subject: Re: [PATCH 2/6] mmc: mmc_spi: replace flush_kernel_dcache_page with flush_dcache_page
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geoff Levand <geoff@infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Alex Shi <alexs@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>, linux-mm@kvack.org,
        Linux Documentation <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, 12 Jul 2021 at 08:11, Christoph Hellwig <hch@lst.de> wrote:
>
> Pages passed to block drivers can be mapped page cache pages, so we
> must use flush_dcache_page here instead of the more limited
> flush_kernel_dcache_page that is intended for highmem pages only.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Apologies for the delay!

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/mmc/host/mmc_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index 65c65bb5737f..3d28a3d3001b 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -948,7 +948,7 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
>
>                 /* discard mappings */
>                 if (direction == DMA_FROM_DEVICE)
> -                       flush_kernel_dcache_page(sg_page(sg));
> +                       flush_dcache_page(sg_page(sg));
>                 kunmap(sg_page(sg));
>                 if (dma_dev)
>                         dma_unmap_page(dma_dev, dma_addr, PAGE_SIZE, dir);
> --
> 2.30.2
>
