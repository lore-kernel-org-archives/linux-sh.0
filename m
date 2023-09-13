Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DC2EDEC49
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbjIMMXd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 08:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIMMXc (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 08:23:32 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372419AC
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 05:23:29 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d8165e3b209so512173276.1
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 05:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607808; x=1695212608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4szPnmgtqD0ol6EuahVWZ0nXWo5HhxDi5Pk48Bev/Q=;
        b=JPSnhCX7AsMMA9AfZRNaMHmBdxulhHNobUBws2VIPfIr71nOS9qN4c7ISKkLM2BOze
         tWYjur1XY4X7LjTIvJM+GHB5EvSrr0ySXOGyEyLqtmBY/JBmFixURUUYLw4SFHHyXt4p
         CQs5A3VConvV3Mti/siCdIRIvtUPkuPzvLHfhY0Z3G0zYoMnNn8DFhkM2rDaj5ozpTZQ
         d5qnN1ypAf3oK0pyRnLWAJlxiOCuj4qClt4Yom3Fuge9gl2gwA8A6OA8NdSfGvIDZ5F2
         xrEHLlq0EFOnkxA9J0FJ63ylVTLHLshHF01ipXoSK8POd2bs92V61PAKg5EbNf0C6MRL
         VGMA==
X-Gm-Message-State: AOJu0YxrJb8btogfZNefL676+zyIQzDMDZgh+CQF/BqLuzb/SKrGpaZ+
        tedSXECYZuJjhhnjN7BiSraEs8UtPX2bHw==
X-Google-Smtp-Source: AGHT+IElGQjLA7GlKKkX3Zx240Iik2jwrQKLpQIxfacV53s8azKln6Aovv0ruB9QxYdli2dASzx48g==
X-Received: by 2002:a25:add8:0:b0:d7b:8fe5:fa2c with SMTP id d24-20020a25add8000000b00d7b8fe5fa2cmr2607144ybe.19.1694607807929;
        Wed, 13 Sep 2023 05:23:27 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a250511000000b00d74b144004bsm2718861ybf.12.2023.09.13.05.23.27
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:23:27 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59bc97d7b3dso7371267b3.1
        for <linux-sh@vger.kernel.org>; Wed, 13 Sep 2023 05:23:27 -0700 (PDT)
X-Received: by 2002:a25:ae09:0:b0:d7b:908b:183f with SMTP id
 a9-20020a25ae09000000b00d7b908b183fmr6003456ybj.26.1694607807505; Wed, 13 Sep
 2023 05:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <4a138cf1ff14ff6166a66851db7476096fa3f009.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <4a138cf1ff14ff6166a66851db7476096fa3f009.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 14:23:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV84_M9QG7DKvrgP-d2+FDh4NXFYPG5zt49hmgmxrAYwg@mail.gmail.com>
Message-ID: <CAMuHMdV84_M9QG7DKvrgP-d2+FDh4NXFYPG5zt49hmgmxrAYwg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 03/12] sh: SH4 OF support.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 5:22 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - switch generic framework in clock / PCI.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -292,4 +292,14 @@ static inline void iounmap(volatile void __iomem *addr) { }
>  int valid_phys_addr_range(phys_addr_t addr, size_t size);
>  int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
>
> +
> +#ifdef __KERNEL__
> +#define PCI_IOBASE     0xfe240000UL
> +
> +#define HAVE_ARCH_PIO_SIZE
> +#define PIO_OFFSET     PCI_IOBASE
> +#define PIO_MASK       0x3ffffUL
> +#define PIO_RESERVED   0x40000UL
> +#endif /* __KERNEL__ */
> +

Since commit b94692e84dccf12d ("sh: add <asm-generic/io.h> including")
in v6.6-rc1, the new definitions must be inserted higher up, before
the inclusion of <asm-generic/io.h>, to avoid:

    arch/sh/include/asm/io.h:322: warning: "PCI_IOBASE" redefined
      322 | #define PCI_IOBASE      0xfe240000UL
          |
    include/asm-generic/io.h:527: note: this is the location of the
previous definition

>  #endif /* __ASM_SH_IO_H */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
