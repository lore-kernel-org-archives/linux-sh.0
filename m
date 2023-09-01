Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877FCA0FE1
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240522AbjIAMy1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 08:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245221AbjIAMy1 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 08:54:27 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E76010D2
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 05:54:22 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-58dce1f42d6so42302737b3.0
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572861; x=1694177661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUgoMoHKcJ8ntmkQx/Udta4bVU+pjIw2bEh6XhNfbZI=;
        b=UW4u5JcslurLwquE+rZga9Nlvaep7CiNohhEft6A6BB6l+sBYmSEBxwgN6l6lXTuBa
         OeAnuXdWGxmI9PLHycVeh14kWNusC/bEC6jH0UxrSh/AaluK3tK0CcWN2V5yPTIYSFL7
         9FWAhwtlY6/kN7t1+AlyTDuEWkiCjj5k0NIIaEv4xxUx+/R1uMchH6Uqu2ZZ6ipHvW+L
         DMS/sN283gRxQOhvaUYdyBEVq4+XkDT0Fd4FrBxf+GmfayvByncjdGbAVG3i99FlEJy2
         U4sSWJGd+nWAZxBrjAGzVoRvhZs71fYheLile7F652qR/INM6/yjtuB3kTjZvjhbu0kN
         698A==
X-Gm-Message-State: AOJu0Yyh4ow3xa9AEuukEIkN/2JMRsYK/WeUjtzPYOejaTiYdrOUXmGU
        Kl6N+NW9YprjEJShT0jliDa+cHqtjfPa5w==
X-Google-Smtp-Source: AGHT+IHHRpJny8pWiDfjRbZEw0Pd6R/J8iRcd3WKuR4XwxI7ZmmAYZmVRRcOtAN3S0G9Shp1hmI0Dg==
X-Received: by 2002:a25:abeb:0:b0:d72:8a65:394f with SMTP id v98-20020a25abeb000000b00d728a65394fmr3619343ybi.18.1693572861641;
        Fri, 01 Sep 2023 05:54:21 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id v13-20020a25fc0d000000b00d6861b49f01sm866126ybd.65.2023.09.01.05.54.20
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 05:54:20 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d74a012e613so2536633276.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 05:54:20 -0700 (PDT)
X-Received: by 2002:a25:dbd1:0:b0:d71:c79c:86c1 with SMTP id
 g200-20020a25dbd1000000b00d71c79c86c1mr3172687ybf.32.1693572860349; Fri, 01
 Sep 2023 05:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <0b72656a4f7154d4d95f7672eb1f2b038751f59a.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <0b72656a4f7154d4d95f7672eb1f2b038751f59a.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 14:54:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXL7hzK8TJ32n=yAze+gVBCTdikwLAVAziPXBX_LZJOJA@mail.gmail.com>
Message-ID: <CAMuHMdXL7hzK8TJ32n=yAze+gVBCTdikwLAVAziPXBX_LZJOJA@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 06/12] drivers/pci: Add SH7751 PCI Host bridge driver.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Thu, Aug 31, 2023 at 7:38 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Use Common framework host bridge driver.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -343,6 +343,15 @@ config PCIE_XILINX_CPM
>           Say 'Y' here if you want kernel support for the
>           Xilinx Versal CPM host bridge.
>
> +config PCI_SH7751
> +       bool "Renesas SH7751 PCI controller"
> +       depends on OF
> +       depends on CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7751R

|| COMPILE_TEST ?

> +       select PCI_HOST_COMMON
> +       help
> +         Say 'Y' here if you want kernel to support the Renesas SH7751 PCI
> +         Host Bridge driver.
> +
>  source "drivers/pci/controller/cadence/Kconfig"
>  source "drivers/pci/controller/dwc/Kconfig"
>  source "drivers/pci/controller/mobiveil/Kconfig"

> --- /dev/null
> +++ b/drivers/pci/controller/pci-sh7751.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas SH7751 PCI Host bridge driver
> + * Copyright (C) 2023 Yoshinori Sato
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <asm-generic/pci.h>
> +#include "pci-sh7751.h"
> +
> +#define pcic_writel(val, reg) __raw_writel(val, pci_reg_base + (reg))
> +#define pcic_readl(reg) __raw_readl(pci_reg_base + (reg))
> +
> +DEFINE_RAW_SPINLOCK(pci_config_lock);
> +
> +/*
> + * PCIC fixups
> + */
> +
> +#define PCIMCR_MRSET 0x40000000
> +#define PCIMCR_RFSH  0x00000004
> +
> +static void __init julian_fixup(void __iomem *pci_reg_base, void __iomem *bcr)

