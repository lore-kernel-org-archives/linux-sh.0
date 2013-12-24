From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Date: Tue, 24 Dec 2013 09:49:34 +0000
Subject: [PATCH 5/5] spi: rspi: Use u8 for 8-bit register values
Message-Id: <1387878574-21445-6-git-send-email-geert+renesas@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1387878574-21445-1-git-send-email-geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 51fe3bdacb18..239354618eac 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -160,7 +160,7 @@ struct rspi_data {
 	wait_queue_head_t wait;
 	spinlock_t lock;
 	struct clk *clk;
-	unsigned char spsr;
+	u8 spsr;
 	const struct spi_ops *ops;
 
 	/* for dmaengine */
@@ -514,7 +514,7 @@ end_nomap:
 
 static void rspi_receive_init(const struct rspi_data *rspi)
 {
-	unsigned char spsr;
+	u8 spsr;
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
@@ -562,7 +562,7 @@ static int rspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 
 static void qspi_receive_init(const struct rspi_data *rspi)
 {
-	unsigned char spsr;
+	u8 spsr;
 
 	spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
@@ -807,9 +807,9 @@ static void rspi_cleanup(struct spi_device *spi)
 static irqreturn_t rspi_irq(int irq, void *_sr)
 {
 	struct rspi_data *rspi = _sr;
-	unsigned long spsr;
+	u8 spsr;
 	irqreturn_t ret = IRQ_NONE;
-	unsigned char disable_irq = 0;
+	u8 disable_irq = 0;
 
 	rspi->spsr = spsr = rspi_read8(rspi, RSPI_SPSR);
 	if (spsr & SPSR_SPRF)
-- 
1.7.9.5

