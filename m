Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D636CE7A89
	for <linux-sh@archiver.kernel.org>; Mon, 25 Sep 2023 07:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjIYHi7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 25 Sep 2023 03:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjIYHi6 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 25 Sep 2023 03:38:58 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AEBE8
        for <linux-sh@vger.kernel.org>; Mon, 25 Sep 2023 00:38:51 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f7f46b326so13063257b3.0
        for <linux-sh@vger.kernel.org>; Mon, 25 Sep 2023 00:38:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695627531; x=1696232331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67nias3UKZBV2bmA6jdJb5nINRglbHzcMeJTk1yqD3Y=;
        b=UQPsAONSA+Ty1xtXbOWQX0BkYmoab3HJwvXPyqrRFvYYd5xPfCZGRw6jE9CFg16rXX
         DllV1hc0FS7AW/6diHJnKK0mKomFQCAPS6X87b6S2rCmFKSDJiTBGhb7Z5PeG2s+zMrS
         HLMH6c2UcAOAutZYAjXssRr9M/FgNB8RhvhxHpX8BlcTnuJjRcpL8aqt1XVzDEs63Q3P
         Vk9ZInu1AHy8v3Gwz/NLYomR1R704dxppQ22SpBh3IpWTkPIO5NGxnmeFX1JlcoH2EYr
         uieczxiZ/Q3DHt7747DGhabNCOvH6WlY8D3MK2dBSlPMdkCwlbOblwo7jRGN8OsZNGGz
         RYOw==
X-Gm-Message-State: AOJu0YyiACu+chb316fJuXL1hvzc2Vuikj8Azfc4LFrDN57yNlh6YiSF
        LHkAyj5lTrSs++SxSceLUuGj6Gb7oY1gog==
X-Google-Smtp-Source: AGHT+IGUcitBAcETtNFrMQKgjmIOFKuNuJ7BpAm6cbiov7k95h4lZiJK6kP69CufWlp7tjYEJJGKuA==
X-Received: by 2002:a81:a247:0:b0:583:d1fa:1fc4 with SMTP id z7-20020a81a247000000b00583d1fa1fc4mr4707357ywg.26.1695627530777;
        Mon, 25 Sep 2023 00:38:50 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id m23-20020a0dca17000000b0057d24f8278bsm2248592ywd.104.2023.09.25.00.38.50
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 00:38:50 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59f6e6b7600so18275027b3.3
        for <linux-sh@vger.kernel.org>; Mon, 25 Sep 2023 00:38:50 -0700 (PDT)
X-Received: by 2002:a81:54d5:0:b0:59b:fcca:afc6 with SMTP id
 i204-20020a8154d5000000b0059bfccaafc6mr5243078ywb.50.1695627530021; Mon, 25
 Sep 2023 00:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <1f9decd26e1321e30ca5091c2447456f0e81efe1.1694596125.git.ysato@users.sourceforge.jp>
 <CAMuHMdXv3TPa=mCrso9P1Mbh8yCAzNusiX9ELF3mFCi4oY0igA@mail.gmail.com> <87pm2att29.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87pm2att29.wl-ysato@users.sourceforge.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 09:38:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVaaVxM77OcNVC3pkJ2Qs02OGA83kXEO9ExJcjsK261fw@mail.gmail.com>
Message-ID: <CAMuHMdVaaVxM77OcNVC3pkJ2Qs02OGA83kXEO9ExJcjsK261fw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 14/30] drivers/irqchip: Add SH7751 Internal INTC drivers.
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Sato-san,

