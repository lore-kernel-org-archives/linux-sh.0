From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 30 Oct 2015 11:30:06 +0000
Subject: [PATCH] i2c: rcar: Revert the latest refactoring series
Message-Id: <1446204606-25541-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This whole series caused sometimes timeouts and even OOPSes on some
r8a7791 Koelsch boards. We need to understand and fix those first.

Revert "i2c: rcar: clean up after refactoring"
Revert "i2c: rcar: revoke START request early"
Revert "i2c: rcar: check master irqs before slave irqs"
Revert "i2c: rcar: don't issue stop when HW does it automatically"
Revert "i2c: rcar: init new messages in irq"
Revert "i2c: rcar: refactor setup of a msg"
Revert "i2c: rcar: remove spinlock"
Revert "i2c: rcar: remove unused IOERROR state"
Revert "i2c: rcar: rework hw init"

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 193 ++++++++++++++++++++++++++----------------
 1 file changed, 122 insertions(+), 71 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index bbf3b2505aaf09..09bdce969bd8e6 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1,8 +1,7 @@
 /*
  * Driver for the Renesas RCar I2C unit
  *
- * Copyright (C) 2014-15 Wolfram Sang <wsa@sang-engineering.com>
- * Copyright (C) 2011-2015 Renesas Electronics Corporation
+ * Copyright (C) 2014 Wolfram Sang <wsa@sang-engineering.com>
  *
  * Copyright (C) 2012-14 Renesas Solutions Corp.
  * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
@@ -10,6 +9,9 @@
  * This file is based on the drivers/i2c/busses/i2c-sh7760.c
  * (c) 2005-2008 MSC Vertriebsges.m.b.H, Manuel Lauss <mlau@msc-ge.com>
  *
+ * This file used out-of-tree driver i2c-rcar.c
+ * Copyright (C) 2011-2012 Renesas Electronics Corporation
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; version 2 of the License.
@@ -31,6 +33,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 /* register offsets */
 #define ICSCR	0x00	/* slave ctrl */
@@ -81,7 +84,6 @@
 
 #define RCAR_BUS_PHASE_START	(MDBS | MIE | ESG)
 #define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
-#define RCAR_BUS_MASK_DATA	(~(ESG | FSB) & 0xFF)
 #define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
 #define RCAR_IRQ_SEND	(MNR | MAL | MST | MAT | MDE)
@@ -92,6 +94,7 @@
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR) & 0xFF)
 
 #define ID_LAST_MSG	(1 << 0)
+#define ID_IOERROR	(1 << 1)
 #define ID_DONE		(1 << 2)
 #define ID_ARBLOST	(1 << 3)
 #define ID_NACK		(1 << 4)
