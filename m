From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 02 Jun 2014 13:38:18 +0000
Subject: [PATCH 16/18] spi: rspi: Add DMA support for RSPI on RZ/A1H
Message-Id: <1401716301-29612-17-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Enable DMA support for RSPI on r7s72100 (RZ/A1H).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is untested, due to lack of DMA integration code on r7s72100/genmai.
---
 drivers/spi/spi-rspi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index bec81470dd9c..4bc4138e002b 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -625,6 +625,9 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 
 	rspi_rz_receive_init(rspi);
 
+	if (master->can_dma && __rspi_can_dma(rspi, xfer))
+		return rspi_dma_transfer(rspi, &xfer->tx_sg, &xfer->rx_sg);
+
 	ret = rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
 	if (ret < 0)
 		return ret;
-- 
1.9.1

