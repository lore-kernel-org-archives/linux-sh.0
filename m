From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Jan 2013 09:45:57 +0000
Subject: [PATCH 4/4] i2c: sh_mobile: don't send a stop condition by default inside transfers
Message-Id: <1358415957-8371-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

By default there should be no stop bit on I2C between single messages
within transfers. Fix the driver to comply and only send a stop bit at
the end of transfers or if I2C_M_STOP is set.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/i2c/busses/i2c-sh_mobile.c |   79 +++++++++++++++++++++++++++---------
 1 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 5cf2367..1c7be2f 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -38,21 +38,21 @@
 /* Transmit operation:                                                      */
 /*                                                                          */
 /* 0 byte transmit                                                          */
-/* BUS:     S     A8     ACK   P                                            */
+/* BUS:     S     A8     ACK   P(*)                                         */
 /* IRQ:       DTE   WAIT                                                    */
 /* ICIC:                                                                    */
 /* ICCR: 0x94 0x90                                                          */
 /* ICDR:      A8                                                            */
 /*                                                                          */
 /* 1 byte transmit                                                          */
-/* BUS:     S     A8     ACK   D8(1)   ACK   P                              */
+/* BUS:     S     A8     ACK   D8(1)   ACK   P(*)                           */
 /* IRQ:       DTE   WAIT         WAIT                                       */
 /* ICIC:      -DTE                                                          */
 /* ICCR: 0x94       0x90                                                    */
 /* ICDR:      A8    D8(1)                                                   */
 /*                                                                          */
 /* 2 byte transmit                                                          */
-/* BUS:     S     A8     ACK   D8(1)   ACK   D8(2)   ACK   P                */
+/* BUS:     S     A8     ACK   D8(1)   ACK   D8(2)   ACK   P(*)             */
 /* IRQ:       DTE   WAIT         WAIT          WAIT                         */
 /* ICIC:      -DTE                                                          */
 /* ICCR: 0x94                    0x90                                       */
@@ -66,20 +66,20 @@
 /* 0 byte receive - not supported since slave may hold SDA low              */
 /*                                                                          */
 /* 1 byte receive       [TX] | [RX]                                         */
-/* BUS:     S     A8     ACK | D8(1)   ACK   P                              */
+/* BUS:     S     A8     ACK | D8(1)   ACK   P(*)                           */
 /* IRQ:       DTE   WAIT     |   WAIT     DTE                               */
 /* ICIC:      -DTE           |   +DTE                                       */
 /* ICCR: 0x94       0x81     |   0xc0                                       */
 /* ICDR:      A8             |            D8(1)                             */
 /*                                                                          */
 /* 2 byte receive        [TX]| [RX]                                         */
-/* BUS:     S     A8     ACK | D8(1)   ACK   D8(2)   ACK   P                */
+/* BUS:     S     A8     ACK | D8(1)   ACK   D8(2)   ACK   P(*)             */
 /* IRQ:       DTE   WAIT     |   WAIT          WAIT     DTE                 */
 /* ICIC:      -DTE           |                 +DTE                         */
 /* ICCR: 0x94       0x81     |                 0xc0                         */
 /* ICDR:      A8             |                 D8(1)    D8(2)               */
 /*                                                                          */
-/* 3 byte receive       [TX] | [RX]                                         */
+/* 3 byte receive       [TX] | [RX]                                     (*) */
 /* BUS:     S     A8     ACK | D8(1)   ACK   D8(2)   ACK   D8(3)   ACK    P */
 /* IRQ:       DTE   WAIT     |   WAIT          WAIT         WAIT      DTE   */
 /* ICIC:      -DTE           |                              +DTE            */
@@ -94,7 +94,7 @@
 /* SDA ___\___XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXAAAAAAAAA___/                 */
 /* SCL      \_/1\_/2\_/3\_/4\_/5\_/6\_/7\_/8\___/9\_____/                   */
 /*                                                                          */
-/*        S   D7  D6  D5  D4  D3  D2  D1  D0              P                 */
+/*        S   D7  D6  D5  D4  D3  D2  D1  D0              P(*)              */
 /*                                           ___                            */
 /* WAIT IRQ ________________________________/   \___________                */
 /* TACK IRQ ____________________________________/   \_______                */
