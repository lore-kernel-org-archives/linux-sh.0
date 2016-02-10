From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 10 Feb 2016 23:59:45 +0000
Subject: Re: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <8831860.v1LSSotGVy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Niklas,

On Thursday 11 February 2016 01:51:31 Laurent Pinchart wrote:
> On Monday 08 February 2016 09:05:31 Vinod Koul wrote:
> > On Wed, Feb 03, 2016 at 02:04:06PM +0200, Laurent Pinchart wrote:
> >>>>>> Okay I am in two minds for this, doing phys_addr_t seems okay but
> >>>>>> somehow I feel we should rather pass dma_addr_t and dmaengien
> >>>>>> driver get a right dma address to use and thus fix the clients,
> >>>>>> that maybe the right thing to do here, thoughts...?
> >>>>> 
> >>>>> Given that there should be more clients than DMA engine drivers, and
> >>>>> given that knowledge of what has to be done to map a physical
> >>>>> address to a DMA address accessible by the DMA engine should not be
> >>>>> included in client drivers (in most case I assume using the DMA
> >>>>> mapping API will be enough, but details may vary), I believe it
> >>>>> makes more sense to pass a phys_addr_t and let the DMA engine
> >>>>> drivers handle it.
> >>>>> 
> >>>>> There's another issue I just remembered. Consider the following
> >>>>> cases.
> >>>>> 
> >>>>> 1. DMA engine channel that has an optional IOMMU covering both the
> >>>>> src and dst side. In that case mapping can be performed by the
> >>>>> client or DMA engine driver, the DMA mapping API will handle the
> >>>>> IOMMU behind the scene.
> >>>>> 
> >>>>> 2. DMA engine channel that has an optional IOMMU on the memory side
> >>>>> and no support for IOMMU on the slave (in the sense of the register
> >>>>> in front of the client's FIFO) side. In that case a client mapping
> >>>>> buffers on both the src and dst side would set an IOMMU mapped
> >>>>> address for the slave side, which wouldn't work. If the DMA engine
> >>>>> driver were to perform the mapping then it could skip it on the
> >>>>> slave side, knowing that the slave side has no IOMMU.
> >>>>> 
> >>>>> 3. DMA engine channel that has independently optional IOMMUs on both
> >>>>> sides. This can't be supported today as we have a single struct
> >>>>> device per channel and thus can't configure the IOMMU independently
> >>>>> on the two sides.
> >>>>> 
> >>>>> It's getting messy :-)
> >>>> 
> >>>> Yes I do agree on that, but the problem is today none of the slave
> >>>> drivers expect or do the mapping, changing that will cause issues...
> >>>> 
> >>>> And how many do really have an IOMMU behind them, few out of large set
> >>>> we have...
> >>> 
> >>> Today neither the DMA engine drivers nor the client drivers do the
> >>> mapping, so we have any issue anyway. The question is on which side to
> >>> solve it. If I understand correctly you fear that mapping the address
> >>> in the DMA engine drivers would cause issues with client drivers that
> >>> don't expect that behaviour, but I don't really see where the issue is.
> >>> Could you please elaborate ?
> >> 
> >> Ping. I don't think we're very far from finding an agreement on this
> >> topic. If you prefer we could discuss it on IRC, it can be faster than
> >> e-mail.
> > 
> > Sorry about the delay,
> 
> No worries.
> 
> > Okay I did look back and checked. I tend to agree with you on this and
> > client are not really taking care of mapping so easy approach would be to
> > get this fixed in dmanegine which helps in IOMMU case (which I still think
> > is in infancy, but who know how designers will throw their pipe dreams at
> > us)
> > 
> > Now, am checking this with Dan on why we started with client based mapping
> > assumption in case of slave, we don't want to miss anything here, so I
> > will get back in couple of days..
> 
> Thank you.
> 
> Niklas, that's the direction you've already explored with the rcar-dmac
> driver, so it shouldn't cause any issue with your "[PATCH v3 0/8] dmaengine:
> rcar-dmac: add iommu support for slave transfers" patch series. After
> receiving confirmation from Dan and Vinod, could you add an additional
> patch to use phys_addr_t in struct dma_slave_config ?

Scratch that, I see that the patch already exists :-)

-- 
Regards,

Laurent Pinchart

