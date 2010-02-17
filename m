From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Feb 2010 07:38:04 +0000
Subject: [PATCH 03/05] tmio_mmc: Use 100ms mmc_detect_change() delay
Message-Id: <20100217073804.32726.27721.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100217073735.32726.12020.sendpatchset@t400s>
In-Reply-To: <20100217073735.32726.12020.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: sameo@linux.intel.com, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, Magnus Damm <magnus.damm@gmail.com>, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, akpm@linux-foundation.org, g.liakhovetski@gmx.de

From: Magnus Damm <damm@opensource.se>

This patch changes the tmio_mmc driver to wait 100ms
before checking the card detect status. This type of
delay is quite common among mmc drivers, it seems that
most hardware platforms need to give the hardware some
time to settle before checking card availabilty.

Hotplug is half-broken without this patch on the sh7724
Ecovec board. Hot insertion seems ok but eject is never
detected without this patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Previously posted to linux-mmc 20100215 as
 "[PATCH] tmio_mmc: use 100ms mmc_detect_change() delay"

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
