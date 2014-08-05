From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 05 Aug 2014 13:33:41 +0000
Subject: Re: [PATCH 4/6] dmaengine: rcar-dmac: Add device tree bindings documentation
Message-Id: <11536846.yTpuKL4B5k@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406766014.git.horms+renesas@verge.net.au> <2984491.bHCssUOyYu@avalon> <20140805014641.GD26270@verge.net.au>
In-Reply-To: <20140805014641.GD26270@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Simon,

On Tuesday 05 August 2014 10:46:42 Simon Horman wrote:
> On Mon, Aug 04, 2014 at 04:01:42PM +0200, Laurent Pinchart wrote:
> > On Monday 04 August 2014 10:05:49 Geert Uytterhoeven wrote:
> >> On Thu, Jul 31, 2014 at 2:34 AM, Simon Horman wrote:
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> >>> @@ -0,0 +1,98 @@
> >>> +* Renesas R-Car DMA Controller Device Tree bindings
> >>> +
> >>> +Renesas R-Car Generation 2 SoCs have have multiple multi-channel DMA
> >>> +controller instances named DMAC capable of serving multiple clients.
> >>> Channels
> >>> +can be dedicated to specific clients or shared between a large number
> >>> of
> >>> +clients.
> >>> +
> >>> +DMA clients are connected to the DMAC ports referenced by an 8-bit
> >>> identifier +called MID/RID.
> >> 
> >> I think the above sentence can be removed, as it's superseded by the
> >> first sentence of the successive paragraph:
> >>
> > I've probably just forgotten to remove the sentence while reworking the
> > documentation. Thanks for reporting it, I'll fix that in the next version.
> 
> BTW, I believe Vinod has already applied this and the previous three
> patches of this series to his tree.

Indeed. I'm surprised to see the DT bindings being merged without the driver, 
but given that they seem to be OK, that's not a problem.

> As he applied then rather than pulling the pull-request I sent I intend
> to drop the entire series from my tree for now.

Please do. I'll resubmit the remaining patches.

-- 
Regards,

Laurent Pinchart

