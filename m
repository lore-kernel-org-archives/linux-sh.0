From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 23 Mar 2015 08:26:36 +0000
Subject: [PATCH v2 1/4] i2c: slave: rework the slave API
Message-Id: <1427099199-3628-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

After more discussion, brave users, and additional datasheet evaluation,
some API updates for the new I2C slave framework became imminent. The
slave events now get some easier to understand naming. Also, the event
handling has been simplified to only need a single call to the slave
callback when an action by the backend is required.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---

Changes since V1: added acks

 drivers/i2c/busses/i2c-rcar.c  | 10 ++++------
 drivers/i2c/i2c-slave-eeprom.c | 12 ++++++------
 include/linux/i2c.h            |  8 ++++----
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 71a6e07eb7ab7c..5a84bea5b84514 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -382,11 +382,11 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 	if (ssr_filtered & SAR) {
 		/* read or write request */
 		if (ssr_raw & STM) {
-			i2c_slave_event(priv->slave, I2C_SLAVE_REQ_READ_START, &value);
+			i2c_slave_event(priv->slave, I2C_SLAVE_READ_REQUESTED, &value);
 			rcar_i2c_write(priv, ICRXTX, value);
 			rcar_i2c_write(priv, ICSIER, SDE | SSR | SAR);
 		} else {
-			i2c_slave_event(priv->slave, I2C_SLAVE_REQ_WRITE_START, &value);
+			i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
 			rcar_i2c_read(priv, ICRXTX);	/* dummy read */
 			rcar_i2c_write(priv, ICSIER, SDR | SSR | SAR);
 		}
@@ -406,17 +406,15 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 		int ret;
 
 		value = rcar_i2c_read(priv, ICRXTX);
-		ret = i2c_slave_event(priv->slave, I2C_SLAVE_REQ_WRITE_END, &value);
+		ret = i2c_slave_event(priv->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
 		/* Send NACK in case of error */
 		rcar_i2c_write(priv, ICSCR, SIE | SDBS | (ret < 0 ? FNA : 0));
-		i2c_slave_event(priv->slave, I2C_SLAVE_REQ_WRITE_START, &value);
 		rcar_i2c_write(priv, ICSSR, ~SDR & 0xff);
 	}
 
 	/* master wants to read from us */
 	if (ssr_filtered & SDE) {
-		i2c_slave_event(priv->slave, I2C_SLAVE_REQ_READ_END, &value);
-		i2c_slave_event(priv->slave, I2C_SLAVE_REQ_READ_START, &value);
+		i2c_slave_event(priv->slave, I2C_SLAVE_READ_PROCESSED, &value);
 		rcar_i2c_write(priv, ICRXTX, value);
 		rcar_i2c_write(priv, ICSSR, ~SDE & 0xff);
 	}
diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index cf9b09db092f4e..3fb45d894d8072 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -36,7 +36,7 @@ static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
 	struct eeprom_data *eeprom = i2c_get_clientdata(client);
 
 	switch (event) {
-	case I2C_SLAVE_REQ_WRITE_END:
+	case I2C_SLAVE_WRITE_RECEIVED:
 		if (eeprom->first_write) {
 			eeprom->buffer_idx = *val;
 			eeprom->first_write = false;
@@ -47,17 +47,17 @@ static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
 		}
 		break;
 
-	case I2C_SLAVE_REQ_READ_START:
+	case I2C_SLAVE_READ_PROCESSED:
+		eeprom->buffer_idx++;
+		/* fallthrough */
+	case I2C_SLAVE_READ_REQUESTED:
 		spin_lock(&eeprom->buffer_lock);
 		*val = eeprom->buffer[eeprom->buffer_idx];
 		spin_unlock(&eeprom->buffer_lock);
 		break;
 
-	case I2C_SLAVE_REQ_READ_END:
-		eeprom->buffer_idx++;
-		break;
-
 	case I2C_SLAVE_STOP:
+	case I2C_SLAVE_WRITE_REQUESTED:
 		eeprom->first_write = true;
 		break;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f17da50402a4da..f76031608cb723 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -253,10 +253,10 @@ static inline void i2c_set_clientdata(struct i2c_client *dev, void *data)
 
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
 enum i2c_slave_event {
-	I2C_SLAVE_REQ_READ_START,
-	I2C_SLAVE_REQ_READ_END,
-	I2C_SLAVE_REQ_WRITE_START,
-	I2C_SLAVE_REQ_WRITE_END,
+	I2C_SLAVE_READ_REQUESTED,
+	I2C_SLAVE_WRITE_REQUESTED,
+	I2C_SLAVE_READ_PROCESSED,
+	I2C_SLAVE_WRITE_RECEIVED,
 	I2C_SLAVE_STOP,
 };
 
-- 
2.1.4

