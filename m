Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3C4CA0FE5
	for <linux-sh@archiver.kernel.org>; Fri,  1 Sep 2023 14:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjIAOXz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Sep 2023 10:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349965AbjIAOXz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Sep 2023 10:23:55 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F5D10CF
        for <linux-sh@vger.kernel.org>; Fri,  1 Sep 2023 07:23:51 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-58dfe2d5b9aso128807b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 07:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578231; x=1694183031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XBtrdY4hNGcI2MtISEfGbeNIFjh8WnT71IEidT0/www=;
        b=Vuv8CzcI/4UCXMCunWnVQzo2qeYJqfbYhea6aKWW+Bd0WpJUENk76Ot7n/D3npYV5s
         53KTwInnzZEZ3uBZEWM4OSoKRlGMJC4vXMe3hR5bsPr/EsiE2wWt/LTWuNyAwVo8VGBh
         1ipr5fKHgfBOx3JDOqe3HEDKolPkBjEO+9xgt7lPddB35BXvsNBS0f7rlVKWsdrweQqP
         O31dYz4HCHCLDTGsy8+1io51Hjl6rzBLr6z4S64erEpZs4Vnp47VvM1eRqFb2407lj1t
         33EsUcCAa1M6Ndwn708d8RVc+gfGLOoqQRa9dORdOMY3bm723PKfE98n3A+vXdH3q1k2
         //oQ==
X-Gm-Message-State: AOJu0Yywcrk+Cjwy2leUWH9S4y5CK/IHWCFbsAqbO9QchC0KAEvSloKj
        d7usXgfWF1b268WGF02chI+mPHcWmvQcqQ==
X-Google-Smtp-Source: AGHT+IEVyXlVkzAIxosLSTMfUPt2YdI5cp+iEohU7gIQ9In9mGU3iJ7e6eIFU4J1y6z25h7jTCQxzw==
X-Received: by 2002:a0d:d605:0:b0:56c:f0c7:7d72 with SMTP id y5-20020a0dd605000000b0056cf0c77d72mr3792737ywd.4.1693578230720;
        Fri, 01 Sep 2023 07:23:50 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id n83-20020a817256000000b00589b653b7adsm1095598ywc.136.2023.09.01.07.23.50
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 07:23:50 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-58d41109351so48227b3.1
        for <linux-sh@vger.kernel.org>; Fri, 01 Sep 2023 07:23:50 -0700 (PDT)
X-Received: by 2002:a81:a186:0:b0:56c:f547:e058 with SMTP id
 y128-20020a81a186000000b0056cf547e058mr4085015ywg.18.1693578230001; Fri, 01
 Sep 2023 07:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693444193.git.ysato@users.sourceforge.jp> <1a7d32f58935aee952750a088702f7f2798972d8.1693444193.git.ysato@users.sourceforge.jp>
In-Reply-To: <1a7d32f58935aee952750a088702f7f2798972d8.1693444193.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 1 Sep 2023 16:23:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX3qyNKTy3cRaD9md10jvNG_YqNsFfhizZEv22KNKTmBw@mail.gmail.com>
Message-ID: <CAMuHMdX3qyNKTy3cRaD9md10jvNG_YqNsFfhizZEv22KNKTmBw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 11/12] sh: target dts.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Fri, Sep 1, 2023 at 12:43 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> - rts7751r2dplus - Renesas RTS7751R2D-PLUS board.
> - landisk - IO DATA DEVICE LANDISK
> - usl-5p - IO DATA DECVICE USL-5P
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

>  arch/sh/boot/dts/include/dt-bindings |   1 +
>  arch/sh/boot/dts/landisk.dts         | 142 ++++++++++++++++++++++
>  arch/sh/boot/dts/rts7751r2dplus.dts  | 168 +++++++++++++++++++++++++++
>  arch/sh/boot/dts/usl-5p.dts          | 146 +++++++++++++++++++++++

None of the DTBs are listed in arch/sh/boot/dts/Makefile, so how do you
build them without CONFIG_USE_BUILTIN_DTB/CONFIG_BUILTIN_DTB_SOURCE?