Please drop all the __init* annotations from this driver:

    WARNING: modpost: vmlinux: section mismatch in reference:
sh7751_pci_driver+0x0 (section: .data) -> set_reset_devices (section:
.init.text)

> +{
> +       unsigned long bcr1, mcr;

u32

> +
> +       bcr1 = __raw_readl(bcr + SH7751_BCR1);
> +       bcr1 |= 0x00080000;     /* Enable Bit 19 BREQEN, set PCIC to slave */
> +       pcic_writel(bcr1, SH4_PCIBCR1);
> +
> +       mcr = __raw_readl(bcr + SH7751_MCR);
> +       mcr &= (~PCIMCR_MRSET) & (~PCIMCR_RFSH);
> +       pcic_writel(mcr, SH4_PCIMCR);
> +
> +       pcic_writel(0x0c000000, SH7751_PCICONF5);
> +       pcic_writel(0xd0000000, SH7751_PCICONF6);
> +       pcic_writel(0x0c000000, SH4_PCILAR0);
> +       pcic_writel(0x00000000, SH4_PCILAR1);
> +}
> +
> +static void __init r2dplus_fixup(void __iomem *pci_reg_base, void __iomem *bcr)
> +{
> +       unsigned long bcr1, mcr;

u32

> +static __init void pcic_fixups(struct device_node *np,
> +                      void __iomem *pcic, void __iomem *bcr)
> +{
> +       int i;

unsigned int

> +       const struct fixups *f = fixup_list;
> +
> +       for (i = 0; i < ARRAY_SIZE(fixup_list); i++) {
> +               if (of_device_is_compatible(np, f->compatible)) {
> +                       f->fixup(pcic, bcr);
> +                       break;
> +               }
> +       }
> +}

> +/*
> + * We need to avoid collisions with `mirrored' VGA ports
> + * and other strange ISA hardware, so we always want the
> + * addresses to be allocated in the 0x000-0x0ff region
> + * modulo 0x400.
> + */
> +resource_size_t pcibios_align_resource(void *data, const struct resource *res,
> +                                             resource_size_t size, resource_size_t align)
> +{
> +       resource_size_t start = res->start;
> +
> +       return start;

return res->start

> +}

> +static int __init area_sdram_check(void __iomem *pci_reg_base,
> +                                  void __iomem *bcr,
> +                                  unsigned int area)
> +{
> +       unsigned long word;

u32

> +
> +       word = __raw_readl(bcr + SH7751_BCR1);

> +static __init int sh7751_pci_probe(struct platform_device *pdev)
> +{
> +       struct resource *res, *wres;
> +       u32 id;
> +       u32 reg, word;
> +       void __iomem *pci_reg_base;
> +       void __iomem *bcr;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       pci_reg_base = (void __iomem *)res->start;
> +       if (IS_ERR(pci_reg_base))
> +               return PTR_ERR(pci_reg_base);
> +
> +       wres = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       if (IS_ERR(wres))
> +               return PTR_ERR(wres);
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
> +       bcr = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(pci_reg_base))
> +               return PTR_ERR(bcr);
> +
> +       /* check for SH7751/SH7751R hardware */
> +       id = pcic_readl(SH7751_PCICONF0);
> +       if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
> +           id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
> +               pr_warn("PCI: This is not an SH7751(R)\n");
> +               return -ENODEV;
> +       }
> +       dev_info(&pdev->dev, "PCI core found at %p\n",

%p prints an obfuscated pointer
If you would keep the original resource, you could print it with %pR.

> +               pci_reg_base);

> +static const struct of_device_id sh7751_pci_of_match[] = {
> +       { .compatible = "renesas,sh7751-pci",
> +         .data = &pci_sh7751_bus_ops },
> +
> +       { },

Please no comma after a sentinel.

> +};
> +MODULE_DEVICE_TABLE(of, sh7751_pci_of_match);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
