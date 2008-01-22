From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jan 2008 03:11:14 +0000
Subject: Re: [PATCH] spi: add support for SPI over SuperH SCI pins
Message-Id: <20080122031114.GA2062@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<200801211429.29906.david-b@pacbell.net>
In-Reply-To: <200801211429.29906.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jan 21, 2008 at 02:29:29PM -0800, David Brownell wrote:
> On Monday 21 January 2008, Magnus Damm wrote:
> > +struct sh_sci_spi {
> > +	struct spi_bitbang bitbang;
> > +
> > +	unsigned long mapbase;
> 
> Not "void __iomem *mapbase"?
> 
> I notice that you're not doing an ioremap() to get this address.
> Is the platform device properly registering a *physical* address
> in the IORESOURCE_MEM record for the device?
> 
It should be ioremap(), yes. While for these parts ioremap() doesn't
really do anything, it still takes care of the void __iomem * casting
properly, and there are in fact parts where we have no choice but to go
through page tables anyways.

> > +#define spidelay(x) ndelay(x)
> > +
> > +#define	EXPAND_BITBANG_TXRX
> > +#include <linux/spi/spi_bitbang.h>
> > +

This is rather unorthodox..
