From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 17 Jul 2012 10:53:38 +0000
Subject: [PATCH/RFC 0/4] dma: Add multiplexer call-back for channel allocation
Message-Id: <Pine.LNX.4.64.1207171201550.11241@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi all

As recently [1] proposed, a DMA channel multiplexer can be user to 
flexibly allocate DMA channels without a use of a DMAC-specific filter 
function. This patch set presents a possible implementation. Of the 3 
patches in this series the first one is the actual proposal, the other two 
are an illustration, using the shdma dmaengine and the sh_mmcif mmc 
drivers on the sh7372 mackerel board.

This is an RFC, please, comment. One extension, that seems to make sense 
is an addition of a multiplexer-configure call-back to actually configure 
the routing. It isn't needed in the shdma case, so, I didn't want to add 
it without real users. Something along the lines of

	struct dma_chan *(*route_chan)(struct dma_chan *, struct device *,
				enum dma_transfer_direction, const char *);

perhaps?

Thanks
Guennadi

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/75828/focusv295
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
