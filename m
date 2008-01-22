From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 22 Jan 2008 06:03:11 +0000
Subject: Re: [PATCH] spi: add support for SPI over SuperH SCI pins
Message-Id: <20080122060311.GA5322@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<20080122031114.GA2062@linux-sh.org>
	<200801212022.23139.david-b@pacbell.net>
	<200801212126.32727.david-b@pacbell.net>
	<20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
	<200801211429.29906.david-b@pacbell.net>
	<20080122031114.GA2062@linux-sh.org>
	<200801212022.23139.david-b@pacbell.net>
In-Reply-To: <200801212126.32727.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
	<200801212022.23139.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jan 21, 2008 at 08:22:22PM -0800, David Brownell wrote:
> On Monday 21 January 2008, Paul Mundt wrote:
> 
> > > > +#define spidelay(x) ndelay(x)
> > > > +
> > > > +#define	EXPAND_BITBANG_TXRX
> > > > +#include <linux/spi/spi_bitbang.h>
> > > > +
> > 
> > This is rather unorthodox..
> 
> return -ENOPATCH;)
> 
> I've seen similar idioms used for years.  It's not dissimilar
> to "#ifdef __KERNEL__" except for the code audiences:  two
> different drivers, vs two different address spaces.
> 
> Similar approaches have been used to expand bit manipulation
> algorithms in other contexts ... like some X11 servers I once
> had to cope with.  In fact that was infamous for breaking CPP
> on new platforms; that was before C grew inlines!  But the
> rationale is still the same:  make sure the compiler has every
> opportunity to optimize each variant of those inner loops,
> since they're performance-critical.
> 
> And it works.  I append the code generated on one ARM which
> inlines the bitops ... the inner loop isn't as fast as one
> could code by hand, but if you consider it's four GPIO ops
> then it's not bad.  And it's twice as fast as going through
> a subroutine call for each bitop.  That's easily visible on
> block I/O paths that unfortunately can't use hardware SPI
> on that system.

On Mon, Jan 21, 2008 at 09:26:32PM -0800, David Brownell wrote:
> Minor clarification:  twice as fast for loads involving lots
> of medium-size buffers (1K+).  Down from one minute(!) to put
> new kernels to the only place that they can boot from ... it's
> the usual case where a 5x speedup at one place is very visible,
> but doesn't add up to 5x overall; other issues start to show
> up more (like unchanged per-byte overheads).
> 

The -ENOPATCH thing was intentional, I was more fishing for an
explanation of why this magical sequence existed than lobbying for its
replacement. drivers/spi/ isn't in danger of looking like crypto/ in the
name of code generation just yet, at least. ;-)

Thanks for the clarification.