On Fri, Sep 22, 2023 at 12:12 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> On Tue, 19 Sep 2023 20:50:14 +0900,
> Geert Uytterhoeven wrote:
> > On Wed, Sep 13, 2023 at 11:24 AM Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> > > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/irqchip/Kconfig
> > > +++ b/drivers/irqchip/Kconfig
> > > @@ -679,4 +679,13 @@ config SUNPLUS_SP7021_INTC
> > >           chained controller, routing all interrupt source in P-Chip to
> > >           the primary controller on C-Chip.
> > >
> > > +config RENESAS_SH7751_INTC
> > > +        bool "Renesas SH7751 Interrupt Controller"
> > > +       depends on SH_DEVICE_TREE
> >
> > "|| COMPILE_TEST"?
> >
> > > +       select IRQ_DOMAIN
> > > +       select IRQ_DOMAIN_HIERARCHY
> > > +       help
> > > +         Support for the Renesas SH7751 On-chip interrupt controller.
> > > +         And external interrupt encoder for some targets.
> >
> > Inconsistent indentation
> >
> > > --- /dev/null
> > > +++ b/drivers/irqchip/irq-renesas-sh7751.c
> >
> > > +/* INTEVT to IPR mapping */
> > > +static const struct iprmap {
> > > +       int intevt;
> >
> > irq, as you're storing the irq number not the event number?
> >
> > > +       int off;
> > > +       int bit;
> >
> > All unsigned int ...
> >
> > > +} iprmaps[] = {
> > > +#define IPRDEF(e, o, b) { .intevt = evt2irq(e), .off = o, .bit = b }
> > > +       IPRDEF(0x240, IPRD, IPR_B12),   /* IRL0 */
> > > +       IPRDEF(0x2a0, IPRD, IPR_B8),    /* IRL1 */
> > > +       IPRDEF(0x300, IPRD, IPR_B4),    /* IRL2 */
> > > +       IPRDEF(0x360, IPRD, IPR_B0),    /* IRL3 */
> > > +       IPRDEF(0x400, IPRA, IPR_B12),   /* TMU0 */
> > > +       IPRDEF(0x420, IPRA, IPR_B8),    /* TMU1 */
> > > +       IPRDEF(0x440, IPRA, IPR_B4),    /* TMU2 TNUI */
> > > +       IPRDEF(0x460, IPRA, IPR_B4),    /* TMU2 TICPI */
> > > +       IPRDEF(0x480, IPRA, IPR_B0),    /* RTC ATI */
> > > +       IPRDEF(0x4a0, IPRA, IPR_B0),    /* RTC PRI */
> > > +       IPRDEF(0x4c0, IPRA, IPR_B0),    /* RTC CUI */
> > > +       IPRDEF(0x4e0, IPRB, IPR_B4),    /* SCI ERI */
> > > +       IPRDEF(0x500, IPRB, IPR_B4),    /* SCI RXI */
> > > +       IPRDEF(0x520, IPRB, IPR_B4),    /* SCI TXI */
> > > +       IPRDEF(0x540, IPRB, IPR_B4),    /* SCI TEI */
> > > +       IPRDEF(0x560, IPRB, IPR_B12),   /* WDT */
> > > +       IPRDEF(0x580, IPRB, IPR_B8),    /* REF RCMI */
> > > +       IPRDEF(0x5a0, IPRB, IPR_B4),    /* REF ROVI */
> > > +       IPRDEF(0x600, IPRC, IPR_B0),    /* H-UDI */
> > > +       IPRDEF(0x620, IPRC, IPR_B12),   /* GPIO */
> > > +       IPRDEF(0x640, IPRC, IPR_B8),    /* DMAC DMTE0 */
> > > +       IPRDEF(0x660, IPRC, IPR_B8),    /* DMAC DMTE1 */
> > > +       IPRDEF(0x680, IPRC, IPR_B8),    /* DMAC DMTE2 */
> > > +       IPRDEF(0x6a0, IPRC, IPR_B8),    /* DMAC DMTE3 */
> > > +       IPRDEF(0x6c0, IPRC, IPR_B8),    /* DMAC DMAE */
> > > +       IPRDEF(0x700, IPRC, IPR_B4),    /* SCIF ERI */
> > > +       IPRDEF(0x720, IPRC, IPR_B4),    /* SCIF RXI */
> > > +       IPRDEF(0x740, IPRC, IPR_B4),    /* SCIF BRI */
> > > +       IPRDEF(0x760, IPRC, IPR_B4),    /* SCIF TXI */
> > > +       IPRDEF(0x780, IPRC, IPR_B8),    /* DMAC DMTE4 */
> > > +       IPRDEF(0x7a0, IPRC, IPR_B8),    /* DMAC DMTE5 */
> > > +       IPRDEF(0x7c0, IPRC, IPR_B8),    /* DMAC DMTE6 */
> > > +       IPRDEF(0x7e0, IPRC, IPR_B8),    /* DMAC DMTE7 */
> > > +       IPRDEF(0xa00, INTPRI00, IPR_B0),        /* PCIC PCISERR */
> > > +       IPRDEF(0xa20, INTPRI00, IPR_B4),        /* PCIC PCIDMA3 */
> > > +       IPRDEF(0xa40, INTPRI00, IPR_B4),        /* PCIC PCIDMA2 */
> > > +       IPRDEF(0xa60, INTPRI00, IPR_B4),        /* PCIC PCIDMA1 */
> > > +       IPRDEF(0xa80, INTPRI00, IPR_B4),        /* PCIC PCIDMA0 */
> > > +       IPRDEF(0xaa0, INTPRI00, IPR_B4),        /* PCIC PCIPWON */
> > > +       IPRDEF(0xac0, INTPRI00, IPR_B4),        /* PCIC PCIPWDWN */
> > > +       IPRDEF(0xae0, INTPRI00, IPR_B4),        /* PCIC PCIERR */
> > > +       IPRDEF(0xb00, INTPRI00, IPR_B8),        /* TMU3 */
> > > +       IPRDEF(0xb80, INTPRI00, IPR_B12),       /* TMU4 */
> >
> > Probably the same or a very similar interrupt controller is present
> > on other SoCs? Then the comments don't make much sense, as the actual
> > interrupt mapping is specified in the DTS anyway.
>
> This interrupt controller design is quite old, so there doesn't seem to be
> any SoC with a similar design.

OK.

> Since the SH interrupt controllers have almost the same design,
> I think this driver can be used for other devices besides the SH7751.

Wait, this contradicts your sentence above?

> I think a good way to write IPR mapping is to use dts.

If there is one thing we learned from putting full clock controller and PM
Domain hierarchies in DT, it is that that turned out to be very fragile.
It is hard not to make mistakes in the description, and easy to miss
a critical aspect of the hardware that needs changes later.
So that's why it's better to differentiate through the compatible value,
instead of through (lots of) properties: you can always fix the driver,
while DT is a stable ABI.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
