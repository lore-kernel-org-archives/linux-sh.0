From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 29 Dec 2010 13:21:14 +0000
Subject: [PATCH 2/2 v2] mmc: tmio: fix CMD irq handling
Message-Id: <1293628874-8140-3-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1293628874-8140-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1293628874-8140-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>
Cc: linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>

With current code card insert/eject interrupts will acknowledge outstanding
commands. Normally this seems to be no problem, however if the hardware gets
stuck and no interrupts for CMD_TIMEOUT or CMD_RESPEND are generated, then
inserting and ejecting cards will falsely acknowledge outstanding commands from
the core.

This patch changes the behavior so that CMDs are only acked, if
CMD_TIMEOUT or CMD_RESPEND is received.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index f980042..e4926c7 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -728,8 +728,10 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
  */
 
 		/* Command completion */
-		if (ireg & TMIO_MASK_CMD) {
-			ack_mmc_irqs(host, TMIO_MASK_CMD);
+		if (ireg & (TMIO_STAT_CMDRESPEND | TMIO_STAT_CMDTIMEOUT)) {
+			ack_mmc_irqs(host,
+				     TMIO_STAT_CMDRESPEND |
+				     TMIO_STAT_CMDTIMEOUT);
 			tmio_mmc_cmd_irq(host, status);
 		}
 
-- 
1.7.2.3

