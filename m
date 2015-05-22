From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Fri, 22 May 2015 09:59:36 +0000
Subject: [PATCH 1/2] spi: modify the name of "qspi_trigger_transfer_out_int" function
Message-Id: <1432288777-7229-2-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1432288777-7229-1-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1432288777-7229-1-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org, geert+renesas@glider.be, linux-spi@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com, ryusuke.sakato.bx@renesas.com, linux-sh@vger.kernel.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

The name of "qspi_trigger_transfer_out_int" function should be
"qspi_trigger_transfer_out_in" without "t".

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index f6bac9e..ccef53a 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -724,7 +724,7 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 	return rspi_common_transfer(rspi, xfer);
 }
 
-static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,
+static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
 	int i, n, ret;
@@ -771,7 +771,7 @@ static int qspi_transfer_out_in(struct rspi_data *rspi,
 	if (ret != -EAGAIN)
 		return ret;
 
-	ret = qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
+	ret = qspi_trigger_transfer_out_in(rspi, xfer->tx_buf,
 					    xfer->rx_buf, xfer->len);
 	if (ret < 0)
 		return ret;
-- 
1.9.1

