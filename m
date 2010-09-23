From: Arnd Hannemann <arnd@arndnet.de>
Date: Thu, 23 Sep 2010 13:33:54 +0000
Subject: [PATCH 2/2] tmio_mmc: fix CMD irq handling
Message-Id: <1285248834-4434-2-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1285248834-4434-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1285248834-4434-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <spyro@f2s.com>, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>

With current code card insert/eject interrupts will acknowledge outstanding
commands. Normally this seems to be no problem, however if the hardware gets
stuck and no interrupts for CMD_TIMEOUT or CMD_RESPEND are generated, then
inserting and ejecting cards will falsely acknowledge outstanding commands from
the core.

This patch changes the behavior so that CMDs are only acked, if
CMD_TIMEOUT or CMD_RESPEND is received.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/mmc/host/tmio_mmc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index cb66af5..75a0aca 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -430,8 +430,10 @@ static irqreturn_t tmio_mmc_irq(int irq, void *devid)
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
1.7.0.4

