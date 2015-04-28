From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Tue, 28 Apr 2015 05:55:50 +0000
Subject: [PATCH 2/3] spi: modify the name of qspi_trigger_transfer_out_int function
Message-Id: <1430200551-20708-3-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1430200551-20708-1-git-send-email-cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

The name of "qspi_trigger_transfer_out_int" function should be
"qspi_trigger_transfer_out_in" without "t".

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
---
 drivers/spi/spi-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a17564a..3f65508 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -721,7 +721,7 @@ static int rspi_rz_transfer_one(struct spi_master *master,
 	return rspi_common_transfer(rspi, xfer);
 }
 
-static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, const u8 *tx,
+static int qspi_trigger_transfer_out_in(struct rspi_data *rspi, const u8 *tx,
 					u8 *rx, unsigned int len)
 {
 	int i, n, ret;
@@ -768,7 +768,7 @@ static int qspi_transfer_out_in(struct rspi_data *rspi,
 	if (ret != -EAGAIN)
 		return ret;
 
-	ret = qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
+	ret = qspi_trigger_transfer_out_in(rspi, xfer->tx_buf,
 					    xfer->rx_buf, xfer->len);
 	if (ret < 0)
 		return ret;
-- 
1.9.1

