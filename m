From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 07:11:15 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7778/r8a7779 dtsi: Improve and correct HSPI bindings
Message-Id: <87zjlvbi7l.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392109008-29941-1-git-send-email-geert@linux-m68k.org>
	<20140213055600.GF17183@verge.net.au>
In-Reply-To: <20140213055600.GF17183-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>


Hi Simon, Geert
Cc Mark

> could you test this series as Geert does not have access to a bockw board?
> 
> On Tue, Feb 11, 2014 at 09:56:47AM +0100, Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> > 
> > Binding documentation:
> >   - Add future-proof "renesas,hspi-<soctype>" compatible values,
> >   - Add "interrupt-parent", "#address-cells" and "#size-cells" properties,
> >   - Add reference to pinctrl documentation,
> >   - Add example bindings.
> > 
> > r8a7778 and r8a7779 dtsi:
> >   - Add "renesas,hspi-r8a7778" resp. "renesas,hspi-r8a7779" compatible
> >     values,
> >   - Correct reference to parent interrupt controller
> >     (use "interrupt-parent" instead of "interrupt-controller"),
> >   - Add missing "#address-cells" and "#size-cells" properties, which are
> >     needed when populating the SPI buses.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> > Cc: Mark Brown <broonie@linaro.org>
> > ---

I tested this patch, and it works well.
But there are some notes

1) m25p80 driver DT support seems strange ??

   ${LINUX}/Documentation/devicetree/bindings/mtd/m25p80.txt
   has explain about DT of m25p80 driver, but,
   ${LINUX}/drivers/mtd/devices/m25p80.c
   doesn't have driver :: of_match_table.
   but, it is using of_property_read_bool() on probe.
   Is it out-of-tree support ?? I'm not sure,
   anyway, m25p80 driver didn't probe.
   So, I quick-hacked this issue in my local environment.

2) it needs Geert's this patch

   Subject: [PATCH] mtd: m25p80: add support for the Spansion s25fl008k chip
   Date:	Tue, 11 Feb 2014 09:51:18 +0100

   Kernel will hung-up without this patch

For HSPI / BockW point of view

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


