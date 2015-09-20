From: hamzahfrq.sub@gmail.com
Date: Sun, 20 Sep 2015 19:10:56 +0000
Subject: [RESEND PATCH v2 0/6] rcar DMA engine patches
Message-Id: <1442776262-2503-1-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

These patches have been sent after fixing:
-checkpatch.pl issues
-adding cpu_relax in 0001-dma-rcar-dma-add-wait-after-stopping-dma-engine.patch
-minor edits in commit messages

This series of patches fixes several issues with the rcar DMA engine
which were found in the debugging of sh serial DMA driver debugging. The
fixes involve adding wait to driver after stopping the engine, adding
pause function, checking for TE bit directly to detect a race condition
and others

Muhammad Hamza Farooq (6):
  dma: rcar-dma: add wait after stopping dma engine
  dma: rcar-dma: Added dma_pause operation to rcar_dma driver
  dma: rcar-dma: check if complete DMA packet received but not processed
  dma: rcar-dma: use result of updated get_residue in tx_status
  dma: rcar-dma: warn if transfer cannot start as TE = 1
  dma: rcar-dma: Fixed active descriptor initializing

 drivers/dma/sh/rcar-dmac.c | 71 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)

-- 
1.9.1

