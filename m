From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:31:04 +0000
Subject: [PATCH 00/03] dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS
Message-Id: <20110524103104.10334.42987.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS

[PATCH 01/03] dmaengine: shdma: Make second memory window optional
[PATCH 02/03] dmaengine: shdma: Fix SH_DMAC_MAX_CHANNELS handling
[PATCH 03/03] dmaengine: shdma: Update SH_DMAC_MAX_CHANNELS to 20

These patches update the shdma dmaengine driver to support DMA
controllers with more than 6 slave-id capable channels mapped
into a single I/O-memory window. While at it fix the handling
of SH_DMAC_MAX_CHANNELS that without [PATCH 02/03] may overflow
some arrays at probe() time depending on platform data.

Needed to support the 20-channel SY-DMAC block included in sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Since these patches are only touching the shdma driver perhaps
 merging through the sh-2.6 tree is the easiest?

 drivers/dma/shdma.c |   42 +++++++++++++++++++++++++++++++-----------
 drivers/dma/shdma.h |    2 +-
 2 files changed, 32 insertions(+), 12 deletions(-)
