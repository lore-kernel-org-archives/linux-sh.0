Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E29C77B71
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 08:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDRILB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjDRILA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 04:11:00 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A8A8A5C
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 01:10:24 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pogPh-002n0T-AJ; Tue, 18 Apr 2023 10:10:09 +0200
Received: from p5b13a017.dip0.t-ipconnect.de ([91.19.160.23] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pogPh-001KJx-0Q; Tue, 18 Apr 2023 10:10:09 +0200
Message-ID: <08823dbc7d6abb99958993bc35e315a3eb0e63bb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] Fix J-core aic warning spam
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Date:   Tue, 18 Apr 2023 10:10:07 +0200
In-Reply-To: <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
         <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
         <CAMuHMdVxTtoV5_+tEeoTT6hSEBkK8ZsHtu8t6jumvUK6u5effQ@mail.gmail.com>
         <e4f89e6f-b7fb-6cfc-c90c-03ecdefe602a@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.0 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.23
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, 2023-04-18 at 03:09 -0500, Rob Landley wrote:
> 
> On 4/18/23 02:18, Geert Uytterhoeven wrote:
> > Hi Adrian, Rob,
> > 
> > On Tue, Apr 18, 2023 at 8:19 AM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
> > > > From: Rich Felker <dalias@libc.org>
> > > > Signed-off-by: Rob Landley <rob@landley.net>
> > > > 
> > > > Silence noisy boot messages (warning and stack dump for each IRQ) when booting
> > > > on J2 SOC.
> > 
> > > > --- a/drivers/irqchip/irq-jcore-aic.c
> > > > +++ b/drivers/irqchip/irq-jcore-aic.c
> > > > @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
> > > >       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> > > >       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> > > >       struct irq_domain *domain;
> > > > +     int rc;
> > > > 
> > > >       pr_info("Initializing J-Core AIC\n");
> > > > 
> > > > @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
> > > >       jcore_aic.irq_unmask = noop;
> > > >       jcore_aic.name = "AIC";
> > > > 
> > > > +     rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
> > > > +                          of_node_to_nid(node));
> > > > +     if (rc < 0)
> > > > +             pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
> > > > +                     min_irq);
> > 
> > This is a fatal error, so please bail out, instead of continuing.
> 
> If it can continue, it's not a fatal error. (Some pieces of hardware might not
> come up, but the board might still be usable.) If it can't continue, how does
> the _type_ of failure matter?

I would still consider it fatal if any of the integral board components failed to
initialize. I don't think we want users to boot up their system into such an undefined
state.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