To make "make dtbs" and "make dtbs_check" work, I added:

     dtb-$(CONFIG_CPU_J2) += j2_mimas_v2.dtb
     dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += landisk.dtb
     dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += rts7751r2dplus.dtb
     dtb-$(CONFIG_CPU_SUBTYPE_SH7751R) += usl-5p.dtb

> --- /dev/null
> +++ b/arch/sh/boot/dts/landisk.dts
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree source for IO DATA DEVICE LANDISK
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>
> +
> +/dts-v1/;
> +/ {
> +       model = "IO-DATA Device LANDISK";
> +       compatible = "iodata,landisk";

compatible = "iodata,landisk", "renesas,sh7380", "renesas,sh7751r".

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&shintc>;

Empty line between properties and subnodes (everywhere).

> +       chosen {
> +               stdout-path = &sci1;

     stdout-path = "serial0";

or

     stdout-path = "serial0:9600n8";

> +       };

Empty line between subnodes (everywhere).

> +       aliases {
> +               serial1 = &sci1;
> +       };
> +
> +       oclk: oscillator {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <22222222>;
> +       };
> +       pllclk: pllclk {
> +               compatible = "renesas,sh7750-pll-clock";
> +               clocks = <&oclk>;
> +               #clock-cells = <0>;
> +               sh7750,md = <5>;
> +               sh7750,rtype = <1>;
> +               reg = <0xffc00000 2>, <0xffc00008 4>;
> +       };
> +       iclk: iclk {
> +               compatible = "renesas,sh7750-div-clock";
> +               clocks = <&pllclk>;
> +               #clock-cells = <0>;
> +               reg = <0xffc00000 2>;
> +               renesas,offset = <6>;
> +               clock-output-names = "ick";
> +       };
> +       bclk: bclk {
> +               compatible = "renesas,sh7750-div-clock";
> +               clocks = <&pllclk>;
> +               #clock-cells = <0>;
> +               reg = <0xffc00000 2>;
> +               renesas,offset = <3>;
> +               clock-output-names = "bck";
> +       };
> +       fclk: fclk {
> +               compatible = "renesas,sh7750-div-clock";
> +               clocks = <&pllclk>;
> +               #clock-cells = <0>;
> +               reg = <0xffc00000 2>;
> +               renesas,offset = <0>;
> +               clock-output-names = "fck";
> +       };

Having individual clock nodes (especially if they use the same register
block) is deprecated.  Please use a single node with compatible value
e.g. "renesas,sh7751r-cpg" and "#clock-cells = <1>", and let the driver
create all clocks itself.

> +       sci1: serial@ffe80000 {

label "scif" (serial@ffe00000 is "sci").

> +               compatible = "renesas,scif";

"renesas,scif-sh7751r", "renesas,scif" ?

> +               reg = <0xffe80000 0x100>;
> +               interrupts = <evt2irq(0x700) 0
> +                             evt2irq(0x720) 0
> +                             evt2irq(0x760) 0
> +                             evt2irq(0x740) 0>;

Please group using angular brackets:

              interrupts = <evt2irq(0x700) 0>,
                            <evt2irq(0x720) 0>,
                            <evt2irq(0x760) 0>,
                            <evt2irq(0x740) 0>;

Missing interrupt-names

> +               clocks = <&fclk>;
> +               clock-names = "fck";
> +       };
> +       tmu: timer@ffd80008 {
> +               compatible = "renesas,tmu";
> +               reg = <0xffd80000 12>;
> +               interrupts = <evt2irq(0x400) 0
> +                             evt2irq(0x420) 0
> +                             evt2irq(0x440) 0>;

Please group using angular brackets

> +               clocks = <&fclk>;
> +               clock-names = "fck";
> +               renesas,channels = <0x03>;

renesas,channels = <5>;

> +       };
> +
> +       pci@fe200000 {
> +               compatible = "renesas,sh7751-pci", "iodata,julian";

Most-specific first, i.e.

    compatible = "iodata,julian", "renesas,sh7751-pci";

(and we do need DT binding documentation!)

However, "iodata,julian" is a too-generic name.

> +               device_type = "pci";
> +               bus-range = <0 0>;
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
> +                        <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
> +               reg = <0xfe200000 0x0400>,
> +                     <0x0c000000 0x04000000>,
> +                     <0xff800000 0x0030>;
> +               #interrupt-cells = <1>;
> +               interrupt-parent = <&julianintc>;
> +               eth@0,0 {
> +                       reg = <0x0000 0 0 0 0>;
> +                       interrupts = <5 0>;
> +               };
> +               ata@1,0 {
> +                       reg = <0x0800 0 0 0 0>;
> +                       interrupts = <6 0>;
> +               };
> +               usb@2,0 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       interrupts = <7 0>;
> +               };
> +               usb@2,1 {
> +                       reg = <0x1100 0 0 0 0>;
> +                       interrupts = <8 0>;
> +               };
> +               usb@2,2 {
> +                       reg = <0x1200 0 0 0 0>;
> +                       interrupts = <5 0>;
> +               };
> +       };
> +};

