From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Feb 2010 12:12:29 +0000
Subject: [PATCH] tmio_mmc: use 100ms mmc_detect_change() delay
Message-Id: <20100215121229.23116.16376.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, akpm@linux-foundation.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch changes the tmio_mmc driver to wait 100ms
before checking the card detect status. This type of
delay is quite common among mmc drivers, it seems that
most hardware platforms need to give the hardware some
time to settle before checking card availabilty.

Hotplug is half-broken without this patch on the sh7724
Ecovec board. Hot plugging seems ok but eject is never
detected without this patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/tmio_mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/mmc/host/tmio_mmc.c
+++ work/drivers/mmc/host/tmio_mmc.c	2010-02-15 20:28:15.000000000 +0900
@@ -323,7 +323,7 @@ static irqreturn_t tmio_mmc_irq(int irq,
 		if (ireg & (TMIO_STAT_CARD_INSERT | TMIO_STAT_CARD_REMOVE)) {
 			ack_mmc_irqs(host, TMIO_STAT_CARD_INSERT |
 				TMIO_STAT_CARD_REMOVE);
-			mmc_detect_change(host->mmc, 0);
+			mmc_detect_change(host->mmc, msecs_to_jiffies(100));
 		}
 
 		/* CRC and other errors */
