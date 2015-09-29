From: hamzahfrq.sub@gmail.com
Date: Tue, 29 Sep 2015 20:44:42 +0000
Subject: [PATCH v3 0/6] rcar DMA engine patches
Message-Id: <1443559488-2416-1-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

These patches have been sent after:
-removing parenthesis in 0001-dma-rcar-dma-add-wait-after-stopping-dma-engine.patch
-not fixing indentation in 0001-dma-rcar-dma-add-wait-after-stopping-dma-engine.patch

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

 drivers/dma/sh/rcar-dmac.c | 69 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 3 deletions(-)

-- 
1.9.1

