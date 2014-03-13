From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Thu, 13 Mar 2014 08:29:24 +0000
Subject: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, kuninori.morimoto.gx@renesas.com, geert+renesas@linux-m68k.org

From: Hiep Cao Minh <cm-hiep@jinso.co.jp>

In order to transmit and receive data when have 32 bytes of data that
ready has prepared on Transmit/Receive Buffer to transmit or receive.
Instead transmits/receives a byte data using Transmit/Receive Buffer
Data Triggering Number will improve the speed of transfer data.

Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
---
 drivers/spi/spi-rspi.c |  144 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 28987d9..772a942 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -174,6 +174,12 @@
 #define SPBFCR_RXRST		0x40	/* Receive Buffer Data Reset (qspi only) */
 #define SPBFCR_TXTRG_MASK	0x30	/* Transmit Buffer Data Triggering Number */
 #define SPBFCR_RXTRG_MASK	0x07	/* Receive Buffer Data Triggering Number */
+#define SPBFCR_TXTRG_31B	0x00	/* QSPI only */
+#define SPBFCR_TXTRG_0B		0x30	/* QSPI only */
+#define SPBFCR_RXTRG_1B		0x00	/* QSPI only */
+#define SPBFCR_RXTRG_32B	0x07	/* QSPI only */
+
+#define QSPI_BUFFER_SIZE        32
 
 #define DUMMY_DATA		0x00
 
@@ -224,6 +230,16 @@ static u16 rspi_read16(const struct rspi_data *rspi, u16 offset)
 	return ioread16(rspi->addr + offset);
 }
 
+static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
+{
+	u8 data;
+
+	data = rspi_read8(rspi, reg);
+	data &= ~mask;
+	data |= (val & mask);
+	rspi_write8(rspi, data, reg);
+}
+
 /* optional functions */
 struct spi_ops {
 	int (*set_config_register)(const struct rspi_data *rspi,
@@ -358,6 +374,44 @@ static void rspi_negate_ssl(const struct rspi_data *rspi)
 	rspi_write8(rspi, rspi_read8(rspi, RSPI_SPCR) & ~SPCR_SPE, RSPI_SPCR);
 }
 
+static int qspi_set_send_trigger(struct rspi_data *rspi, int remain)
+{
+	int n;
+
+	n = min(remain, QSPI_BUFFER_SIZE);
+
+	if (remain >= QSPI_BUFFER_SIZE) {
+		/* sets triggering number to 32 bytes */
+		qspi_update(rspi, SPBFCR_TXTRG_MASK,
+			     SPBFCR_TXTRG_0B, QSPI_SPBFCR);
+	} else {
+		/* sets triggering number to 1 byte */
+		qspi_update(rspi, SPBFCR_TXTRG_MASK,
+			     SPBFCR_TXTRG_31B, QSPI_SPBFCR);
+	}
+
+	return n;
+}
+
+static int qspi_set_receive_trigger(struct rspi_data *rspi, int remain)
+{
+	int n;
+
+	n = min(remain, QSPI_BUFFER_SIZE);
+
+	if (remain >= QSPI_BUFFER_SIZE) {
+		/* sets triggering number to 32 bytes */
+		qspi_update(rspi, SPBFCR_RXTRG_MASK,
+			     SPBFCR_RXTRG_32B, QSPI_SPBFCR);
+	} else {
+		/* sets triggering number to 1 byte */
+		qspi_update(rspi, SPBFCR_RXTRG_MASK,
+			     SPBFCR_RXTRG_1B, QSPI_SPBFCR);
+	}
+
+	return n;
+}
+
 static int rspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 			 struct spi_transfer *t)
 {
@@ -389,9 +443,10 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 {
 	int remain = t->len;
 	const u8 *data = t->tx_buf;
+	int i, n;
 
 	rspi_write8(rspi, SPBFCR_TXRST, QSPI_SPBFCR);
-	rspi_write8(rspi, 0x00, QSPI_SPBFCR);
+	rspi_write8(rspi, DUMMY_DATA, QSPI_SPBFCR);
 
 	while (remain > 0) {
 
@@ -400,16 +455,38 @@ static int qspi_send_pio(struct rspi_data *rspi, struct spi_message *mesg,
 				"%s: tx empty timeout\n", __func__);
 			return -ETIMEDOUT;
 		}
-		rspi_write8(rspi, *data++, RSPI_SPDR);
-
-		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
-			dev_err(&rspi->master->dev,
-				"%s: receive timeout\n", __func__);
-			return -ETIMEDOUT;
+		n = qspi_set_send_trigger(rspi, remain);
+		if (n >= QSPI_BUFFER_SIZE) {
+			for (i = 0; i < n; i++)
+				rspi_write8(rspi, *data++, RSPI_SPDR);
+			if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
+						    SPCR_SPRIE) < 0) {
+				dev_err(&rspi->master->dev,
+					"%s: receive timeout\n", __func__);
+				return -ETIMEDOUT;
+			}
+			for (i = 0; i < n; i++)
+				rspi_read8(rspi, RSPI_SPDR);
+		} else {
+			for (i = 0; i < n; i++) {
+				if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF,
+							    SPCR_SPTIE) < 0) {
+					dev_err(&rspi->master->dev,
+					   "%s: tx empty timeout\n", __func__);
+				return -ETIMEDOUT;
+				}
+				rspi_write8(rspi, *data++, RSPI_SPDR);
+
+				if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
+							    SPCR_SPRIE) < 0) {
+					dev_err(&rspi->master->dev,
+					   "%s: receive timeout\n", __func__);
+				return -ETIMEDOUT;
+				}
+				rspi_read8(rspi, RSPI_SPDR);
+			}
 		}
