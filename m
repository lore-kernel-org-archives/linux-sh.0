From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:05:45 +0000
Subject: [PATCH 16/29] mmc: tmio: use MMC opcode defines instead of numbers
Message-Id: <1336057558-11031-17-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org

mmc.h defines macros for most frequently used MMC opcodes. Use them instead
of hard-coded numbers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 7da63b5..e843da0 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -35,6 +35,7 @@
 #include <linux/irq.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/mmc/tmio.h>
 #include <linux/module.h>
@@ -306,8 +307,8 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	int c = cmd->opcode;
 	u32 irq_mask = TMIO_MASK_CMD;
 
-	/* Command 12 is handled by hardware */
-	if (cmd->opcode = 12 && !cmd->arg) {
+	/* CMD12 is handled by hardware */
+	if (cmd->opcode = MMC_STOP_TRANSMISSION && !cmd->arg) {
 		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x001);
 		return 0;
 	}
@@ -450,7 +451,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	}
 
 	if (stop) {
-		if (stop->opcode = 12 && !stop->arg)
+		if (stop->opcode = MMC_STOP_TRANSMISSION && !stop->arg)
 			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x000);
 		else
 			BUG();
-- 
1.7.2.5

