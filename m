From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 15 Jun 2011 07:16:05 +0000
Subject: Re: [PATCH 2/3] sh: sh7724: Add USBHS DMAEngine support
Message-Id: <20110615071603.GP17891@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4cn62zn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4cn62zn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 15, 2011 at 09:01:02AM +0200, Guennadi Liakhovetski wrote:
> On Wed, 15 Jun 2011, Kuninori Morimoto wrote:
> 
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> > ---
> >  arch/sh/include/cpu-sh4/cpu/sh7724.h   |    8 ++++++
> >  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   40 ++++++++++++++++++++++++++++++++
> >  2 files changed, 48 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
> > index 3daef8e..cbc47e6 100644
> > --- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
> > +++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
> > @@ -298,6 +298,14 @@ enum {
> >  	SHDMA_SLAVE_SCIF4_RX,
> >  	SHDMA_SLAVE_SCIF5_TX,
> >  	SHDMA_SLAVE_SCIF5_RX,
> > +	SHDMA_SLAVE_USB0D0_TX,
> > +	SHDMA_SLAVE_USB0D0_RX,
> > +	SHDMA_SLAVE_USB0D1_TX,
> > +	SHDMA_SLAVE_USB0D1_RX,
> > +	SHDMA_SLAVE_USB1D0_TX,
> > +	SHDMA_SLAVE_USB1D0_RX,
> > +	SHDMA_SLAVE_USB1D1_TX,
> > +	SHDMA_SLAVE_USB1D1_RX,
> >  	SHDMA_SLAVE_SDHI0_TX,
> >  	SHDMA_SLAVE_SDHI0_RX,
> >  	SHDMA_SLAVE_SDHI1_TX,
> 
> Any specific reason to add your IDs in the middle? Between IDs for another 
> controller type?
> 
While it doesn't really matter in this case, I much prefer people to do
this than to constantly add them at the end. The issue is that if I have
two patches that both append to the end of the list in two different
branches with two different dependencies I'll almost certainly have to spend
time fixing them up by hand rather than having git take care of it for
me.

Much for the same reason that it's generally frowned upon for people to
arbitrarily add new drivers at the end of a given Makefile.
