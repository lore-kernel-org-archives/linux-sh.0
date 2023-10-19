Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F3BCDB483
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 12:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbjJSMSh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345460AbjJSMSg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 08:18:36 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6E3BE;
        Thu, 19 Oct 2023 05:18:34 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7ab31fb8bso94425117b3.1;
        Thu, 19 Oct 2023 05:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697717914; x=1698322714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwfLLmV+qw7mnuKmjA/1lPXkFA7pBYVMpcy7LrUkvoU=;
        b=dnvolG5q/0ODxnVg4kJUDbeSEJhIZ/pWT3aaadLaEKX8ngC3Vkz7EOnE0UqOZ/Lrb+
         jvM7HMufMhZkWk7oVjNHD15y2BwquOwjTnA5upCaZFv/Js+1NFtySCxmxXIDHxY1SSm8
         DUYraUwiPuJIa2ypD4jWfjQQi4xiWtcPaFF5jXPVZzZRu9rEzUDzlsWFR4qLOTKAiWHQ
         nfSOf92ruwZKdf0oqOLFaBhWl2OoTMBIIoBaha3Rw5+V91lraSeOhP4MCze1AD8m1A5k
         VT5cW1nMFoGfTwth2ruX9aiVCbrWVmeoX376zDz+0a6JITYC+qBByZUFxISQRPcnwMkc
         q/oQ==
X-Gm-Message-State: AOJu0YzwT/RVrO0vYMW+acilWVlMVVHdUGKqRhL1vsAFuxMALnNpwuLj
        hHmi8zA6lJpJO1MpEtsQdHbCR05huL/yrg==
X-Google-Smtp-Source: AGHT+IHB6YyvEGhCN78COxR4P6bhzpWcaGdpBS1TIUCadhbTawZ+PaykHtzehBZ8LKiidGCbfdyg9g==
X-Received: by 2002:a5b:312:0:b0:d8b:737f:823b with SMTP id j18-20020a5b0312000000b00d8b737f823bmr1954984ybp.0.1697717913699;
        Thu, 19 Oct 2023 05:18:33 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id e18-20020a25e712000000b00d9b33e0b952sm239356ybh.8.2023.10.19.05.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:18:33 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7db1f864bso94391437b3.3;
        Thu, 19 Oct 2023 05:18:33 -0700 (PDT)
X-Received: by 2002:a0d:cac5:0:b0:5a7:d9f9:2285 with SMTP id
 m188-20020a0dcac5000000b005a7d9f92285mr2064819ywd.26.1697717913323; Thu, 19
 Oct 2023 05:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <01c234379a48f89df5150fa2b5eae867df08d858.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <01c234379a48f89df5150fa2b5eae867df08d858.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 14:18:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVNNT+NpTth2Z=n6tq9geSjXFSL802-mWKoEbtF_yrdBQ@mail.gmail.com>
Message-ID: <CAMuHMdVNNT+NpTth2Z=n6tq9geSjXFSL802-mWKoEbtF_yrdBQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 26/35] arch/sh/boot/dts: SH7751R SoC Internal
 peripheral definition dtsi.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Renesas SuperH SH7751R common definition.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/sh/boot/dts/sh7751r.dtsi
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the SH7751R SoC
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>
> +#include <dt-bindings/clock/sh7750.h>
> +
> +/ {
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0 {
> +                     compatible = "renesas,sh4", "renesas,sh";
> +                     device_type = "cpu";
> +                     reg = <0>;
> +                     clocks = <&cpg SH7750_CPG_ICK>;
> +                     clock-names = "ick";
> +                     icache-size = <16384>;
> +                     icache-line-size = <32>;
> +                     dcache-size = <32768>;
> +                     dcache-line-size = <32>;

Wrong indentation (2 TABs and 6 spaces instead of 3 TABs).

> +               };
> +       };
> +
> +       xtal: oscillator {
> +               #clock-cells = <0>;
> +               compatible = "fixed-clock";
> +               clock-frequency = <0>;
> +               clock-output-names = "xtal";
> +       };
> +
> +       soc {

> +               scif1: serial@ffe80000 {
> +                       compatible = "renesas,scif-sh7751", "renesas,scif";
> +                       reg = <0xffe80000 0x100>;
> +                       interrupts = <evt2irq(0x700) 0>,
> +                                    <evt2irq(0x720) 0>,
> +                                    <evt2irq(0x760) 0>,
> +                                    <evt2irq(0x740) 0>;
> +                       interrupt-names = "eri", "rxi", "txi", "bri";
> +                       clocks = <&cpg SH7750_CPG_SCIF_CLK>;
> +                       clock-names = "fck";
> +                       power-domains = <&cpg>;

status = "disabled";

and add

    &scif1 {
            status = "okay";
    };

to each board .dts file that uses scif1.

> +               };

> +               pcic: pci@fe200000 {
> +                       compatible = "renesas,pci-sh7751";
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       #interrupt-cells = <1>;
> +                       device_type = "pci";
> +                       bus-range = <0 0>;
> +                       ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
> +                                <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
> +                       reg = <0xfe200000 0x0400>,
> +                             <0x0c000000 0x04000000>,
> +                             <0xff800000 0x0030>;

status = "disabled";

and add

    &pcic {
            status = "okay";
    };

to each board .dts file that uses pcic.

> +               };
> +       };
> +};

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
