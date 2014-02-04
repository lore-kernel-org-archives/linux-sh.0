From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 04 Feb 2014 10:06:24 +0000
Subject: [PATCH] spi: rspi: Only enable interrupts when there's a need to wait
Message-Id: <1391508384-5013-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

rspi_wait_for_interrupt() unconditionally enables interrupts, even when the
wait condition is already satisfied. This causes a high interrupt load (2
interrupts/byte for full-duplex Single SPI transfers, 1 interrupt/byte for
RSPI with TX Only mode, or QSPI in unidirectional Dual or Quad Transfer
mode).

Change this to return immediately when the wait condition is satisfied.
This dramatically reduces the interrupt load, especially in high-speed
Quad Transfer mode, and increases transfer speed, as no interrupts need to
be handled when there's space available in the output FIFO, or data
available in the input FIFO.

Benchmark results for QSPI on r8a7791 while reading 1 MiB from 30 MHz SPI
FLASH on the Koelsch development board:

Before:
                        Single SPI      Dual SPI        Quad SPI
    Interrupts:         2096856         1048592         1048594
    Mbps:               0.9             1.6             1.6

After:

                        Single SPI      Dual SPI        Quad SPI
    Interrupts:         1048569         21295           8
    Mbps:               0.7             10.8            12.9

I don't know why Single SPI slowed down a bit.

I've also verified functionality for RSPI-RZ on r7s72100, but don't have
benchmark results as there's no SPI FLASH connected to RSPI on the Genmai
development board. Unlike RSPI and QSPI, RSPI-RZ has separate interrupts
for RX and TX, which shows that Single SPI transfers now generate (mostly)
RX interrupts, as expected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/spi/spi-rspi.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index df637184f6f0..c76f718a3a45 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -393,6 +393,9 @@ static int rspi_wait_for_interrupt(struct rspi_data *rspi, u8 wait_mask,
 	int ret;
 
 	rspi->spsr = rspi_read8(rspi, RSPI_SPSR);
+	if (rspi->spsr & wait_mask)
+		return 0;
+
 	rspi_enable_irq(rspi, enable_bit);
 	ret = wait_event_timeout(rspi->wait, rspi->spsr & wait_mask, HZ);
 	if (ret = 0 && !(rspi->spsr & wait_mask))
-- 
1.7.9.5

