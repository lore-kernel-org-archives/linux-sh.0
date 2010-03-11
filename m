From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Mar 2010 10:05:50 +0000
Subject: [PATCH 01/03] i2c: i2c-sh_mobile register access code break out
Message-Id: <20100311100550.15227.24729.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311100526.15227.50813.sendpatchset@t400s>
In-Reply-To: <20100311100526.15227.50813.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, nishimoto.hiroki@renesas.com, khali@linux-fr.org, lethal@linux-sh.org, morimoto.kuninori@renesas.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Break out register access functions in the
i2c-sh_mobile driver. This update should not
change any driver logic.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/i2c/busses/i2c-sh_mobile.c |   90 +++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 37 deletions(-)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2010-03-11 15:16:09.000000000 +0900
@@ -131,12 +131,12 @@ struct sh_mobile_i2c_data {
 #define NORMAL_SPEED		100000 /* FAST_SPEED 400000 */
 
 /* Register offsets */
-#define ICDR(pd)		(pd->reg + 0x00)
-#define ICCR(pd)		(pd->reg + 0x04)
-#define ICSR(pd)		(pd->reg + 0x08)
-#define ICIC(pd)		(pd->reg + 0x0c)
-#define ICCL(pd)		(pd->reg + 0x10)
-#define ICCH(pd)		(pd->reg + 0x14)
+#define ICDR			0x00
+#define ICCR			0x04
+#define ICSR			0x08
+#define ICIC			0x0c
+#define ICCL			0x10
+#define ICCH			0x14
 
 /* Register bits */
 #define ICCR_ICE		0x80
@@ -159,6 +159,22 @@ struct sh_mobile_i2c_data {
 #define ICIC_WAITE		0x02
 #define ICIC_DTEE		0x01
 
+static void iic_wr(struct sh_mobile_i2c_data *pd, int offs, unsigned char data)
+{
+	iowrite8(data, pd->reg + offs);
+}
+
+static unsigned char iic_rd(struct sh_mobile_i2c_data *pd, int offs)
+{
+	return ioread8(pd->reg + offs);
+}
+
+static void iic_set_clr(struct sh_mobile_i2c_data *pd, int offs,
+			unsigned char set, unsigned char clr)
+{
+	iic_wr(pd, offs, (iic_rd(pd, offs) | set) & ~clr);
+}
+
 static void activate_ch(struct sh_mobile_i2c_data *pd)
 {
 	unsigned long i2c_clk;
@@ -196,24 +212,24 @@ static void activate_ch(struct sh_mobile
 		pd->icch = (u_int8_t)(num/denom);
 
 	/* Enable channel and configure rx ack */
-	iowrite8(ioread8(ICCR(pd)) | ICCR_ICE, ICCR(pd));
+	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 
 	/* Mask all interrupts */
-	iowrite8(0, ICIC(pd));
+	iic_wr(pd, ICIC, 0);
 
 	/* Set the clock */
-	iowrite8(pd->iccl, ICCL(pd));
-	iowrite8(pd->icch, ICCH(pd));
+	iic_wr(pd, ICCL, pd->iccl);
+	iic_wr(pd, ICCH, pd->icch);
 }
 
 static void deactivate_ch(struct sh_mobile_i2c_data *pd)
 {
 	/* Clear/disable interrupts */
-	iowrite8(0, ICSR(pd));
-	iowrite8(0, ICIC(pd));
+	iic_wr(pd, ICSR, 0);
+	iic_wr(pd, ICIC, 0);
 
 	/* Disable channel */
-	iowrite8(ioread8(ICCR(pd)) & ~ICCR_ICE, ICCR(pd));
+	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
 
 	/* Disable clock and mark device as idle */
 	clk_disable(pd->clk);
@@ -232,35 +248,35 @@ static unsigned char i2c_op(struct sh_mo
 
 	switch (op) {
 	case OP_START: /* issue start and trigger DTE interrupt */
-		iowrite8(0x94, ICCR(pd));
+		iic_wr(pd, ICCR, 0x94);
 		break;
 	case OP_TX_FIRST: /* disable DTE interrupt and write data */
-		iowrite8(ICIC_WAITE | ICIC_ALE | ICIC_TACKE, ICIC(pd));
-		iowrite8(data, ICDR(pd));
+		iic_wr(pd, ICIC, ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
+		iic_wr(pd, ICDR, data);
 		break;
 	case OP_TX: /* write data */
-		iowrite8(data, ICDR(pd));
+		iic_wr(pd, ICDR, data);
 		break;
 	case OP_TX_STOP: /* write data and issue a stop afterwards */
-		iowrite8(data, ICDR(pd));
-		iowrite8(0x90, ICCR(pd));
+		iic_wr(pd, ICDR, data);
+		iic_wr(pd, ICCR, 0x90);
 		break;
 	case OP_TX_TO_RX: /* select read mode */
-		iowrite8(0x81, ICCR(pd));
+		iic_wr(pd, ICCR, 0x81);
 		break;
 	case OP_RX: /* just read data */
-		ret = ioread8(ICDR(pd));
+		ret = iic_rd(pd, ICDR);
 		break;
 	case OP_RX_STOP: /* enable DTE interrupt, issue stop */
-		iowrite8(ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE,
-			 ICIC(pd));
-		iowrite8(0xc0, ICCR(pd));
+		iic_wr(pd, ICIC,
+		       ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
+		iic_wr(pd, ICCR, 0xc0);
 		break;
 	case OP_RX_STOP_DATA: /* enable DTE interrupt, read data, issue stop */
-		iowrite8(ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE,
-			 ICIC(pd));
-		ret = ioread8(ICDR(pd));
-		iowrite8(0xc0, ICCR(pd));
+		iic_wr(pd, ICIC,
+		       ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
+		ret = iic_rd(pd, ICDR);
+		iic_wr(pd, ICCR, 0xc0);
 		break;
 	}
 
@@ -366,7 +382,7 @@ static irqreturn_t sh_mobile_i2c_isr(int
 	unsigned char sr;
 	int wakeup;
 
-	sr = ioread8(ICSR(pd));
+	sr = iic_rd(pd, ICSR);
 	pd->sr |= sr; /* remember state */
 
 	dev_dbg(pd->dev, "i2c_isr 0x%02x 0x%02x %s %d %d!\n", sr, pd->sr,
@@ -375,7 +391,7 @@ static irqreturn_t sh_mobile_i2c_isr(int
 
 	if (sr & (ICSR_AL | ICSR_TACK)) {
 		/* don't interrupt transaction - continue to issue stop */
-		iowrite8(sr & ~(ICSR_AL | ICSR_TACK), ICSR(pd));
+		iic_wr(pd, ICSR, sr & ~(ICSR_AL | ICSR_TACK));
 		wakeup = 0;
 	} else if (pd->msg->flags & I2C_M_RD)
 		wakeup = sh_mobile_i2c_isr_rx(pd);
@@ -383,7 +399,7 @@ static irqreturn_t sh_mobile_i2c_isr(int
 		wakeup = sh_mobile_i2c_isr_tx(pd);
 
 	if (sr & ICSR_WAIT) /* TODO: add delay here to support slow acks */
-		iowrite8(sr & ~ICSR_WAIT, ICSR(pd));
+		iic_wr(pd, ICSR, sr & ~ICSR_WAIT);
 
 	if (wakeup) {
 		pd->sr |= SW_DONE;
@@ -401,21 +417,21 @@ static int start_ch(struct sh_mobile_i2c
 	}
 
 	/* Initialize channel registers */
-	iowrite8(ioread8(ICCR(pd)) & ~ICCR_ICE, ICCR(pd));
+	iic_set_clr(pd, ICCR, 0, ICCR_ICE);
 
 	/* Enable channel and configure rx ack */
-	iowrite8(ioread8(ICCR(pd)) | ICCR_ICE, ICCR(pd));
+	iic_set_clr(pd, ICCR, ICCR_ICE, 0);
 
 	/* Set the clock */
-	iowrite8(pd->iccl, ICCL(pd));
-	iowrite8(pd->icch, ICCH(pd));
+	iic_wr(pd, ICCL, pd->iccl);
+	iic_wr(pd, ICCH, pd->icch);
 
 	pd->msg = usr_msg;
 	pd->pos = -1;
 	pd->sr = 0;
 
 	/* Enable all interrupts to begin with */
-	iowrite8(ICIC_WAITE | ICIC_ALE | ICIC_TACKE | ICIC_DTEE, ICIC(pd));
+	iic_wr(pd, ICIC, ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
 	return 0;
 }
 
@@ -450,7 +466,7 @@ static int sh_mobile_i2c_xfer(struct i2c
 
 		retry_count = 1000;
 again:
-		val = ioread8(ICSR(pd));
+		val = iic_rd(pd, ICSR);
 
 		dev_dbg(pd->dev, "val 0x%02x pd->sr 0x%02x\n", val, pd->sr);
 