@@ -103,6 +103,11 @@
 /*         _______________________________________________                  */
 /* BUSY __/                                               \_                */
 /*                                                                          */
+/* (*) The STOP condition is only sent by the master at the end of the last */
+/* I2C message or if the I2C_M_STOP flag is set. Similarly, the BUSY bit is */
+/* only cleared after the STOP condition, so, between messages we have to   */
+/* poll for the DTE bit.                                                    */
+/*                                                                          */
 
 enum sh_mobile_i2c_op {
 	OP_START = 0,
@@ -132,6 +137,7 @@ struct sh_mobile_i2c_data {
 	struct i2c_msg *msg;
 	int pos;
 	int sr;
+	bool send_stop;
 };
 
 #define IIC_FLAG_HAS_ICIC67	(1 << 0)
@@ -322,7 +328,7 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 		break;
 	case OP_TX_STOP: /* write data and issue a stop afterwards */
 		iic_wr(pd, ICDR, data);
-		iic_wr(pd, ICCR, 0x90);
+		iic_wr(pd, ICCR, pd->send_stop ? 0x90 : 0x94);
 		break;
 	case OP_TX_TO_RX: /* select read mode */
 		iic_wr(pd, ICCR, 0x81);
@@ -469,22 +475,25 @@ static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg)
+static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
+		    bool do_init)
 {
 	if (usr_msg->len = 0 && (usr_msg->flags & I2C_M_RD)) {
 		dev_err(pd->dev, "Unsupported zero length i2c read\n");
 		return -EIO;
 	}
 
-	/* Initialize channel registers */
-	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
+	if (do_init) {
+		/* Initialize channel registers */
+		iic_set_clr(pd, ICCR, 0, ICCR_ICE);
 
-	/* Enable channel and configure rx ack */
-	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
+		/* Enable channel and configure rx ack */
+		iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 
-	/* Set the clock */
-	iic_wr(pd, ICCL, pd->iccl & 0xff);
-	iic_wr(pd, ICCH, pd->icch & 0xff);
+		/* Set the clock */
+		iic_wr(pd, ICCL, pd->iccl & 0xff);
+		iic_wr(pd, ICCH, pd->icch & 0xff);
+	}
 
 	pd->msg = usr_msg;
 	pd->pos = -1;
@@ -495,6 +504,30 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg)
 	return 0;
 }
 
+static int poll_dte(struct sh_mobile_i2c_data *pd)
+{
+	int i;
+
+	for (i = 1000; i; i--) {
+		u_int8_t val = iic_rd(pd, ICSR);
+
+		if (val & ICSR_DTE)
+			break;
+
+		if (val & ICSR_TACK)
+			return -EIO;
+
+		udelay(10);
+	}
+
+	if (!i) {
+		dev_warn(pd->dev, "Timeout polling for DTE!\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int poll_busy(struct sh_mobile_i2c_data *pd)
 {
 	int i;
@@ -539,13 +572,16 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 
 	/* Process all messages */
 	for (i = 0; i < num; i++) {
+		bool do_start = pd->send_stop || !i;
 		msg = &msgs[i];
+		pd->send_stop = i = num - 1 || msg->flags & I2C_M_STOP;
 
-		err = start_ch(pd, msg);
+		err = start_ch(pd, msg, do_start);
 		if (err)
 			break;
 
-		i2c_op(pd, OP_START, 0);
+		if (do_start)
+			i2c_op(pd, OP_START, 0);
 
 		/* The interrupt handler takes care of the rest... */
 		k = wait_event_timeout(pd->wait,
@@ -557,7 +593,10 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 			break;
 		}
 
-		err = poll_busy(pd);
+		if (pd->send_stop)
+			err = poll_busy(pd);
+		else
+			err = poll_dte(pd);
 		if (err < 0)
 			break;
 	}
@@ -571,7 +610,7 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 
 static u32 sh_mobile_i2c_func(struct i2c_adapter *adapter)
 {
-	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_PROTOCOL_MANGLING;
 }
 
 static struct i2c_algorithm sh_mobile_i2c_algorithm = {
-- 
1.7.2.5

