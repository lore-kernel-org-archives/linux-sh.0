From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 31 Oct 2014 10:51:16 +0000
Subject: [RFC 1/3] i2c: sh_mobile: add DMA support
Message-Id: <1414752678-26078-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Make it possible to transfer i2c message buffers via DMA.
Start/Stop/Sending_Slave_Adress is still handled using the old state
machine, it is sending the actual data that is done via DMA. This is
least intrusive and allows us to work with the message buffers directly
instead of preparing a custom buffer which involves copying the data
around.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      |   5 +
 drivers/i2c/busses/i2c-sh_mobile.c                 | 203 +++++++++++++++++++--
 2 files changed, 189 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
index d2153ce36fa8..58dcf7d71e9c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -10,6 +10,11 @@ Required properties:
 
 Optional properties:
 - clock-frequency : frequency of bus clock in Hz. Default 100kHz if unset.
+- dmas            : Must contain a list of two references to DMA
+		    specifiers, one for transmission, and one for
+		    reception.
+- dma-names       : Must contain a list of two DMA names, "tx" and "rx".
+
 
 Pinctrl properties might be needed, too. See there.
 
diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index 8b5e79cb4468..23664b21ab37 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -1,6 +1,8 @@
 /*
  * SuperH Mobile I2C Controller
  *
+ * Copyright (C) 2014 Wolfram Sang <wsa@sang-engineering.com>
+ *
  * Copyright (C) 2008 Magnus Damm
  *
  * Portions of the code based on out-of-tree driver i2c-sh7343.c
@@ -33,6 +35,9 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/sh_dma.h>
 #include <linux/i2c/i2c-sh_mobile.h>
 
 /* Transmit operation:                                                      */
