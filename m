Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E78C07548
	for <linux-sh@archiver.kernel.org>; Wed, 15 Nov 2023 08:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbjKOIRh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 15 Nov 2023 03:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOIRg (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 15 Nov 2023 03:17:36 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C442EE
        for <linux-sh@vger.kernel.org>; Wed, 15 Nov 2023 00:17:32 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a82f176860so75520687b3.1
        for <linux-sh@vger.kernel.org>; Wed, 15 Nov 2023 00:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700036251; x=1700641051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxIm1RkCI6eMHyQydAYztK7WL8Z/Eyq2vxfsv8dJlqo=;
        b=sZBjKn85hnUTWILapyv6/P0UArbFsPAShg99ura85Nt0Vl3x5Pu5PUH10vG3Y+ty+7
         +f8GHGp8R53QZOsZzdlkKbZt4lg1m08zmqz8PF1KhDgFCJzxlbFJn3Uhr5d3+HurGYSP
         UoOTFEm+g/X13MMvgOu7gkUiteiVNjM6ibSHuMcDYyZPG+dFTBeF/0g1BTbGLzjiABBy
         /7YFBdzRgy9XNmW9wqwIBJxno7eAo42MaMjGEqk7ETDGUIwNxAZAamXSmrwXL0S++w6G
         gUytqVqEapVVM+BetQX5S75bGp4iYy9iqCbqbVtb74OUN+s5jROsNqBJ7qXdKTWe6wJU
         iafw==
X-Gm-Message-State: AOJu0YzsN4ljb+y0LAwTEw3IB/M0tyyeAuK00Us9rALXua8UR4mrB8Nv
        CwaJBdFE23Io6haQU4qoZL5lJweXW8iTog==
X-Google-Smtp-Source: AGHT+IHtWq2giand8Sb6dzOfQ9WXHx4lD5Kwl5Z7t2TMvX18KC9FpQIecv4uCGPrY47y0Jdwp5/gUQ==
X-Received: by 2002:a25:ac7:0:b0:db0:33fe:4125 with SMTP id 190-20020a250ac7000000b00db033fe4125mr968813ybk.57.1700036251527;
        Wed, 15 Nov 2023 00:17:31 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id d131-20020a254f89000000b00d9a4aad7f40sm226982ybb.24.2023.11.15.00.17.30
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 00:17:31 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a82f176860so75520527b3.1
        for <linux-sh@vger.kernel.org>; Wed, 15 Nov 2023 00:17:30 -0800 (PST)
X-Received: by 2002:a0d:d5d2:0:b0:5a7:bde8:51d5 with SMTP id
 x201-20020a0dd5d2000000b005a7bde851d5mr13624089ywd.32.1700036250737; Wed, 15
 Nov 2023 00:17:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <31c717c18bd94839d46c4de726cc573ff563b3e1.1699856600.git.ysato@users.sourceforge.jp>
 <c7202095-1219-4cbd-ace4-23b6e7784f11@kernel.org>
In-Reply-To: <c7202095-1219-4cbd-ace4-23b6e7784f11@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 15 Nov 2023 09:17:18 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV-B1DY2kqSo+J_p8enzQxUkWzhL1x+HEC+52PoKHR33Q@mail.gmail.com>
Message-ID: <CAMuHMdV-B1DY2kqSo+J_p8enzQxUkWzhL1x+HEC+52PoKHR33Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/37] dt-bindings: timer: renesas,tmu: add renesas,tmu-sh7750
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Krzysztof,

On Tue, Nov 14, 2023 at 10:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 14/11/2023 09:00, Yoshinori Sato wrote:
> > Add SH7750 TMU entry.
> >
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> > diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> > index a67e427a9e7e..925c2a691b25 100644
> > --- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> > +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
> > @@ -21,6 +21,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - renesas,tmu-sh7750   # SH7750
> >            - renesas,tmu-r8a7740  # R-Mobile A1
> >            - renesas,tmu-r8a774a1 # RZ/G2M
> >            - renesas,tmu-r8a774b1 # RZ/G2N
> > @@ -46,7 +47,14 @@ properties:
> >
> >    interrupts:
> >      minItems: 2
> > -    maxItems: 3
> > +    maxItems: 4
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: tuni0
> > +      - const: tuni1
> > +      - const: tuni2
> > +      - const: ticpi2
>
> Other variants should be constrained to three items.

Actually that is not true: the number of interrupts depends on the
instance, not on the SoC.  The fourth interrupt is present on some
instances on other SoCs, too, but was never described before, as the
driver doesn't support it yet (I know this is not a good reason).
Of course none of this is obvious to the casual reviewer if it is
not mentioned in the patch description...

I'm working on making this more clear, and adding support for missing
variants.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
