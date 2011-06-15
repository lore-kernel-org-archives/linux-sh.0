From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jun 2011 07:31:12 +0000
Subject: Re: [PATCH 2/3] sh: sh7724: Add USBHS DMAEngine support
Message-Id: <w3p7h8n5z5r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4cn62zn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4cn62zn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Guennadi

> > >  	SHDMA_SLAVE_SCIF4_RX,
> > >  	SHDMA_SLAVE_SCIF5_TX,
> > >  	SHDMA_SLAVE_SCIF5_RX,
> > > +	SHDMA_SLAVE_USB0D0_TX,
> > > +	SHDMA_SLAVE_USB0D0_RX,
> > > +	SHDMA_SLAVE_USB0D1_TX,
> > > +	SHDMA_SLAVE_USB0D1_RX,
> > > +	SHDMA_SLAVE_USB1D0_TX,
> > > +	SHDMA_SLAVE_USB1D0_RX,
> > > +	SHDMA_SLAVE_USB1D1_TX,
> > > +	SHDMA_SLAVE_USB1D1_RX,
> > >  	SHDMA_SLAVE_SDHI0_TX,
> > >  	SHDMA_SLAVE_SDHI0_RX,
> > >  	SHDMA_SLAVE_SDHI1_TX,
> > 
> > Any specific reason to add your IDs in the middle? Between IDs for another 
> > controller type?

The reason was that it is 
"Selecting On-Chip Peripheral Module Request" table order on SuperH manual.

> While it doesn't really matter in this case, I much prefer people to do
> this than to constantly add them at the end. The issue is that if I have
> two patches that both append to the end of the list in two different
> branches with two different dependencies I'll almost certainly have to spend
> time fixing them up by hand rather than having git take care of it for
> me.
> 
> Much for the same reason that it's generally frowned upon for people to
> arbitrarily add new drivers at the end of a given Makefile.

Thanks.
I can send v2 patch if you needs. please let me know

Best regards
--
Kuninori Morimoto
 