All SoC-specific parts should be extracted into sh7751r.dtsi, so it can be
shared by all board DTS files.

> diff --git a/arch/sh/boot/dts/rts7751r2dplus.dts b/arch/sh/boot/dts/rts7751r2dplus.dts
> new file mode 100644
> index 000000000000..1d64753f47a2
> --- /dev/null
> +++ b/arch/sh/boot/dts/rts7751r2dplus.dts
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree source for Renesas RTS7751R2D Plus
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>
> +
> +/dts-v1/;
> +/ {
> +       model = "Renesas RTS7715R2D Plus";
> +       compatible = "renesas,r2dplus";

compatible = "renesas,r2dplus", "renesas,sh7751r".

> +       display@1,0 {
> +               compatible = "smi,sm501";
> +               reg = <0x10000000 0x03e00000
> +                      0x13e00000 0x00200000>;

Please group using angular brackets.

> +               interrupt-parent = <&r2dintc>;
> +               interrupts = <4 0>;
> +               mode = "640x480-16@60";
> +               little-endian;
> +               sm501,devices = "usb-host,uart0";
> +       };

> +       flash@0 {
> +               compatible = "cfi-flash";
> +               reg = <0x00000000 0x02000000>;
> +               device-width = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               partition@0 {

Please wrap all partitions inside a "partitions" subnode.

> +                       label = "U-Boot";
> +                       reg = <0x00000000 0x00040000>;
> +               };
> +               partition@1 {

partition@40000

> +                       label = "Environemt";
> +                       reg = <0x00040000 0x00040000>;
> +               };
> +               partition@2 {

partition@80000

> +                       label = "Kernel";
> +                       reg = <0x00080000 0x001c0000>;
> +               };
> +               partition@3 {

partition@240000

> +                       label = "Flash_FS";
> +                       reg = <0x00240000 0x00dc0000>;
> +               };
> +       };
> +
> +       pci@fe200000 {
> +               compatible = "renesas,sh7751-pci", "renesas,r2d";

compatible = "renesas,r2d", "renesas,sh7751-pci";

However, "renesas,r2d" is a too-generic name.

> +               device_type = "pci";
> +               bus-range = <0 0>;
> +               #address-cells = <3>;
> +               #size-cells = <2>;
> +               ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
> +                        <0x01000000 0 0xfe240000 0xfe240000 0 0x00040000>;
> +               reg = <0xfe200000 0x0400>,
> +                     <0x0c000000 0x04000000>,
> +                     <0xff800000 0x0030>;
> +               #interrupt-cells = <1>;
> +               interrupt-parent = <&r2dintc>;
> +               eth@2,0 {
> +                       reg = <0x1000 0 0 0 0>;
> +                       interrupts = <3 0>;
> +               };
> +       };
> +};

> --- /dev/null
> +++ b/arch/sh/boot/dts/usl-5p.dts
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree source for IO DATA DEVICE USL-5P
> + *
> + * Copyright 2023 Yoshinori Sato
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>
> +
> +/dts-v1/;
> +/ {
> +       model = "IO-DATA Device USL-5P";
> +       compatible = "iodata,usl-5p";

compatible = "iodata,usl-5p", "renesas,sh7380", "renesas,sh7751r".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
