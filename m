Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2ECCD13D2
	for <linux-sh@archiver.kernel.org>; Mon, 18 Sep 2023 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjIRTVn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Sep 2023 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjIRTVl (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Sep 2023 15:21:41 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A406109;
        Mon, 18 Sep 2023 12:21:36 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59eb8ec5e20so9449747b3.3;
        Mon, 18 Sep 2023 12:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695064895; x=1695669695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0dW6AoTKkz4jLhUFnqBkCrA/BrnwDf+oybX7T9QQGw=;
        b=og1kJfovBQvrHxnh0tt1fFhgvI5EOu5Wh65juD+nsdvHq/iKVvXdh88fQ8XWpKVs0x
         PfmOke4n0HXeCJJ9mYSdd2Gb1wChd7p4xYdyJKROcBjedXw+nyLvPFVRcNElNydEY9S1
         JSRBWO0CCFCBICB0YNHntiZDDXWWfphCHRckhid2WObbTlPwhOb7UKa+YioqBOomMaEp
         miGHKWdpsynDXKkQpdbsPx7OcQnNrAkMGN2gPcqyQSav4Kpu7q8foCE55zAHExv/AYaR
         YRmid+5wnvHTng5OfHxis7K48xJv21JdGCHLSV5HsLMhEts6TNIVSWjLsN0RlY+g49GE
         zJRA==
X-Gm-Message-State: AOJu0YwY98LMy5QTTiif3yDP+te2jaPHFr5KTr2hRohVq1HRfjbpu8fS
        nShE3peHAC5mTaoFwiOMDho4SFPCRheMxA==
X-Google-Smtp-Source: AGHT+IEwFmZqfaDWHIqtsGe2FZpSRJOfMqrn8Vb7ANwwBh9j99GlJSn8JB1WtYexRiZDbwDrJAC4Vw==
X-Received: by 2002:a05:690c:f15:b0:59c:2d8f:1c33 with SMTP id dc21-20020a05690c0f1500b0059c2d8f1c33mr11886606ywb.19.1695064894988;
        Mon, 18 Sep 2023 12:21:34 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id v129-20020a814887000000b0059b516ed11fsm2786987ywa.110.2023.09.18.12.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 12:21:33 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-59c07cf02ebso36293357b3.1;
        Mon, 18 Sep 2023 12:21:33 -0700 (PDT)
X-Received: by 2002:a81:9192:0:b0:591:4f2b:7eea with SMTP id
 i140-20020a819192000000b005914f2b7eeamr11340223ywg.18.1695064893534; Mon, 18
 Sep 2023 12:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp> <66ed5e27cb600f3317d315c4fd60bd3e9eb09c17.1694596125.git.ysato@users.sourceforge.jp>
In-Reply-To: <66ed5e27cb600f3317d315c4fd60bd3e9eb09c17.1694596125.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Sep 2023 21:21:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVzxiD1C8s6kY3dzX93WT6RC5HK_4qaDy_81wk3CnHSHg@mail.gmail.com>
Message-ID: <CAMuHMdVzxiD1C8s6kY3dzX93WT6RC5HK_4qaDy_81wk3CnHSHg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/30] Documentation/devicetree: Add
 renesas,sh7751-cpg binding document.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Wed, Sep 13, 2023 at 11:26 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

Patch prefix should be "dt-bindings: clock: renesas:".

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/renesas,cpg-clocks.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7750 / SH7751 Clock Pulse Generator (CPG)
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description:
> +  The Clock Pulse Generator (CPG) generates core clocks for the SoC.  It
> +  includes PLLs, and fixed and variable ratio dividers.
> +
> +  The CPG may also provide a Clock Domain for SoC devices,

That functionality would require '#power-domain-cells'.

> +
> +properties:
> +  compatible:
> +      - const: renesas,sh7750-cpg      # SH7750 / 7750S / 7751

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml:

    Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml:20:7:
[warning] wrong indentation: expected 4 but found 6 (indentation)
    Documentation/devicetree/bindings/clock/renesas,sh7750-cpg.yaml:20:34:
[error] syntax error: found character '\t' that cannot start any token
(syntax)

> +      - items:
> +          - const: renesas,sh7750r-cpg # SH7750R / 7751R

This is the wrong order for compatible values: they should be ordered
from most-specific to least-specific.
However, given the small but significant differences between the
different variants, I think you need to define all five:

  compatible:
    enum:
      - renesas,sh7750-cpg
      - renesas,sh7750r-cpg
      - renesas,sh7750s-cpg
      - renesas,sh7751-cpg
      - renesas,sh7751r-cpg

> +  reg:
> +    maxItems: 2
> +    items:
> +      - description: FRQCR register
> +      - description: WDT registers

I think the above should be combined into one larger block, containing
the CPG, standby control, and watchdog registers.
A second block would contain the clock stop registers.  Even although
the driver doesn't support these yet, it would be good to have them
in DT.

And probably you want to specify "reg-names", too.

> +
> +  clocks: true

maxItems: 1

> +
> +  '#clock-cells':
> +    const: 1
> +
> +  renesas,mode:
> +    description: Board-specific settings of the MD0 - MD2 bits
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 6
> +
> +required:
> +  - compatible
> +  - reg

+ reg-names

> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a7740-clock.h>
> +        cpg: cpg@ffc00000 {

Please align "cpg:" with "#include" above, using spaces as indentation.

> +               #clock-cells = <1>;
> +               compatible = "renesas,sh7750r-cpg","renesas,sh7750-cpg";
> +               clocks = <&xtal>;
> +               reg = <0xffc00000 2>, <0xffc00008 4>;
> +               renesas,mode = <0x05>
> +        };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