@@ -105,10 +108,10 @@ enum rcar_i2c_type {
 struct rcar_i2c_priv {
 	void __iomem *io;
 	struct i2c_adapter adap;
-	struct i2c_msg *msg;
-	int msgs_left;
+	struct i2c_msg	*msg;
 	struct clk *clk;
 
+	spinlock_t lock;
 	wait_queue_head_t wait;
 
 	int pos;
@@ -141,10 +144,9 @@ static void rcar_i2c_init(struct rcar_i2c_priv *priv)
 {
 	/* reset master mode */
 	rcar_i2c_write(priv, ICMIER, 0);
-	rcar_i2c_write(priv, ICMCR, MDBS);
+	rcar_i2c_write(priv, ICMCR, 0);
 	rcar_i2c_write(priv, ICMSR, 0);
-	/* start clock */
-	rcar_i2c_write(priv, ICCCR, priv->icccr);
+	rcar_i2c_write(priv, ICMAR, 0);
 }
 
 static int rcar_i2c_bus_barrier(struct rcar_i2c_priv *priv)
@@ -243,7 +245,9 @@ scgd_find:
 	dev_dbg(dev, "clk %d/%d(%lu), round %u, CDF:0x%x, SCGD: 0x%x\n",
 		scl, bus_speed, clk_get_rate(priv->clk), round, cdf, scgd);
 
-	/* keep icccr value */
+	/*
+	 * keep icccr value
+	 */
 	priv->icccr = scgd << cdf_width | cdf;
 
 	return 0;
@@ -253,24 +257,12 @@ static void rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
-	priv->pos = 0;
-	priv->flags = 0;
-	if (priv->msgs_left = 1)
-		rcar_i2c_flags_set(priv, ID_LAST_MSG);
-
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
 	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 }
 
-static void rcar_i2c_next_msg(struct rcar_i2c_priv *priv)
-{
-	priv->msg++;
-	priv->msgs_left--;
-	rcar_i2c_prepare_msg(priv);
-}
-
 /*
  *		interrupt functions
  */
@@ -278,10 +270,21 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 {
 	struct i2c_msg *msg = priv->msg;
 
-	/* FIXME: sometimes, unknown interrupt happened. Do nothing */
+	/*
+	 * FIXME
+	 * sometimes, unknown interrupt happened.
+	 * Do nothing
+	 */
 	if (!(msr & MDE))
 		return 0;
 
+	/*
+	 * If address transfer phase finished,
+	 * goto data phase.
+	 */
+	if (msr & MAT)
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
+
 	if (priv->pos < msg->len) {
 		/*
 		 * Prepare next data to ICRXTX register.
@@ -302,17 +305,21 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 		 * [ICRXTX] -> [SHIFT] -> [I2C bus]
 		 */
 
-		if (priv->flags & ID_LAST_MSG) {
+		if (priv->flags & ID_LAST_MSG)
 			/*
 			 * If current msg is the _LAST_ msg,
 			 * prepare stop condition here.
 			 * ID_DONE will be set on STOP irq.
 			 */
 			rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-		} else {
-			rcar_i2c_next_msg(priv);
-			return 0;
-		}
+		else
+			/*
+			 * If current msg is _NOT_ last msg,
+			 * it doesn't call stop phase.
+			 * thus, there is no STOP irq.
+			 * return ID_DONE here.
+			 */
+			return ID_DONE;
 	}
 
 	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_SEND);
@@ -324,30 +331,39 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 {
 	struct i2c_msg *msg = priv->msg;
 
-	/* FIXME: sometimes, unknown interrupt happened. Do nothing */
+	/*
+	 * FIXME
+	 * sometimes, unknown interrupt happened.
+	 * Do nothing
+	 */
 	if (!(msr & MDR))
 		return 0;
 
 	if (msr & MAT) {
-		/* Address transfer phase finished, but no data at this point. */
+		/*
+		 * Address transfer phase finished,
+		 * but, there is no data at this point.
+		 * Do nothing.
+		 */
 	} else if (priv->pos < msg->len) {
-		/* get received data */
+		/*
+		 * get received data
+		 */
 		msg->buf[priv->pos] = rcar_i2c_read(priv, ICRXTX);
 		priv->pos++;
 	}
 
 	/*
-	 * If next received data is the _LAST_, go to STOP phase. Might be
-	 * overwritten by REP START when setting up a new msg. Not elegant
-	 * but the only stable sequence for REP START I have found so far.
+	 * If next received data is the _LAST_,
+	 * go to STOP phase,
+	 * otherwise, go to DATA phase.
 	 */
 	if (priv->pos + 1 >= msg->len)
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-
-	if (priv->pos = msg->len && !(priv->flags & ID_LAST_MSG))
-		rcar_i2c_next_msg(priv);
 	else
-		rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
+
+	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
 
 	return 0;
 }
@@ -410,21 +426,22 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	u32 msr, val;
+	irqreturn_t result = IRQ_HANDLED;
+	u32 msr;
 
-	/* Clear START or STOP as soon as we can */
-	val = rcar_i2c_read(priv, ICMCR);
-	rcar_i2c_write(priv, ICMCR, val & RCAR_BUS_MASK_DATA);
+	/*-------------- spin lock -----------------*/
+	spin_lock(&priv->lock);
+
+	if (rcar_i2c_slave_irq(priv))
+		goto exit;
 
 	msr = rcar_i2c_read(priv, ICMSR);
 
 	/* Only handle interrupts that are currently enabled */
 	msr &= rcar_i2c_read(priv, ICMIER);
 	if (!msr) {
-		if (rcar_i2c_slave_irq(priv))
-			return IRQ_HANDLED;
-
-		return IRQ_NONE;
+		result = IRQ_NONE;
+		goto exit;
 	}
 
 	/* Arbitration lost */
@@ -435,7 +452,8 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 	/* Nack */
 	if (msr & MNR) {
-		/* HW automatically sends STOP after received NACK */
+		/* go to stop phase */
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
@@ -443,7 +461,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 	/* Stop */
 	if (msr & MST) {
-		priv->msgs_left--; /* The last message also made it */
 		rcar_i2c_flags_set(priv, ID_DONE);
 		goto out;
 	}
@@ -460,7 +477,11 @@ out:
 		wake_up(&priv->wait);
 	}
 
-	return IRQ_HANDLED;
+exit:
+	spin_unlock(&priv->lock);
+	/*-------------- spin unlock -----------------*/
+
+	return result;
 }
 
 static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
