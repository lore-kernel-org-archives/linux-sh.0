From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 09 May 2014 08:54:27 +0000
Subject: Re: [PATCH] of/irq: provide int of_irq_parse_and_map_pci wrapper
Message-Id: <1399625667.4833.6.camel@weser.hi.pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4527717.yJh2gX3xCP@wuerfel>
	 <1399624119.4833.3.camel@weser.hi.pengutronix.de>
	 <4975430.zMeeu7d2Xc@wuerfel>
In-Reply-To: <4975430.zMeeu7d2Xc@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am Freitag, den 09.05.2014, 10:45 +0200 schrieb Arnd Bergmann:
> On Friday 09 May 2014 10:28:39 Lucas Stach wrote:
> > Am Freitag, den 09.05.2014, 08:58 +0200 schrieb Arnd Bergmann:
> > > The pci-rcar driver is enabled for compile tests, and this has
> > > now shown that the driver cannot build without CONFIG_OF,
> > > following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
> > > interrupt mapping when possible":
> > > 
> > > drivers/built-in.o: In function `rcar_pci_map_irq':
> > > :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
> > > 
> > > As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
> > > supposed to build fine, which we can achieve if we make the
> > > declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
> > > and provide an empty inline function otherwise, as we do for
> > > a lot of other of interfaces.
> > > 
> > > This lets us build the rcar_pci driver again without CONFIG_OF,
> > > which won't work but give us compile time coverage.
> > > 
> > This part of the commit message is confusing. The driver is explicitly
> > written to fall back to a platform irq when OF interrupt mapping doesn't
> > work (return 0 or error), to keep non DT enabled boards working.
> > 
> > I hadn't thought of the compile time dependency, so thanks for fixing
> > this up.
> 
> I thought it was meant to keep old DTBs working. AFAIK, there is no
> legacy board file support for rcar-gen2, so we don't actually have to
> worry about that.
> 
I haven't watched closely, but at the time of writing the patch the were
some board files in flight which used the rcar-pci.  All I wanted to say
is that with your patch applied things continue to work, at least at the
same level as before my change, but I really don't care too much about
the details.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

