Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB4EB8FA5
	for <linux-sh@archiver.kernel.org>; Wed,  6 Sep 2023 08:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjIFIM4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Sep 2023 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjIFIM4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Sep 2023 04:12:56 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522910F2
        for <linux-sh@vger.kernel.org>; Wed,  6 Sep 2023 01:12:36 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qdneK-002MsI-0f; Wed, 06 Sep 2023 10:12:32 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qdneJ-002btz-P5; Wed, 06 Sep 2023 10:12:31 +0200
Message-ID: <994b6714a478ee8d33f5938e8b59685c692885b0.camel@physik.fu-berlin.de>
Subject: Re: [RESEND RFC PATCH 01/12] sh: Add OF target boards.
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-sh@vger.kernel.org
Date:   Wed, 06 Sep 2023 10:12:31 +0200
In-Reply-To: <87bkefvi9i.wl-ysato@users.sourceforge.jp>
References: <cover.1693444193.git.ysato@users.sourceforge.jp>
         <95d8b86480c60012252b37b9b13e5f709a2ec177.1693444193.git.ysato@users.sourceforge.jp>
         <CAMuHMdV0rmmi8=DyQL-WmMdFyo4g6obNXjWutNGEz=3QcO_d+g@mail.gmail.com>
         <87bkefvi9i.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Yoshinori!

On Wed, 2023-09-06 at 17:05 +0900, Yoshinori Sato wrote:
> On Fri, 01 Sep 2023 23:26:10 +0900,
> Geert Uytterhoeven wrote:
> > 
> > Hi Sato-san,
> > 
> > On Thu, Aug 31, 2023 at 5:19 AM Yoshinori Sato
> > <ysato@users.sourceforge.jp> wrote:
> > > --- a/arch/sh/Kconfig
> > > +++ b/arch/sh/Kconfig
> > 
> > > @@ -702,7 +707,7 @@ config BUILTIN_DTB_SOURCE
> > >  config ZERO_PAGE_OFFSET
> > >         hex
> > >         default "0x00010000" if PAGE_SIZE_64KB || SH_RTS7751R2D || \
> > > -                               SH_7751_SOLUTION_ENGINE
> > > +                               SH_7751_SOLUTION_ENGINE || SH_RTS7751R2D_OF
> > 
> > This is the only user of SH_RTS7751R2D_OF. Can we get rid of it?
> > 
> > >         default "0x00004000" if PAGE_SIZE_16KB || SH_SH03
> > >         default "0x00002000" if PAGE_SIZE_8KB
> > >         default "0x00001000"
> > 
> > > --- a/arch/sh/boards/Kconfig
> > > +++ b/arch/sh/boards/Kconfig
> > > @@ -161,6 +166,17 @@ config SH_RTS7751R2D
> > >           Select RTS7751R2D if configuring for a Renesas Technology
> > >           Sales SH-Graphics board.
> > > 
> > > +config SH_RTS7751R2D_OF
> > > +       bool "RTS7751R2D (DeviceTree)"
> > > +       depends on CPU_SUBTYPE_SH7751R
> > > +       select HAVE_PCI
> > > +       select IO_TRAPPED if MMU
> > > +       select SH_DEVICE_TREE
> > > +       select COMMON_CLK
> > > +       help
> > > +         Select RTS7751R2D if configuring for a Renesas Technology
> > > +         Sales SH-Graphics board. (Use DeviceTree)
> > > +
> > >  config SH_RSK
> > >         bool "Renesas Starter Kit"
> > >         depends on CPU_SUBTYPE_SH7201 || CPU_SUBTYPE_SH7203 || \
> > > @@ -300,8 +316,20 @@ config SH_LANDISK
> > >         bool "LANDISK"
> > >         depends on CPU_SUBTYPE_SH7751R
> > >         select HAVE_PCI
> > > +       select SYS_SUPPORTS_PCI
> > > +       help
> > > +         I-O DATA DEVICE, INC. "LANDISK Series" support.
> > > +
> > > +config SH_LANDISK_OF
> > > +       bool "LANDISK (DeviceTree)"
> > > +       depends on CPU_SUBTYPE_SH7751R
> > > +       select HAVE_PCI
> > > +       select SYS_SUPPORTS_PCI
> > > +       select SH_DEVICE_TREE
> > > +       select COMMON_CLK
> > >         help
> > >           I-O DATA DEVICE, INC. "LANDISK Series" support.
> > > +         Use Device Tree.
> > > 
> > >  config SH_TITAN
> > >         bool "TITAN"
> > 
> > Apart from the above, there are no users of the "<machine>_OF" symbols.
> > Do we need them?

Did you accidentally sent this mail before commenting?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
