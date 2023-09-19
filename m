Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34B8CD5BBC
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 13:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjISNZk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjISNZi (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 09:25:38 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55ECF4
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:25:31 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-d7b91422da8so5363905276.2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129931; x=1695734731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+49gL5mB0cuFnyAE8C6rSGpkZiXGjKHdT6s6d8lsi0=;
        b=neuyayRCHmdUIK/7WUSuUaH4vZ7FCcDt4eBE5fQ+RvIboEceJBWFcPwbxD2lr/6WaR
         VLaF2ZsnT3tLxfuVAHpIg9a8JfyLiQV6fMskEoUD3t3Uy4rwBKm66pP4GtflzJAfuz4N
         +MLYqIl56oTd0dMV1EST8UVFsDO8mThGWZlojqksk1z51q420JWW36dgbMhXsvI6p/X1
         oQz9WSsNQQCMB7Mt33R/2/9TGkfEjAjO7gf2QtoDMTit/GpoNNClSecnunAWG9Bzh6Z+
         XCWbioJhpG6jzlIrTYWyj09/jaQzdqlqMnzquYmQ8OfzkfUYVYydmn9BLcjcdQZxTXgY
         Coxg==
X-Gm-Message-State: AOJu0Yyq7hK16bpkR9T5cnJuw/JM+I8OfKSNPjR3jAvlPlWtgduRmtdG
        XssQcB7Rt0F5bgap4BMQHnGwXZN2R2n/xA==
X-Google-Smtp-Source: AGHT+IFRyPNiMxgrqJWgpI70+mZzSz5SQJcAXff9NbCbYzD1yBd+fDBMOkJ5+4CzDYDu9Qasz+f+vw==
X-Received: by 2002:a25:ad4d:0:b0:d7f:1bd7:c83c with SMTP id l13-20020a25ad4d000000b00d7f1bd7c83cmr10845944ybe.13.1695129930885;
        Tue, 19 Sep 2023 06:25:30 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id p81-20020a257454000000b00d748501d9b4sm2860691ybc.21.2023.09.19.06.25.30
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 06:25:30 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59c2ca01f27so32770587b3.2
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 06:25:30 -0700 (PDT)
X-Received: by 2002:a0d:f983:0:b0:579:effb:ae1c with SMTP id
 j125-20020a0df983000000b00579effbae1cmr12891206ywf.26.1695129930531; Tue, 19
 Sep 2023 06:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <d63793503fbbc7d5ca7b40d6b31678d371b69c29.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 15:25:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUEhev1F40FhiJyCENvca9YTx_hv1gT_DTXyVMCKjU8g@mail.gmail.com>
Message-ID: <CAMuHMdUUEhev1F40FhiJyCENvca9YTx_hv1gT_DTXyVMCKjU8g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 26/30] arch/sh: RTS7751R2D Plus DeviceTree.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/sh/boot/dts/rts7751r2dplus.dts
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the Renesas RTS7751R2D Plus
> + */
> +
> +/dts-v1/;
> +
> +#include "sh7751.dtsi"

#include "sh7751r.dtsi"?

To make that work, you can create "sh7751.dtsi" that includes
"sh7751.dtsi" and overrides the parts that are different.

> +
> +/ {
> +       model = "Renesas RTS7715R2D Plus";
> +       compatible = "renesas,r2dplus";

compatible = "renesas,r2dplus", "renesas,sh7751r", "renesas,sh7751".

And all these compatible values must be documented in the DT
binding documentation.

> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       interrupt-parent = <&shintc>;
> +
> +       aliases {
> +               serial0 = &scif1;
> +       };
> +
> +       chosen {
> +       };
> +
> +       clocks {
> +               xtal: oscillator {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       clock-frequency = <22222222>;
> +               };

Please
> +
> +               cpg: cpg@ffc00000 {

"&cpg"?

> +                       compatible = "renesas,sh7750r-cpg",
> +                                    "renesas,sh7750-cpg";

There should be no need to override the cpg's compatible value.

> +                       renesas,mode = <5>;
> +               };
> +       };
> +
> +       cpus {
> +               cpu@0 {
> +                     clock-frequency = <266666666>;

As the CPU clock is programmable, the "clock-frequency"
property should probably be replaced by a "clocks" property in the
base sh7751.dtsi.

> +               };
> +       };
> +
> +       memory@c000000 {
> +               device_type = "memory";
> +               reg = <0x0c000000 0x4000000>;
> +       };
> +
> +       r2dintc: sh7751irl_encoder@a4000000 {
> +               compatible = "renesas,sh7751-irl-ext";
> +               reg = <0xa4000000 0x02>;
> +               interrupt-controller;
> +               #address-cells = <1>;
> +               #interrupt-cells = <2>;
> +               sh7751irl,width = <16>;
> +               sh7751irl,polarity = <0>;
> +               sh7751irl,irqbit =<11>,         /* PCI INTD */
> +                                 <9>,          /* CF IDE */
> +                                 <8>,          /* CF CD */
> +                                 <12>,         /* PCI INTC */
> +                                 <10>,         /* SM501 */
> +                                 <6>,          /* KEY */
> +                                 <5>,          /* RTC ALARM */
> +                                 <4>,          /* RTC T */
> +                                 <7>,          /* SDCARD */
> +                                 <14>,         /* PCI INTA */
> +                                 <13>,         /* PCI INTB */
> +                                 <0>,          /* EXT */
> +                                 <15>;         /* TP */
> +       };
> +
> +       display@1,0 {
> +               compatible = "smi,sm501";
> +               reg = <0x10000000 0x03e00000
> +                      0x13e00000 0x00200000>;
> +               interrupt-parent = <&r2dintc>;
> +               interrupts = <4 0>;
> +               mode = "640x480-16@60";
> +               little-endian;
> +               sm501,devices = "usb-host","uart0";
> +       };
> +
> +       compact-flash@b4001000 {
> +               compatible = "ata-generic";

compact-flash@b4001000: compatible:0: 'ata-generic' is not one of
['arm,vexpress-cf', 'fsl,mpc8349emitx-pata']
from schema $id: http://devicetree.org/schemas/ata/ata-generic.yaml#

> +               reg = <0xb4001000 0x0e>, <0xb400080c 2>;
> +               reg-shift = <1>;
> +               interrupt-parent = <&r2dintc>;
> +               interrupts = <1 0>;
> +       };
> +
> +       flash@0 {
> +               compatible = "cfi-flash";
> +               reg = <0x00000000 0x02000000>;
> +               device-width = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               partition@0 {
> +                       label = "U-Boot";
> +                       reg = <0x00000000 0x00040000>;
> +               };
> +               partition@1 {
> +                       label = "Environemt";

Environment

> +                       reg = <0x00040000 0x00040000>;
> +               };

Several of the above comments apply to "[RFC PATCH v2 27/30]
arch/sh: LANDISK DeviceTree." and "[RFC PATCH v2 28/30] arch/sh:
USL-5P DeviceTree.", too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
