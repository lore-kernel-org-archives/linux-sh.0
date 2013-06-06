From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:38:11 +0000
Subject: [PATCH 1/2] ARM: shmobile: armadillo800eva: remove left-overs
Message-Id: <1370533092-23555-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <87bok7lm0h.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bok7lm0h.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A comment and a #define in board-armadillo800eva.c have been left over
after recent changes and are no longer relevant or needed, remove them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 44a6215..ce1c37f 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -678,15 +678,6 @@ static struct platform_device vcc_sdhi1 = {
 };
 
 /* SDHI0 */
-/*
- * FIXME
- *
- * It use polling mode here, since
- * CD (= Card Detect) pin is not connected to SDHI0_CD.
- * We can use IRQ31 as card detect irq,
- * but it needs chattering removal operation
- */
-#define IRQ31	irq_pin(31)
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-- 
1.7.2.5

