Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB0EC7EE22
	for <linux-sh@archiver.kernel.org>; Wed,  3 May 2023 10:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjECKul convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 May 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjECKuT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 May 2023 06:50:19 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EBF49DF;
        Wed,  3 May 2023 03:50:12 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1puA3m-002YpK-J1; Wed, 03 May 2023 12:50:10 +0200
Received: from p5b13ada3.dip0.t-ipconnect.de ([91.19.173.163] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1puA3m-0040c6-CP; Wed, 03 May 2023 12:50:10 +0200
Message-ID: <3a42b3b3da5499f1ec1e24f618dd46a75503da16.camel@physik.fu-berlin.de>
Subject: Re: Fixing "int-to-pointer-cast" warning in J2 code
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-sh <linux-sh@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Wed, 03 May 2023 12:50:09 +0200
In-Reply-To: <CAMuHMdWOJn97KMBa0YoQo+a7tGDwMTTQ8YPHT7VJ2zJjEYEV0Q@mail.gmail.com>
References: <eed749a0ec500edf4f70a50578eaa50803fdaf3c.camel@physik.fu-berlin.de>
         <CAMuHMdWOJn97KMBa0YoQo+a7tGDwMTTQ8YPHT7VJ2zJjEYEV0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.173.163
X-ZEDAT-Hint: PO
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi Geert!

On Wed, 2023-05-03 at 11:08 +0200, Geert Uytterhoeven wrote:
> On Wed, May 3, 2023 at 10:14 AM John Paul Adrian Glaubitz
> <glaubitz@physik.fu-berlin.de> wrote:
> > When building j2_defconfig, the following warning is issued:
> > 
> > arch/sh/kernel/cpu/sh2/probe.c: In function 'scan_cache':
> > arch/sh/kernel/cpu/sh2/probe.c:24:16: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >    24 |  j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
> >       |
> > 
> > Reading the code and look how other users of of_flat_dt_translate_address()
> > used the return code, I came up with the following patch which fixes the issue:
> > 
> > diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.c
> > index d342ea08843f..a0dc3675fc68 100644
> > --- a/arch/sh/kernel/cpu/sh2/probe.c
> > +++ b/arch/sh/kernel/cpu/sh2/probe.c
> > @@ -14,14 +14,14 @@
> >  #include <asm/cache.h>
> > 
> >  #if defined(CONFIG_CPU_J2)
> > -extern u32 __iomem *j2_ccr_base;
> > +extern phys_addr_t j2_ccr_base;
> >  static int __init scan_cache(unsigned long node, const char *uname,
> >                              int depth, void *data)
> >  {
> >         if (!of_flat_dt_is_compatible(node, "jcore,cache"))
> >                 return 0;
> > 
> > -       j2_ccr_base = (u32 __iomem *)of_flat_dt_translate_address(node);
> > +       j2_ccr_base = of_flat_dt_translate_address(node);
> 
> of_flat_dt_translate_address() indeed returns a CPU physical address
> (perhaps its return type should be changed from u64 to phys_addr_t?)...
> 
> > 
> >         return 1;
> >  }
> > diff --git a/arch/sh/mm/cache-j2.c b/arch/sh/mm/cache-j2.c
> > index f277862a11f5..2bc6d38d6f7c 100644
> > --- a/arch/sh/mm/cache-j2.c
> > +++ b/arch/sh/mm/cache-j2.c
> > @@ -22,7 +22,7 @@
> >  #define DCACHE_FLUSH   0x200
> >  #define CACHE_FLUSH    (ICACHE_FLUSH | DCACHE_FLUSH)
> > 
> > -u32 __iomem *j2_ccr_base;
> > +phys_addr_t j2_ccr_base;
> 
> ... however, all other users of j2_ccr_base use this with __raw_*()
> I/O accessors, so "u32 __iomem *" is correct.
> 
> What is missing is a proper conversion from physical to virtual
> addresses, using e.g. ioremap().
> 
> As this is nommu, the identity mapping in ioremap() in
> arch/sh/include/asm/io.h should do, and cannot fail.
> 
> So just:
> 
>     j2_ccr_base = ioremap(of_flat_dt_translate_address(node), 4);
> 
> should be fine.

Thanks, that actually makes much more sense. I was actually looking for
such a function after reading what the __iomap attribute is for.

> BTW, "jcore,cache" does not have any DT binding documentation.

Jeff or Rob should look into this.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
