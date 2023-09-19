Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC64CD5BA0
	for <linux-sh@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjISMI6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 19 Sep 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjISMIz (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 19 Sep 2023 08:08:55 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A2EF7
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:08:48 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-59be8a2099bso55191167b3.0
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695125327; x=1695730127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvvA+Yw4JbMtK7/ecupbOgxJeHUR4RIgBpK4rhgA0g8=;
        b=MuLcrqL6PXR8YcvNygDTLjBknzOFtNwKLZvz+JOEP+KRgW1Cr9DEUQADqFUxmF/QNt
         ib3GWUztM3L3XKLwDvE/0F6wkcLaCbSZjEnl2iPcjMgjuXBt2o/qRhBrNZ2AQqfi06r9
         dfali5BAkGItA0SEDwyps6FCzZ8hjE/XJcWsvhi4IjMewuFu2SMHggUKWYdtpFJ1NAm9
         hB76lk3CVocVtEp8hfDmDA4wFR0v1M/5h+WNsIbTeaGythLp2fHAG8LhJRDW0Ls7TZNY
         WYxZbTKRlQMgiEjgNeZoJ2G7uX+DBkpTqj45YBF6PSURaWJaQIeMd6ZIeJGiF8+4kCDN
         WR1Q==
X-Gm-Message-State: AOJu0YyGoA6MMjF1yq0qyjybxJeMAfe12NJEBCcbaZXObM9y36ETegCu
        kVoD4zdv1z8vnc5jzHy5qUZfW0gdni0vuA==
X-Google-Smtp-Source: AGHT+IEnTHJIw2Sg2VJXjqgsAyexCY7VxzKu4uU6p/oBs46JdA8Jg/M2VwNWbIQlyTSs3wKcO+ir3g==
X-Received: by 2002:a81:4888:0:b0:59b:d7c0:ea0c with SMTP id v130-20020a814888000000b0059bd7c0ea0cmr10878449ywa.11.1695125327275;
        Tue, 19 Sep 2023 05:08:47 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id b64-20020a0df243000000b005869fd2b5bcsm3159561ywf.127.2023.09.19.05.08.46
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:08:46 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59bdb3d03b1so55301897b3.3
        for <linux-sh@vger.kernel.org>; Tue, 19 Sep 2023 05:08:46 -0700 (PDT)
X-Received: by 2002:a25:d8c6:0:b0:d71:68e4:6db8 with SMTP id
 p189-20020a25d8c6000000b00d7168e46db8mr10885768ybg.34.1695125326098; Tue, 19
 Sep 2023 05:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <edb561b3738e9e6317857683c9350c078d370aa1.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <edb561b3738e9e6317857683c9350c078d370aa1.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 19 Sep 2023 14:08:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWuGn=Vts77M+uJWb3kE-R6CV6EFr-+DXYB6yvSc1tWHg@mail.gmail.com>
Message-ID: <CAMuHMdWuGn=Vts77M+uJWb3kE-R6CV6EFr-+DXYB6yvSc1tWHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 17/30] Documentation/devicetree: Add
 renesas,sh7751-irl-ext binding document.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:27 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> ---
>  .../renesas,sh7751-irl-ext.yaml               | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> new file mode 100644
> index 000000000000..dfc35717b92a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-irl-ext.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 IRL external encoder with enable regs.
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description: |
> +  This is the general used external interrupt encoder on SH7751 based boards.

generally

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,sh7751-irl-ext
> +
> +  '#interrupt-cells':
> +    # an interrupt index and flags, as defined in interrupts.txt in
> +    # this directory
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    minItems: 1
> +
> +  sh7751irl,width:

Vendor prefix should be "renesas" (everywhere).

> +    description: Enable register width

Specify

> +    $ref: /schemas/types.yaml#/definitions/uint32

Perhaps this should be specified implicitly, by using a
different compatible value depending on the register width?


> +
> +  sh7751irl,polarity:
> +    description: Enable register polarity

Specify

> +    $ref: /schemas/types.yaml#/definitions/uint32

Is this the interrupt polarity?  If yes, that should be specified
by the consumer through the last cell of the interrupts property
(IRQ_TYPE_*).

> +
> +  sh7751irl,irqbit:
> +    description: IRQ to enable register bit mapping
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - reg
> +  - sh7751irl,width
> +  - sh7751irl,polarity
> +  - sh7751,irqbit

Vendor prefix does not match above.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +        r2dintc: sh7751irl_encoder@a4000000 {

Please align "r2dintc" with the "|" above.

> +                compatible = "renesas,sh7751-irl-ext";
> +                reg = <0xa4000000 0x02>;
> +                interrupt-controller;
> +                #address-cells = <1>;

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-irl-ext.yaml

    sh7751irl_encoder@a4000000: '#address-cells' does not match any of
the regexes: 'pinctrl-[0-9]+'

> +                #interrupt-cells = <2>;
> +                sh7751irl,width = <16>;
> +                sh7751irl,polarity = <0>;
> +                sh7751irl,irqbit =<11>,         /* PCI INTD */
> +                                  <9>,          /* CF IDE */
> +                                  <8>,          /* CF CD */
> +                                  <12>,         /* PCI INTC */
> +                                  <10>,         /* SM501 */
> +                                  <6>,          /* KEY */
> +                                  <5>,          /* RTC ALARM */
> +                                  <4>,          /* RTC T */
> +                                  <7>,          /* SDCARD */
> +                                  <14>,         /* PCI INTA */
> +                                  <13>,         /* PCI INTB */
> +                                  <0>,          /* EXT */
> +                                  <15>;         /* TP */

    'sh7751irl,irqbit', 'sh7751irl,polarity', 'sh7751irl,width' do not
match any of the regexes ...

> +        };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
