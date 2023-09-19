Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB0CD5BAA
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjISMlX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjISMlW (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:41:22 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F69E3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:41:16 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59c0281d72dso46901877b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127276; x=1695732076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujrSh/MYZMOfPaBZEFkJd6vdZLlLU5VMqhdUgUGXywA=;
        b=gvnsLKnVtUSr4ajr9G6ECIZQzP1XiRUGUfuv7n0K0tBnEE0SkvWjKgJUzQ3ZxdlC/c
         bdJWDSfwSczeMhxqL9tYflo+GZoLdFdbBri3daLz8pgTIsSEm7ZzoY9vCilg77OWSXP4
         /I770uSVUPFag1etd8ypqZ8gp6OgoFlNE4drlRQ9cqOHutVddZHXVaWElR99LuUXpleR
         XVT3+fnUuo1Najd81r2IbKcz0ifqw76J5NM3npA+llFgsvD7Ss3HUkgYLJAgQgXvD5fS
         +FkV2+yaoXKAWYRMWMUUN99pCP2Esy2P9PcGI9wTe0vr89wgJNcwbi+PbOwnEM3Um+Iq
         8M/g==
X-Gm-Message-State: AOJu0YytQsIEPUr7GqYZH8pp/YkeUK22vv1JrzeLefbBKdalL6XgzF/B
        zJnLxhxeLDySggszf6r9cmanzzb5I5W5wg==
X-Google-Smtp-Source: AGHT+IG4ogj5Hn8BFGDttwMKUFfmI2MDnFuOkU7ANq6ngpMDihpj/hy29nuPaH3RSCpKm7muuc0+WQ==
X-Received: by 2002:a0d:d906:0:b0:59c:b22:b858 with SMTP id b6-20020a0dd906000000b0059c0b22b858mr12767239ywe.9.1695127275773;
        Tue, 19 Sep 2023 05:41:15 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id n19-20020a819c53000000b0059b4e981fe6sm3084594ywa.102.2023.09.19.05.41.15
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:41:15 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59c0281d72dso46901657b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:41:15 -0700 (PDT)
X-Received: by 2002:a25:cf06:0:b0:d74:6c9f:e734 with SMTP id
 f6-20020a25cf06000000b00d746c9fe734mr10986721ybg.47.1695127275300; Tue, 19
 Sep 2023 05:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <4bf42fc7a928e9a726ea20ee4e2168f993bb34f7.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:41:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLnU6oWWwYdk-HZewOsC05=uRXw8F7Mm69RAyWA86_yQ@mail.gmail.com>
Message-ID: <CAMuHMdWLnU6oWWwYdk-HZewOsC05=uRXw8F7Mm69RAyWA86_yQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 23/30] arch/sh: Add SH7751 SoC Internal periphreal devicetree.
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
> +++ b/arch/sh/boot/dts/sh7751.dtsi
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree Source for the SH7751 SoC
> + */
> +
> +#include <dt-bindings/interrupt-controller/sh_intc.h>
> +#include <dt-bindings/clock/sh7750.h>
> +
> +/ {

Missing top-level compatible property:

    compatible = "renesas,sh7751r";

And of course this compatible value should be documented in
Documentation/devicetree/bindings/soc/renesas/renesas.yaml

> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;

Please add a blank line between properties and subnodes.

> +               cpu@0 {
> +                     compatible = "renesas,sh7751r","renesas,sh4", "renesas,sh";
> +               };
> +       };
> +
> +       clocks {

s/clocks/soc/, and move everything below inside the "soc" container.

> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +               ranges;
> +
> +               cpg: cpg@ffc00000 {

Please use generic node names: clock-controller@ffc00000;

> +                       #clock-cells = <1>;
> +                       compatible = "renesas,sh7750-cpg";
> +                       clocks = <&xtal>;
> +                       reg = <0xffc00000 2>, <0xffc00008 4>;
> +               };
> +
> +       };
> +
> +       shintc: interrupt-controller@ffd00000 {
> +               compatible = "renesas,sh7751-intc";
> +               #interrupt-cells = <2>;
> +               #address-cells = <0>;
> +               interrupt-controller;
> +               reg = <0xffd00000 14>, <0xfe080000 128>;
> +       };
> +
> +       /* sci0 is rarely used, so it is not defined here. */
> +       scif1: serial@ffe80000 {
> +               compatible = "renesas,scif";

Please add (and document!) "renesas,scif-sh7751".

> +               reg = <0xffe80000 0x100>;
> +               interrupts = <evt2irq(0x700) 0>,
> +                            <evt2irq(0x720) 0>,
> +                            <evt2irq(0x760) 0>,
> +                            <evt2irq(0x740) 0>;
> +               interrupt-names = "eri", "rxi", "bri", "txi";

make dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/serial/renesas,scif.yaml

    serial@ffe80000: interrupt-names: 'oneOf' conditional failed, one
must be fixed:
        ['eri', 'rxi', 'bri', 'txi'] is too short
        'txi' was expected
        'bri' was expected

The "bri" and "txi" entries must be exchanged, both in the
"interrupts" and "interrupt-names" properties.

> +               clocks = <&cpg SH7750_CPG_FCK>;

clock-names = "fck";

> +       };
> +
> +       /* Normally ch0 and ch1 are used, so we will define ch0 to ch2 here. */
> +       tmu0: timer@ffd80008 {
> +               compatible = "renesas,tmu";

Please add (and document!) "renesas,tmu-sh7751".

> +               reg = <0xffd80000 12>;
> +               interrupts = <evt2irq(0x400) 0>,
> +                            <evt2irq(0x420) 0>,
> +                            <evt2irq(0x440) 0>,
> +                            <evt2irq(0x460) 0>;
> +               interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";

This will need an update to the bindings, and the driver, too.

> +               clocks = <&cpg SH7750_CPG_FCK>;

clock-names = "fck";

> +               renesas,channels = <3>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
