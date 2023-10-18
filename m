Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45DCDB47E
	for <linux-sh@archiver.kernel.org>; Wed, 18 Oct 2023 19:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjJRToa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 18 Oct 2023 15:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJRTo3 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 18 Oct 2023 15:44:29 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0111D;
        Wed, 18 Oct 2023 12:44:26 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9a398f411fso8216536276.3;
        Wed, 18 Oct 2023 12:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658266; x=1698263066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYlJPAKvGgtxmDlJtVju6/BtRKTJy4g4M4v62wxEzzk=;
        b=QnXIxWPhw9iFSEwyOcOJCHqGHexrI/q0qhZJVIsl1QLwR4hDlmUfZ8tXK8tqbKkAgf
         W1xO/tzby97nPFkIGh3QV8Uz8qC5GpzglpzZMJj+TYEy7cUxliIaeo8MRCWayzIVRQeK
         SS9a1fmiVUxVSiEFYmzK2Whn8gvwrXuLfN1JQsqDoMLIAnpgzu+0jKXQNUiCo4WqkH8E
         ZjG2aZdTJJSQdGaDnFXhe6X6DN7dGnpUxn9pRVr9rorgBICpFhqZTrR0P90io535OQ+c
         nMv5RTLA+09pzw9r7/wf5NF37Z6h7KF/eJmu9e1w9+lDH75tjaeww4OA2rM4LuawXFN5
         XDRA==
X-Gm-Message-State: AOJu0Ywc4C5snbD7cJXpgLHIEgVOcbm6WLy7lWk2eRw5mDHGUDG7tRGY
        w4mF9vRez0BCJkt6TBrrr1AZ6AczInbqkA==
X-Google-Smtp-Source: AGHT+IHEaGgG9/++fnhUFsvpxwLfbSOjOGAZ9ylttFjnwFOD0BWIn0EMGKnBASTenvBjR0HQatJpeg==
X-Received: by 2002:a5b:dc9:0:b0:d7e:9eeb:998e with SMTP id t9-20020a5b0dc9000000b00d7e9eeb998emr334538ybr.4.1697658265699;
        Wed, 18 Oct 2023 12:44:25 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id m8-20020a258c88000000b00d20d4ffbbdbsm1510342ybl.0.2023.10.18.12.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:44:25 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5a7c7262d5eso90822037b3.1;
        Wed, 18 Oct 2023 12:44:25 -0700 (PDT)
X-Received: by 2002:a05:690c:97:b0:577:3d46:f90e with SMTP id
 be23-20020a05690c009700b005773d46f90emr304745ywb.32.1697658265069; Wed, 18
 Oct 2023 12:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <35311df6cf65c9f110604cbbdecad2f15ac602b6.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdVjyPchHd8Hzcy+1Pv-57M_eD9rPSDmT88M3bSeEUn86A@mail.gmail.com>
In-Reply-To: <CAMuHMdVjyPchHd8Hzcy+1Pv-57M_eD9rPSDmT88M3bSeEUn86A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 18 Oct 2023 21:44:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXR1qW9yD6xwQ-G9no85E2uQaje+PWnLvQwke-v_J-TUg@mail.gmail.com>
Message-ID: <CAMuHMdXR1qW9yD6xwQ-G9no85E2uQaje+PWnLvQwke-v_J-TUg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 29/35] Documentation/devicetree/bindings/soc/renesas/sh.yaml:
 Add SH7751 based target.
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

On Wed, Oct 18, 2023 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > Renesas SuperH based target definition.
> >
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/renesas/sh.yaml
> > @@ -0,0 +1,32 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/renesas/sh.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas SuperH Platform
> > +
> > +maintainers:
> > +  - Yoshinori Sato <ysato@users.sourceforge.jp>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: RTS7751R2D Plus
> > +        items:
> > +          - enum:
> > +              - renesas,rts7751r2d # Renesas SH4 2D graphics board
> > +          - const: renesas,sh7751r
> > +
> > +      - description: Julian board
> > +        items:
> > +          - enum:
> > +              - iodata,landisk  # LANDISK HDL-U
> > +              - iodata,usl-5p   # USL-5P
> > +          - const: renesas,sh7751r
>
> Please merge both sections, as they use the same number of compatible
> values and the same fallback.

Unless we want to add an "renesas,sh7380" intermediate, as that is
the actual SoC in the landisk? I do not know what is the difference
between SH7380 and SH7751R.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
