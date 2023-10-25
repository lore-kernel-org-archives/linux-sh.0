Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70D9C0032E
	for <linux-sh@archiver.kernel.org>; Wed, 25 Oct 2023 12:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjJYMBV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 Oct 2023 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjJYMBT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 Oct 2023 08:01:19 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D38183;
        Wed, 25 Oct 2023 05:01:17 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1ef370c2e12so110267fac.1;
        Wed, 25 Oct 2023 05:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235276; x=1698840076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QbBPJm86iWSlQ/zh2oPDpTJ0w+De2gp5jhPbECwg6fA=;
        b=aM0hTF4SCBicReKGXEU8HjwF3DbQzJ802/O2Q/qjixYr30uD+MgTW4A6V8vER8Nmwt
         piza9Vyw1ZHYCfSppIX1i8lFy74uxHBzEylaHVXJLXIpI0F6krD/mHKULUhQ2kAG4v6k
         cQzhAgh8tR5SsyqgfYNF32U8NH5Q+W8sR1N/GT6+OfoN63APnCm17axqZeEUapxs8FgA
         w/DkMSCCwAWDK+3oThA+uls+5D7ppv4wFAaZlzdYUWJ/B2/a4jmX98bx7X7TfZksTB92
         6JIE3sR4hZYJ+4LmxmmK+fMAsgce+ZKnY9OXOKiOZZaiOV2p7NsQWZVpoYEIKgqMrS10
         ilpw==
X-Gm-Message-State: AOJu0YzFepaXvjeorv175u92z73Q4RlWMM5b25HRKOT10P5VgJNeoryk
        3avZMu3uiyND7vuq9qeiC4Cnhga9PEX49A==
X-Google-Smtp-Source: AGHT+IFzaK8IJnB0g1mln0lWI4BEEUyv3k9qt7T9u0qv4A4ZO3SOBC/BRIyseDHGW5tTp75ztZj13g==
X-Received: by 2002:a05:6870:9a87:b0:1bb:509a:824f with SMTP id hp7-20020a0568709a8700b001bb509a824fmr18636476oab.55.1698235276255;
        Wed, 25 Oct 2023 05:01:16 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id a6-20020a056870b14600b001eac9c1b923sm2592004oal.51.2023.10.25.05.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 05:01:15 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b3ec45d6e9so3477800b6e.0;
        Wed, 25 Oct 2023 05:01:15 -0700 (PDT)
X-Received: by 2002:a05:6808:1918:b0:3a8:7f65:a94 with SMTP id
 bf24-20020a056808191800b003a87f650a94mr21998907oib.42.1698235274916; Wed, 25
 Oct 2023 05:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <46ef748dd27127ef9b39fa6c97fe51e8d3422a4f.1697199949.git.ysato@users.sourceforge.jp>
 <CAMuHMdU5brBPGuCaMra6pS4MRFvBFQ5vF9tEFVre=-032xuuMg@mail.gmail.com> <87ttqf6jjq.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87ttqf6jjq.wl-ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Oct 2023 14:01:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUSxL0dUQ1kD2UaY95R5LB7sfwGkHrZVWdfBJhrgK6_ug@mail.gmail.com>
Message-ID: <CAMuHMdUSxL0dUQ1kD2UaY95R5LB7sfwGkHrZVWdfBJhrgK6_ug@mail.gmail.com>
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

On Wed, Oct 25, 2023 at 1:14 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Wed, 18 Oct 2023 23:27:43 +0900,
> Geert Uytterhoeven wrote:
> > On Sat, Oct 14, 2023 at 4:54 PM Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> > > Renesas SuperH binding definition.
> > >
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sh/cpus.yaml

> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> >
> > Missing
> >
> >     - jcore,j2
> >
> > > +          - renesas,sh4
> >
> >
> > > +      - const: renesas,sh
> >
> > I see arch/sh/boot/dts/j2_mimas_v2.dts lacks the fallback to
> > "renesas,sh", though.
> > Is there a common base of instructions that are available on all SH cores?
>
> The base instruction set is sh2.
> Before that, there is sh1, but this is not compatible with Linux.
> I think it would be a good idea to change this to "renesas,sh2",
> but the SH7619 (SH2 CPU) would look like the following.
> cpus {
>         cpu: cpu@0 {
>                 compatible = "renesas,sh2", "renesas,sh2";
>         };
> };

SH7619 would just use a single compatible value:

    compatible = "renesas,sh2".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
