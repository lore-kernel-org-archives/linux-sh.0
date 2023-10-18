Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A143CDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 14:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbjJRO2I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345602AbjJRO16 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 10:27:58 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332FD18C;
        Wed, 18 Oct 2023 07:27:56 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7af45084eso88221857b3.0;
        Wed, 18 Oct 2023 07:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697639275; x=1698244075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtA37ep95ms7H0RBa3MwH22KqngLIV2N9o8BRv0JTIM=;
        b=Ik19ImNqbKA+CsTRX1GuTLELHZHpMMxLNsRGP/FG1sV9klnfdgjNV1ugAzQl5x1h9S
         G+JKLgPiiygupiLjq1eJluE6Gci2DhCkkIEbqAud5QwtCP0wFn736bXnbLMmidXVfjWB
         L4g4JPRpmhGUfecoMeHzmTy0uExmW3LRZofBLt6dvn7cDWvXEoikbDwcepBH72i5Tk6P
         UTztqalUkucC7Umim915LjKQ51OLmGV61pP5lBzpa67da1g9T8ZL8ABcum11Vf9CT0JH
         G5uBlbqsuSkx1Aff+a+NtKbXXrjyh2zvpnQ7lXzcQ/Y+YqsuMRPRF24Jjq+Von8Rq7ts
         FE3w==
X-Gm-Message-State: AOJu0Yx7EvIygsQAv4P6uY/Xu+iFf3teuYg7N75EXAgybgLd7WYrUdf3
        hfSfgNW6CihpU4mBucwsbCthZdu/HtNWXA==
X-Google-Smtp-Source: AGHT+IEFdoOQ+3JBuk7J+44xjlPppPeTZisfovedpYRRkwveDqxx4BUf/zblVL9Wq3gRMgmEJfk1iw==
X-Received: by 2002:a81:7782:0:b0:599:b570:2db7 with SMTP id s124-20020a817782000000b00599b5702db7mr5736814ywc.30.1697639274972;
        Wed, 18 Oct 2023 07:27:54 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id w201-20020a8149d2000000b005845e6f9b50sm1549147ywa.113.2023.10.18.07.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 07:27:54 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7af45084eso88221717b3.0;
        Wed, 18 Oct 2023 07:27:54 -0700 (PDT)
X-Received: by 2002:a0d:d505:0:b0:5a8:187d:d5d5 with SMTP id
 x5-20020a0dd505000000b005a8187dd5d5mr5430680ywd.35.1697639274641; Wed, 18 Oct
 2023 07:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <46ef748dd27127ef9b39fa6c97fe51e8d3422a4f.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <46ef748dd27127ef9b39fa6c97fe51e8d3422a4f.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 16:27:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5brBPGuCaMra6pS4MRFvBFQ5vF9tEFVre=-032xuuMg@mail.gmail.com>
Message-ID: <CAMuHMdU5brBPGuCaMra6pS4MRFvBFQ5vF9tEFVre=-032xuuMg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 25/35] Documentation/devicetree/bindings/sh/cpus.yaml:
 Add SH CPU.
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
> Renesas SuperH binding definition.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sh/cpus.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sh/cpus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SuperH CPUs
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +description: |+
> +  The device tree allows to describe the layout of CPUs in a system through
> +  the "cpus" node, which in turn contains a number of subnodes (ie "cpu")
> +  defining properties for every cpu.
> +
> +  Bindings for CPU nodes follow the Devicetree Specification, available from:
> +
> +  https://www.devicetree.org/specifications/
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:

Missing

    - jcore,j2

> +          - renesas,sh4


> +      - const: renesas,sh

I see arch/sh/boot/dts/j2_mimas_v2.dts lacks the fallback to
"renesas,sh", though.
Is there a common base of instructions that are available on all SH cores?

Missing reg property.
Missing "device_type: true".

> +
> +  clock-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      CPU core clock freqency.

Perhaps a "clocks" property instead, or as an alternative?

On sh7750, you do have

    clocks = <&cpg SH7750_CPG_ICK>;

> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +        cpus {

make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/sh/cpus.yaml:

Documentation/devicetree/bindings/sh/cpus.example.dtb: cpus:
'#address-cells' is a required property
        from schema $id: http://devicetree.org/schemas/cpus.yaml#
        Documentation/devicetree/bindings/sh/cpus.example.dtb: cpus:
'#size-cells' is a required property
from schema $id: http://devicetree.org/schemas/cpus.yaml#

> +                cpu: cpu@0 {
> +                      compatible = "renesas,sh4", "renesas,sh";

Documentation/devicetree/bindings/sh/cpus.example.dts:19.28-21.19:
Warning (unit_address_vs_reg): /example-0/cpus/cpu@0: node has a unit
name, but no reg or ranges property
Documentation/devicetree/bindings/sh/cpus.example.dtb: cpus: cpu@0:
'cache-level' is a required property
        from schema $id: http://devicetree.org/schemas/cpus.yaml#

> +                };
> +        };
> +...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