-		rspi_read8(rspi, RSPI_SPDR);
-
-		remain--;
+		remain -= n;
 	}
 
 	/* Waiting for the last transmission */
@@ -603,6 +680,7 @@ static int qspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 {
 	int remain = t->len;
 	u8 *data;
+	int i, n;
 
 	qspi_receive_init(rspi);
 
@@ -614,17 +692,43 @@ static int qspi_receive_pio(struct rspi_data *rspi, struct spi_message *mesg,
 				"%s: tx empty timeout\n", __func__);
 			return -ETIMEDOUT;
 		}
-		/* dummy write for generate clock */
-		rspi_write8(rspi, DUMMY_DATA, RSPI_SPDR);
-
-		if (rspi_wait_for_interrupt(rspi, SPSR_SPRF, SPCR_SPRIE) < 0) {
-			dev_err(&rspi->master->dev,
-				"%s: receive timeout\n", __func__);
-			return -ETIMEDOUT;
+		n = qspi_set_receive_trigger(rspi, remain);
+		if (n >= QSPI_BUFFER_SIZE) {
+			/* dummy write for generate clock */
+			for (i = 0; i < n; i++)
+				rspi_write8(rspi, DUMMY_DATA, RSPI_SPDR);
+
+			if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
+						    SPCR_SPRIE) < 0) {
+				dev_err(&rspi->master->dev,
+					"%s: receive timeout\n", __func__);
+				return -ETIMEDOUT;
+			}
+			/* SPDR allows 8, 16 or 32-bit access */
+			for (i = 0; i < n; i++)
+				*data++ = rspi_read8(rspi, RSPI_SPDR);
+		} else {
+			for (i = 0; i < n; i++) {
+				if (rspi_wait_for_interrupt(rspi, SPSR_SPTEF,
+							    SPCR_SPTIE) < 0) {
+					dev_err(&rspi->master->dev,
+					   "%s: tx empty timeout\n", __func__);
+					return -ETIMEDOUT;
+				}
+				/* dummy write for generate clock */
+				rspi_write8(rspi, DUMMY_DATA, RSPI_SPDR);
+
+				if (rspi_wait_for_interrupt(rspi, SPSR_SPRF,
+							    SPCR_SPRIE) < 0) {
+					dev_err(&rspi->master->dev,
+					   "%s: receive timeout\n", __func__);
+					return -ETIMEDOUT;
+				}
+				/* SPDR allows 8, 16 or 32-bit access */
+				*data++ = rspi_read8(rspi, RSPI_SPDR);
+			}
 		}
-		/* SPDR allows 8, 16 or 32-bit access */
-		*data++ = rspi_read8(rspi, RSPI_SPDR);
-		remain--;
+		remain -= n;
 	}
 
 	return 0;
-- 
1.7.9.5

