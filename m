From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 02:31:42 +0000
Subject: [PATCH 0/2] dmaengine: shdmac/rcar-hpbdma: fixup WARNING of slave caps retrieval
Message-Id: <878ugvmtoa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Vi Vinod

I had sent rcar-hpbdma directions fixup patches before

	Subject: [PATCH v3] dmaengine:: rcar-hpbdma: add dma_dev->directions
	Date: Tue, 20 Jan 2015 01:22:48 +0000

After that, I got feedback from Laurent about residue_granularity.
But, then, I could find above patch on dma/next branch, so, I sent below
patch as additional patch.

	Subject: [PATCH] dmaengine: rcar-hpbdma: tidyup residue_granularity
	Date: Wed, 21 Jan 2015 04:42:22 +0000

But, could you please replace it to 1) if possible ?
I found shdmac has same issue (= 2).

Kuninori Morimoto (2):
      1) dmaengine: rcar-hpbdma: fixup WARNING of slave caps retrieval
      2) dmaengine: shdmac: fixup WARNING of slave caps retrieval

 drivers/dma/sh/rcar-hpbdma.c |    6 ++++++
 drivers/dma/sh/shdmac.c      |    9 +++++++++
 2 files changed, 15 insertions(+)