@@ -469,11 +490,22 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 {
 	struct rcar_i2c_priv *priv = i2c_get_adapdata(adap);
 	struct device *dev = rcar_i2c_priv_to_dev(priv);
+	unsigned long flags;
 	int i, ret;
-	long time_left;
+	long timeout;
 
 	pm_runtime_get_sync(dev);
 
+	/*-------------- spin lock -----------------*/
+	spin_lock_irqsave(&priv->lock, flags);
+
+	rcar_i2c_init(priv);
+	/* start clock */
+	rcar_i2c_write(priv, ICCCR, priv->icccr);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+	/*-------------- spin unlock -----------------*/
+
 	ret = rcar_i2c_bus_barrier(priv);
 	if (ret < 0)
 		goto out;
@@ -482,28 +514,48 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 		/* This HW can't send STOP after address phase */
 		if (msgs[i].len = 0) {
 			ret = -EOPNOTSUPP;
-			goto out;
+			break;
 		}
-	}
 
-	/* init data */
-	priv->msg = msgs;
-	priv->msgs_left = num;
-
-	rcar_i2c_prepare_msg(priv);
-
-	time_left = wait_event_timeout(priv->wait,
-				     rcar_i2c_flags_has(priv, ID_DONE),
-				     num * adap->timeout);
-	if (!time_left) {
-		rcar_i2c_init(priv);
-		ret = -ETIMEDOUT;
-	} else if (rcar_i2c_flags_has(priv, ID_NACK)) {
-		ret = -ENXIO;
-	} else if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
-		ret = -EAGAIN;
-	} else {
-		ret = num - priv->msgs_left; /* The number of transfer */
+		/*-------------- spin lock -----------------*/
+		spin_lock_irqsave(&priv->lock, flags);
+
+		/* init each data */
+		priv->msg	= &msgs[i];
+		priv->pos	= 0;
+		priv->flags	= 0;
+		if (i = num - 1)
+			rcar_i2c_flags_set(priv, ID_LAST_MSG);
+
+		rcar_i2c_prepare_msg(priv);
+
+		spin_unlock_irqrestore(&priv->lock, flags);
+		/*-------------- spin unlock -----------------*/
+
+		timeout = wait_event_timeout(priv->wait,
+					     rcar_i2c_flags_has(priv, ID_DONE),
+					     adap->timeout);
+		if (!timeout) {
+			ret = -ETIMEDOUT;
+			break;
+		}
+
+		if (rcar_i2c_flags_has(priv, ID_NACK)) {
+			ret = -ENXIO;
+			break;
+		}
+
+		if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
+			ret = -EAGAIN;
+			break;
+		}
+
+		if (rcar_i2c_flags_has(priv, ID_IOERROR)) {
+			ret = -EIO;
+			break;
+		}
+
+		ret = i + 1; /* The number of transfer */
 	}
 out:
 	pm_runtime_put(dev);
@@ -612,10 +664,9 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io))
 		return PTR_ERR(priv->io);
 
-	rcar_i2c_init(priv);
-
 	irq = platform_get_irq(pdev, 0);
 	init_waitqueue_head(&priv->wait);
+	spin_lock_init(&priv->lock);
 
 	adap = &priv->adap;
 	adap->nr = pdev->id;
-- 
2.1.4

