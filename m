From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 17:25:10 +0000
Subject: [PATCH 0/6] Renesas R-Car DMAC fixes
Message-Id: <1422379516-1633-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Here are a couple of fixes for the rcar-dmac driver. They're based on the next
branch of the dmaengine tree.

The first four patches fix driver bugs, while the last two work around two
hardware issues. Patch 5 works around a documented errata, while patch 6
handles a data corruption issue that was noticed during test but not yet
confirmed to be a hardware bug by Renesas. When more information about the
issue will be available a better fix could possibly be developed.

Laurent Pinchart (6):
  dmaengine: rcar-dmac: Fix uninitialized variable usage
  dmaengine: rcar-dmac: Fix spinlock issues in interrupt
  dmaengine: rcar-dmac: Fix oops due to unintialized list in error ISR
  dmaengine: rcar-dmac: Allocate hardware descriptors with DMAC device
  dmaengine: rcar-dmac: Work around descriptor mode IOMMU errata
  dmaengine: rcar-dmac: Disable channel 0 when using IOMMU

 drivers/dma/sh/rcar-dmac.c | 147 ++++++++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 61 deletions(-)

-- 
Regards,

Laurent Pinchart

