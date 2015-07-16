From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:36 +0000
Subject: [PATCH/RFC v2 05/29] serial: sh-sci: Fix scatterlist mapping leak
Message-Id: <1437070920-28069-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The mapped scatterlist is never unmapped. This leaks quite some
mappings, as the mapping is done in uart_ops.startup(), i.e. every time
the device is opened. Unmap the scatterlist on device close.

Note that we have to restore the original DMA entry length and DMA
address, as it has been modified in work_fn_tx(). Else warnings are
printed if CONFIG_DMA_API_DEBUG=y:

    WARNING: CPU: 0 PID: 20 at lib/dma-debug.c:1103 check_unmap+0x24c/0x85c()
    rcar-dmac e6700000.dma-controller: DMA-API: device driver frees DMA memory with different size [device address=0x000000006e15f000] [map size@96 bytes] [unmap size=3 bytes]

and:

    WARNING: CPU: 0 PID: 1364 at lib/dma-debug.c:1093 check_unmap+0x178/0x85c()
    rcar-dmac e6700000.dma-controller: DMA-API: device driver tries to free DMA memory it has not allocated [device address=0x000000006e16b006] [size@96 bytes]

TODO: Simplify by switching to dma_map_single(), as the transmit
scatterlist contains one single entry, which is reused and modified.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add TODO
---
 drivers/tty/serial/sh-sci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6431b1fb9c162e77..8ffc6320ff0a8448 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1390,6 +1390,14 @@ static void sci_tx_dma_release(struct sci_port *s, bool enable_pio)
 
 	s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
+	if (s->sg_len_tx) {
+		/* Restore sg_dma_len() and sg_dma_address() */
+		sg_dma_len(&s->sg_tx) = UART_XMIT_SIZE;
+		sg_dma_address(&s->sg_tx) = sg_dma_address(&s->sg_tx) &
+					    ~(UART_XMIT_SIZE - 1);
+		dma_unmap_sg(chan->device->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
+		s->sg_len_tx = 0;
+	}
 	dma_release_channel(chan);
 	if (enable_pio)
 		sci_start_tx(port);
-- 
1.9.1

