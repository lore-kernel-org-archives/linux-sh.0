From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Aug 2014 01:46:42 +0000
Subject: Re: [PATCH 4/6] dmaengine: rcar-dmac: Add device tree bindings documentation
Message-Id: <20140805014641.GD26270@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406766014.git.horms+renesas@verge.net.au>
 <3dc5d31428846326bf122a2a9b402a2a80e97681.1406766014.git.horms+renesas@verge.net.au>
 <CAMuHMdVtU_uujbJarBSdqR2hs5+=KTAxhnOU2tEM4MXaaTTG_A@mail.gmail.com>
 <2984491.bHCssUOyYu@avalon>
In-Reply-To: <2984491.bHCssUOyYu@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Aug 04, 2014 at 04:01:42PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the review.
> 
> On Monday 04 August 2014 10:05:49 Geert Uytterhoeven wrote:
> > On Thu, Jul 31, 2014 at 2:34 AM, Simon Horman wrote:
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> > > @@ -0,0 +1,98 @@
> > > +* Renesas R-Car DMA Controller Device Tree bindings
> > > +
> > > +Renesas R-Car Generation 2 SoCs have have multiple multi-channel DMA
> > > +controller instances named DMAC capable of serving multiple clients.
> > > Channels +can be dedicated to specific clients or shared between a large
> > > number of +clients.
> > > +
> > > +DMA clients are connected to the DMAC ports referenced by an 8-bit
> > > identifier +called MID/RID.
> > 
> > I think the above sentence can be removed, as it's superseded by the first
> > sentence of the successive paragraph:
> 
> I've probably just forgotten to remove the sentence while reworking the 
> documentation. Thanks for reporting it, I'll fix that in the next version.

BTW, I believe Vinod has already applied this and the previous three
patches of this series to his tree.

As he applied then rather than pulling the pull-request I sent I intend
to drop the entire series from my tree for now.

> > > +
> > > +Each DMA client is connected to one dedicated port of the DMAC,
> > > identified by +an 8-bit port number called the MID/RID. A DMA controller
> > > can thus serve up to +256 clients in total. When the number of hardware
> > > channels is lower than the +number of clients to be served, channels must
> > > be shared between multiple DMA +clients. The association of DMA clients
> > > to DMAC channels is fully dynamic and +not described in these device tree
> > > bindings.
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