@@ -114,6 +119,7 @@ enum sh_mobile_i2c_op {
 	OP_TX_FIRST,
 	OP_TX,
 	OP_TX_STOP,
+	OP_TX_STOP_DATA,
 	OP_TX_TO_RX,
 	OP_RX,
 	OP_RX_STOP,
@@ -138,6 +144,12 @@ struct sh_mobile_i2c_data {
 	int pos;
 	int sr;
 	bool send_stop;
+
+	struct dma_chan *dma_tx;
+	struct dma_chan *dma_rx;
+	struct scatterlist sg;
+	enum dma_data_direction dma_direction;
+	bool buf_mapped;
 };
 
 struct sh_mobile_dt_config {
@@ -175,6 +187,8 @@ struct sh_mobile_dt_config {
 
 #define ICIC_ICCLB8		0x80
 #define ICIC_ICCHB8		0x40
+#define ICIC_TDMAE		0x20
+#define ICIC_RDMAE		0x10
 #define ICIC_ALE		0x08
 #define ICIC_TACKE		0x04
 #define ICIC_WAITE		0x02
@@ -336,8 +350,10 @@ static unsigned char i2c_op(struct sh_mobile_i2c_data *pd,
 	case OP_TX: /* write data */
 		iic_wr(pd, ICDR, data);
 		break;
-	case OP_TX_STOP: /* write data and issue a stop afterwards */
+	case OP_TX_STOP_DATA: /* write data and issue a stop afterwards */
 		iic_wr(pd, ICDR, data);
+		/* fallthrough */
+	case OP_TX_STOP: /* issue a stop */
 		iic_wr(pd, ICCR, pd->send_stop ? ICCR_ICE | ICCR_TRS
 					       : ICCR_ICE | ICCR_TRS | ICCR_BBSY);
 		break;
@@ -393,13 +409,17 @@ static int sh_mobile_i2c_isr_tx(struct sh_mobile_i2c_data *pd)
 {
 	unsigned char data;
 
-	if (pd->pos = pd->msg->len)
+	if (pd->pos = pd->msg->len) {
+		/* Send stop if we haven't yet (DMA case) */
+		if (pd->send_stop && (iic_rd(pd, ICCR) & ICCR_BBSY))
+			i2c_op(pd, OP_TX_STOP, data);
 		return 1;
+	}
 
 	sh_mobile_i2c_get_data(pd, &data);
 
 	if (sh_mobile_i2c_is_last_byte(pd))
-		i2c_op(pd, OP_TX_STOP, data);
+		i2c_op(pd, OP_TX_STOP_DATA, data);
 	else if (sh_mobile_i2c_is_first_byte(pd))
 		i2c_op(pd, OP_TX_FIRST, data);
 	else
@@ -454,7 +474,7 @@ static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 	struct platform_device *dev = dev_id;
 	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
 	unsigned char sr;
-	int wakeup;
+	int wakeup = 0;
 
 	sr = iic_rd(pd, ICSR);
 	pd->sr |= sr; /* remember state */
@@ -463,15 +483,21 @@ static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 	       (pd->msg->flags & I2C_M_RD) ? "read" : "write",
 	       pd->pos, pd->msg->len);
 
-	if (sr & (ICSR_AL | ICSR_TACK)) {
+	/* Kick off TxDMA after preface was done */
+	if (pd->dma_direction = DMA_TO_DEVICE && pd->pos = 0)
+		iic_set_clr(pd, ICIC, ICIC_TDMAE, 0);
+	else if (sr & (ICSR_AL | ICSR_TACK))
 		/* don't interrupt transaction - continue to issue stop */
 		iic_wr(pd, ICSR, sr & ~(ICSR_AL | ICSR_TACK));
-		wakeup = 0;
-	} else if (pd->msg->flags & I2C_M_RD)
+	else if (pd->msg->flags & I2C_M_RD)
 		wakeup = sh_mobile_i2c_isr_rx(pd);
 	else
 		wakeup = sh_mobile_i2c_isr_tx(pd);
 
+	/* Kick off RxDMA after preface was done */
+	if (pd->dma_direction = DMA_FROM_DEVICE && pd->pos = 1)
+		iic_set_clr(pd, ICIC, ICIC_RDMAE, 0);
+
 	if (sr & ICSR_WAIT) /* TODO: add delay here to support slow acks */
 		iic_wr(pd, ICSR, sr & ~ICSR_WAIT);
 
@@ -486,6 +512,82 @@ static irqreturn_t sh_mobile_i2c_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void sh_mobile_i2c_cleanup_dma(struct sh_mobile_i2c_data *pd)
+{
+	if (pd->dma_direction = DMA_FROM_DEVICE)
+		dmaengine_terminate_all(pd->dma_rx);
+	if (pd->dma_direction = DMA_TO_DEVICE)
+		dmaengine_terminate_all(pd->dma_tx);
+
+	if (pd->buf_mapped) {
+		dma_unmap_single(pd->dev, sg_dma_address(&pd->sg),
+				 pd->msg->len, pd->dma_direction);
+		pd->buf_mapped = false;
+	}
+
+	pd->dma_direction = DMA_NONE;
+}
+
+static void sh_mobile_i2c_dma_callback(void *data)
+{
+	struct sh_mobile_i2c_data *pd = data;
+
+	dma_unmap_single(pd->dev, sg_dma_address(&pd->sg),
+			 pd->msg->len, pd->dma_direction);
+
+	pd->buf_mapped = false;
+	pd->dma_direction = DMA_NONE;
+	pd->pos = pd->msg->len;
+
+	iic_set_clr(pd, ICIC, 0, ICIC_TDMAE | ICIC_RDMAE);
+}
+
+static void sh_mobile_i2c_xfer_dma(struct sh_mobile_i2c_data *pd)
+{
+	bool read = pd->msg->flags & I2C_M_RD;
+	enum dma_data_direction dir = read ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	struct dma_chan *chan = read ? pd->dma_rx : pd->dma_tx;
+	struct dma_async_tx_descriptor *txdesc;
+	dma_addr_t dma_addr;
+	dma_cookie_t cookie;
+
+	if (!chan)
+		return;
+
+	dma_addr = dma_map_single(pd->dev, pd->msg->buf, pd->msg->len, dir);
+	if (dma_mapping_error(pd->dev, dma_addr)) {
+		dev_warn(pd->dev, "dma map failed, using PIO\n");
+		return;
+	}
+
+	sg_dma_len(&pd->sg) = pd->msg->len;
+	sg_dma_address(&pd->sg) = dma_addr;
+
+	pd->buf_mapped = true;
+	pd->dma_direction = dir;
+
+	txdesc = dmaengine_prep_slave_sg(chan, &pd->sg, 1,
+					 read ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV,
+					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!txdesc) {
+		dev_warn(pd->dev, "dma prep slave sg failed, using PIO\n");
+		sh_mobile_i2c_cleanup_dma(pd);
+		return;
+	}
+
+	txdesc->callback = sh_mobile_i2c_dma_callback;
+	txdesc->callback_param = pd;
+
+	cookie = dmaengine_submit(txdesc);
+	if (dma_submit_error(cookie)) {
+		dev_warn(pd->dev, "submitting dma failed, using PIO\n");
+		sh_mobile_i2c_cleanup_dma(pd);
+		return;
+	}
+
+	dma_async_issue_pending(chan);
+}
+
 static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
 		    bool do_init)
 {
@@ -510,6 +612,9 @@ static int start_ch(struct sh_mobile_i2c_data *pd, struct i2c_msg *usr_msg,
 	pd->pos = -1;
 	pd->sr = 0;
 
+	if (pd->msg->len > 4)
+		sh_mobile_i2c_xfer_dma(pd);
+
 	/* Enable all interrupts to begin with */
 	iic_wr(pd, ICIC, ICIC_DTEE | ICIC_WAITE | ICIC_ALE | ICIC_TACKE);
 	return 0;
@@ -593,6 +698,9 @@ static int sh_mobile_i2c_xfer(struct i2c_adapter *adapter,
 				       5 * HZ);
 		if (!k) {
 			dev_err(pd->dev, "Transfer request timed out\n");
+			if (pd->dma_direction != DMA_NONE)
+				sh_mobile_i2c_cleanup_dma(pd);
+
 			err = -ETIMEDOUT;
 			break;
 		}
@@ -641,6 +749,70 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
 
+static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
+					      enum dma_transfer_direction dir,
+					      dma_addr_t port_addr)
+{
+	dma_cap_mask_t mask;
+	struct dma_chan *chan;
+	struct dma_slave_config cfg;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	chan = dma_request_slave_channel_compat(mask, shdma_chan_filter,
+				(void *)0UL, dev, dir = DMA_MEM_TO_DEV ? "tx" : "rx");
+
+	if (!chan)
+		return NULL;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.direction = dir;
+	if (dir = DMA_MEM_TO_DEV) {
+		cfg.dst_addr = port_addr;
+		cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	} else {
+		cfg.src_addr = port_addr;
+		cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	}
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret) {
+		dev_warn(dev, "dmaengine_slave_config failed %d\n", ret);
+		dma_release_channel(chan);
+		return NULL;
+	}
+
+	return chan;
+}
+
+static void sh_mobile_i2c_request_dma(struct sh_mobile_i2c_data *pd, const struct resource *res)
+{
+	pd->buf_mapped = false;
+	pd->dma_direction = DMA_NONE;
+	sg_init_table(&pd->sg, 1);
+
+	pd->dma_rx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
+					       res->start + ICDR);
+
+	pd->dma_tx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
+					       res->start + ICDR);
+}
+
+static void sh_mobile_i2c_release_dma(struct sh_mobile_i2c_data *pd)
+{
+	if (pd->dma_tx) {
+		dma_release_channel(pd->dma_tx);
+		pd->dma_tx = NULL;
+	}
+
+	if (pd->dma_rx) {
+		dma_release_channel(pd->dma_rx);
+		pd->dma_rx = NULL;
+	}
+}
+
 static int sh_mobile_i2c_hook_irqs(struct platform_device *dev)
 {
 	struct resource *res;
@@ -727,6 +899,8 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
+	sh_mobile_i2c_request_dma(pd, res);
+
 	/* Enable Runtime PM for this device.
 	 *
 	 * Also tell the Runtime PM core to ignore children
@@ -758,6 +932,7 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
 
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
+		sh_mobile_i2c_release_dma(pd);
 		dev_err(&dev->dev, "cannot add numbered adapter\n");
 		return ret;
 	}
@@ -774,6 +949,7 @@ static int sh_mobile_i2c_remove(struct platform_device *dev)
 	struct sh_mobile_i2c_data *pd = platform_get_drvdata(dev);
 
 	i2c_del_adapter(&pd->adap);
+	sh_mobile_i2c_release_dma(pd);
 	pm_runtime_disable(&dev->dev);
 	return 0;
 }
@@ -805,19 +981,8 @@ static struct platform_driver sh_mobile_i2c_driver = {
 	.probe		= sh_mobile_i2c_probe,
 	.remove		= sh_mobile_i2c_remove,
 };
+module_platform_driver(sh_mobile_i2c_driver);
 
-static int __init sh_mobile_i2c_adap_init(void)
-{
-	return platform_driver_register(&sh_mobile_i2c_driver);
-}
-
-static void __exit sh_mobile_i2c_adap_exit(void)
-{
-	platform_driver_unregister(&sh_mobile_i2c_driver);
-}
-
-subsys_initcall(sh_mobile_i2c_adap_init);
-module_exit(sh_mobile_i2c_adap_exit);
 
 MODULE_DESCRIPTION("SuperH Mobile I2C Bus Controller driver");
 MODULE_AUTHOR("Magnus Damm");
-- 
2.0.0

