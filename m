Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A71CDB465
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 11:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjJSL3z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 07:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345321AbjJSL3y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 07:29:54 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BE9115;
        Thu, 19 Oct 2023 04:29:53 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7d9d357faso98304367b3.0;
        Thu, 19 Oct 2023 04:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697714992; x=1698319792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RA1zBXtdscpq7XNkDa/o5ltqzsoIFE7OWdMN+soibQ=;
        b=lKsZpwR2Wvm8dKR1fLXSTSkbCt+SskYSK/LiYPuJywyWl1p2es5CnSU3WLYNC9LFcd
         b3NaxwxFgDk9/KDhy31FmaYHqpWhzkXhER6VzJvMNCFHPE6fKyUgVT47O6StgfXOwSeG
         cbNfZOZYI+WQLK1nmf+Hnt8WCBwnrKnKqV2e0iFpGtpjs8HyY0Gs5Jx+W2sQN6jEAuVH
         5/ig/3lcDfxECesEeS5Jbf9RZJfxGf0FiVD0MgTcW6R1pU66kvXH1iyXyMweEg/X6/Wa
         43FdJKz7Ypa+PrqTrQ7gYLatg8BZT4yK4TDU6RoYM2o4jpTVq83DtMcp1rF+jLYWwiDV
         AnVg==
X-Gm-Message-State: AOJu0YyH2y6MiWu1jRfqK2p5ikMhBTE04ijBx/Tl2+ulS/vgb1UhRYxI
        A3oTZM/wGW4anBpMBMZwzkPtsAdJ2YZCfQ==
X-Google-Smtp-Source: AGHT+IF0hoDS8+FrNfXk3nG5KjG7cRE36GGB2Fq90ouQpaSmHkwbsvYEjmWcmEQJ/3iinqtG+xrY1Q==
X-Received: by 2002:a05:690c:d8f:b0:5a7:f933:c8c4 with SMTP id da15-20020a05690c0d8f00b005a7f933c8c4mr2389980ywb.14.1697714991958;
        Thu, 19 Oct 2023 04:29:51 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id w201-20020a8149d2000000b005845e6f9b50sm2363256ywa.113.2023.10.19.04.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 04:29:51 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d852b28ec3bso8864594276.2;
        Thu, 19 Oct 2023 04:29:50 -0700 (PDT)
X-Received: by 2002:a5b:404:0:b0:d9c:7d7d:1ac9 with SMTP id
 m4-20020a5b0404000000b00d9c7d7d1ac9mr2139736ybp.14.1697714990452; Thu, 19 Oct
 2023 04:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp> <eee98f679a9e86180ce047de319edcd30ac38d8b.1697199949.git.ysato@users.sourceforge.jp>
In-Reply-To: <eee98f679a9e86180ce047de319edcd30ac38d8b.1697199949.git.ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 Oct 2023 13:29:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXFuXKDKu7EAtECtMhOZb+Mzjfz7KWQVTSeTNo5G7xqrg@mail.gmail.com>
Message-ID: <CAMuHMdXFuXKDKu7EAtECtMhOZb+Mzjfz7KWQVTSeTNo5G7xqrg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 15/35] Documentation/devicetree/bindings/interrupt-controller:
 Add renesas,sh7751-intc.yaml
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        tglx@linutronix.de, maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> SH7751 interrupt controller binding definition.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/renesas,sh7751-intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas SH7751 Interrupt Controller
> +
> +maintainers:
> +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,sh7751-intc
> +
> +  '#interrupt-cells':
> +    # an interrupt index and flags, as defined in interrupts.txt in
> +    # this directory

I think you can drop this comment.

> +    const: 2

> +examples:
> +  - |

Missing

    #include <dt-bindings/interrupt-controller/sh_intc.h>

Please run

    make dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.yaml

to catch such issues before posting.

> +        shintc: interrupt-controller@ffd00000 {

Please align this to the "|" above, and use 4 spaces for each additional
indentation step.

> +                compatible = "renesas,sh7751-intc";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
