Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101C8C7EE22
	for <linux-sh@archiver.kernel.org>; Thu, 11 May 2023 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238918AbjEKUVD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 11 May 2023 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjEKUVC (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 11 May 2023 16:21:02 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2AE2720;
        Thu, 11 May 2023 13:21:00 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pxCmU-001ly8-Lu; Thu, 11 May 2023 22:20:54 +0200
Received: from p5b13addc.dip0.t-ipconnect.de ([91.19.173.220] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pxCmU-0024FM-2s; Thu, 11 May 2023 22:20:54 +0200
Message-ID: <079f78025bf0af7808951ff0b56393cff99d957b.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: dma: Correct the number of DMA channels in
 SH7709
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 11 May 2023 22:20:53 +0200
In-Reply-To: <CAMuHMdV4hDULr43_4Z=Q9EHEvbzGStMRY45d4Ja1ixqSvMd2Cg@mail.gmail.com>
References: <20230506141703.65605-1-contact@artur-rojek.eu>
         <20230506141703.65605-3-contact@artur-rojek.eu>
         <CAMuHMdV4hDULr43_4Z=Q9EHEvbzGStMRY45d4Ja1ixqSvMd2Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.220
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On Mon, 2023-05-08 at 12:55 +0200, Geert Uytterhoeven wrote:
> On Sat, May 6, 2023 at 4:22 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> > According to the PM, the DMAC found in SH7709 features only 4 channels.
> > 
> > Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I assume we can't find a commit for the Fixes tag? Looking at the "git blame"
for the Kconfig file, it seems the corresponding lines were changed before
the source tree was imported into git in 1da177e4c3f4.

> > --- a/arch/sh/drivers/dma/Kconfig
> > +++ b/arch/sh/drivers/dma/Kconfig
> > @@ -28,8 +28,9 @@ config SH_DMA_API
> >  config NR_ONCHIP_DMA_CHANNELS
> >         int
> >         depends on SH_DMA
> > -       default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
> > -                      CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
> > +       default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
> > +                      CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7750S || \
> > +                      CPU_SUBTYPE_SH7091
> >         default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
> >                        CPU_SUBTYPE_SH7760
> >         default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
> > @@ -37,8 +38,9 @@ config NR_ONCHIP_DMA_CHANNELS
> >         default "6"
> >         help
> >           This allows you to specify the number of channels that the on-chip
> > -         DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
> 
> Might be a good opportunity to s/Sh7750S/SH7750S/
> 
> > -         SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
> > +         DMAC supports. This will be 4 for SH7709/SH7750/SH7751/Sh7750S/SH7091
> > +         and 8 for the SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724,
> 
> ... and sort the list for SoCs with 12 channels.
> 
> > +         default is 6.
> > 
> >  config SH_DMABRG
> >         bool "SH7760 DMABRG support"

Good point. I will send a follow-up patch to clean that up.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
