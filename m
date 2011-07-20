From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 20 Jul 2011 07:59:53 +0000
Subject: [PATCH 2/2 v2] i2c: i2c-riic: add dmaengine supporting
Message-Id: <4E268AF9.2000302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

We can use the dmaengine for the driver, if the dma_tx and/or
dma_rx in riic_platform_data is set. If we use it, we have to set
the irq number for EEI in the resource.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - fix order of the condition for pd->dma_callbacked
  - add warning when the dma_request_channel() failed

 drivers/i2c/busses/i2c-riic.c |  288 +++++++++++++++++++++++++++++++++++------
 include/linux/i2c/riic.h      |    4 +
 2 files changed, 250 insertions(+), 42 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 791a659..5b47ce0 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -30,6 +30,7 @@
 #include <linux/timer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/dmaengine.h>

 #define RIIC_ICCR1	0x00
 #define RIIC_ICCR2	0x01
@@ -164,6 +165,14 @@ struct riic_data {
 	void __iomem *reg;
 	struct i2c_adapter adap;
 	struct i2c_msg *msg;
+	int index;
+	unsigned char icsr2;
+
+	/* for DMAENGINE */
+	struct dma_chan *chan_tx;
+	struct dma_chan *chan_rx;
+	int dma_callbacked;
+	wait_queue_head_t wait;
 };

 #define DRIVER_VERSION	"2011-07-14"
@@ -248,6 +257,8 @@ static int riic_init_setting(struct riic_data *pd, int clock)
 		return ret;

 	riic_set_bit(pd, ICCR1_ICE, RIIC_ICCR1);	/* Enable RIIC */
+	riic_set_bit(pd, ICMR3_WAIT | ICMR3_ACKWP, RIIC_ICMR3);
+	riic_set_bit(pd, ICIER_TIE | ICIER_RIE, RIIC_ICIER);
 	riic_set_bit(pd, ICMR3_RDRFS | ICMR3_WAIT | ICMR3_ACKWP, RIIC_ICMR3);

 	return 0;
@@ -310,10 +321,79 @@ static int riic_send_slave_address(struct riic_data *pd, int read)
 	return 0;
 }

+static void riic_dma_complete(void *arg)
+{
+	struct riic_data *pd = arg;
+
+	pd->dma_callbacked = 1;
+	wake_up(&pd->wait);
+}
+
+static int riic_master_transmit_pio(struct riic_data *pd)
+{
+	int index;
+	int ret = 0;
+
+	index = 0;
+	do {
+		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
+		if (ret < 0)
+			return ret;
+
+		riic_write(pd, pd->msg->buf[index], RIIC_ICDRT);
+		index++;
+	} while (pd->msg->len > index);
+
+	return ret;
+}
+
+static int riic_master_transmit_dma(struct riic_data *pd)
+{
+	struct scatterlist sg;
+	unsigned char *buf = pd->msg->buf;
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+
+	sg_init_table(&sg, 1);
+	sg_set_buf(&sg, buf, pd->msg->len);
+	sg_dma_len(&sg) = pd->msg->len;
+	dma_map_sg(pd->chan_tx->device->dev, &sg, 1, DMA_TO_DEVICE);
+
+	desc = pd->chan_tx->device->device_prep_slave_sg(pd->chan_tx,
+				&sg, 1, DMA_TO_DEVICE,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EIO;
+
+	desc->callback = riic_dma_complete;
+	desc->callback_param = pd;
+	pd->dma_callbacked = 0;
+	ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
+	if (ret < 0)
+		return ret;
+	dmaengine_submit(desc);
+	dma_async_issue_pending(pd->chan_tx);
+
+	pd->icsr2 = riic_read(pd, RIIC_ICSR2);
+	riic_set_bit(pd, ICIER_NAKIE, RIIC_ICIER);
+	ret = wait_event_timeout(pd->wait, pd->dma_callbacked ||
+					   pd->icsr2 & ICSR2_NACKF, HZ);
+	riic_clear_bit(pd, ICIER_NAKIE, RIIC_ICIER);
+	if (pd->icsr2 & ICSR2_NACKF) {
+		dmaengine_terminate_all(pd->chan_tx);
+		return -EIO;
+	}
+	if (!ret && !pd->dma_callbacked) {
+		dmaengine_terminate_all(pd->chan_tx);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int riic_master_transmit(struct riic_data *pd, int stop)
 {
 	int ret = 0;
-	int index;

 	riic_set_bit(pd, ICCR2_ST, RIIC_ICCR2);
 	ret = riic_wait_for_icsr2(pd, ICSR2_START);
@@ -326,15 +406,12 @@ static int riic_master_transmit(struct riic_data *pd, int stop)
 		goto force_exit;

 	/* transmit data */
-	index = 0;
-	do {
-		ret = riic_wait_for_icsr2(pd, ICSR2_TDRE);
-		if (ret < 0)
-			goto force_exit;
-
-		riic_write(pd, pd->msg->buf[index], RIIC_ICDRT);
-		index++;
-	} while (pd->msg->len > index);
+	if (pd->chan_tx && pd->msg->len > 1)
+		ret = riic_master_transmit_dma(pd);
+	else
+		ret = riic_master_transmit_pio(pd);
+	if (ret < 0)
+		goto force_exit;

 	ret = riic_wait_for_icsr2(pd, ICSR2_TEND);
 	if (ret < 0)
@@ -359,12 +436,72 @@ static void riic_set_receive_ack(struct riic_data *pd, int ack)
 		riic_set_bit(pd, ICMR3_ACKBT, RIIC_ICMR3);
 }

+static int riic_master_receive_pio(struct riic_data *pd)
+{
+	int ret;
+
+	pd->index = 0;
+
+	while ((pd->msg->len - 1) > pd->index) {
+		ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
+		if (ret < 0)
+			return ret;
+
+		if ((pd->index + 1) >= (pd->msg->len - 1))
+			break;
+
+		pd->msg->buf[pd->index] = riic_read(pd, RIIC_ICDRR);
+		pd->index++;
+	}
+
+	return 0;
+}
+
+static int riic_master_receive_dma(struct riic_data *pd)
+{
+	struct scatterlist sg;
+	unsigned char *buf = pd->msg->buf;
+	struct dma_async_tx_descriptor *desc;
+	int ret;
+	int len = pd->msg->len - 2;
+
+	pd->index = 0;
+
+	sg_init_table(&sg, 1);
+	sg_set_buf(&sg, buf, len);
+	sg_dma_len(&sg) = len;
+	dma_map_sg(pd->chan_rx->device->dev, &sg, 1, DMA_FROM_DEVICE);
+
+	desc = pd->chan_rx->device->device_prep_slave_sg(pd->chan_rx,
+				&sg, 1, DMA_FROM_DEVICE,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EIO;
+
+	desc->callback = riic_dma_complete;
+	desc->callback_param = pd;
+	pd->dma_callbacked = 0;
+	ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
+	if (ret < 0)
+		return ret;
+	dmaengine_submit(desc);
+	dma_async_issue_pending(pd->chan_rx);
+
+	ret = wait_event_timeout(pd->wait, pd->dma_callbacked, HZ);
+	if (!ret && !pd->dma_callbacked) {
+		dmaengine_terminate_all(pd->chan_rx);
+		return -ETIMEDOUT;
+	}
+
+	pd->index = len;
+	return 0;
+}
+
 static int riic_master_receive(struct riic_data *pd, int restart)
 {
-	int dummy_read = 1;
 	int ret = 0;
-	int index;

+	riic_set_receive_ack(pd, 1);
 	if (restart)
 		riic_set_bit(pd, ICCR2_RS, RIIC_ICCR2);
 	else
@@ -392,40 +529,26 @@ static int riic_master_receive(struct riic_data *pd, int restart)
 		goto force_exit;
 	}

-	/* receive data */
-	index = 0;
-	while ((pd->msg->len - 1) > index) {
-		ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
-		if (ret < 0)
-			return ret;
-
-		if ((index + 1) >= (pd->msg->len - 1))
-			break;
+	/* step 4 */
+	riic_read(pd, RIIC_ICDRR);	/* dummy read */

-		if (dummy_read) {
-			riic_read(pd, RIIC_ICDRR);
-			dummy_read = 0;
-		} else {
-			pd->msg->buf[index] = riic_read(pd, RIIC_ICDRR);
-			index++;
-			riic_set_receive_ack(pd, 1);
-		}
-	}
+	/* receive data */
+	if (pd->chan_rx && pd->msg->len > 2)
+		ret = riic_master_receive_dma(pd);
+	else
+		ret = riic_master_receive_pio(pd);
+	if (ret < 0)
+		return ret;

 	/* step 6 */
 	ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
 	if (ret < 0)
 		return ret;
+	riic_set_receive_ack(pd, 0);

 	/* step 7 */
-	if (dummy_read) {
-		riic_read(pd, RIIC_ICDRR);
-		dummy_read = 0;
-	} else {
-		pd->msg->buf[index] = riic_read(pd, RIIC_ICDRR);
-		index++;
-	}
-	riic_set_receive_ack(pd, 1);
+	pd->msg->buf[pd->index] = riic_read(pd, RIIC_ICDRR);
+	pd->index++;

 	ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
 	if (ret < 0)
@@ -434,11 +557,11 @@ static int riic_master_receive(struct riic_data *pd, int restart)
 	riic_clear_bit(pd, ICSR2_STOP, RIIC_ICSR2);
 	riic_set_bit(pd, ICCR2_SP, RIIC_ICCR2);

-	pd->msg->buf[index] = riic_read(pd, RIIC_ICDRR);
-	index++;
-	riic_set_receive_ack(pd, 0);
+	pd->msg->buf[pd->index] = riic_read(pd, RIIC_ICDRR);
+	pd->index++;

 force_exit:
+	/* step 8 */
 	ret = riic_wait_for_icsr2(pd, ICSR2_STOP);
 	if (ret < 0)
 		return ret;
@@ -482,14 +605,74 @@ static struct i2c_algorithm riic_algorithm = {
 	.master_xfer	= riic_xfer,
 };

+static irqreturn_t riic_irq(int irq, void *data)
+{
+	struct riic_data *pd = data;
+	irqreturn_t ret = IRQ_NONE;
+
+	pd->icsr2 = riic_read(pd, RIIC_ICSR2);
+
+	if (pd->icsr2 & ICSR2_NACKF) {
+		ret = IRQ_HANDLED;
+		riic_clear_bit(pd, ICIER_NAKIE, RIIC_ICIER);
+		wake_up(&pd->wait);
+	}
+
+	return ret;
+}
+
+static bool riic_filter(struct dma_chan *chan, void *filter_param)
+{
+	chan->private = filter_param;
+
+	return true;
+}
+
+static void riic_request_dma(struct riic_data *pd,
+			     struct riic_platform_data *riic_data)
+{
+	dma_cap_mask_t mask;
+
+	if (riic_data->dma_tx.slave_id) {
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		pd->chan_tx = dma_request_channel(mask, riic_filter,
+						  &riic_data->dma_tx);
+		if (!pd->chan_tx)
+			dev_warn(pd->dev, "dma_request_channel for tx failed."
+						"Then, use PIO.\n");
+	}
+	if (riic_data->dma_rx.slave_id) {
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		pd->chan_rx = dma_request_channel(mask, riic_filter,
+						  &riic_data->dma_rx);
+		if (!pd->chan_rx)
+			dev_warn(pd->dev, "dma_request_channel for rx failed."
+						"Then, use PIO.\n");
+	}
+}
+
+static void riic_release_dma(struct riic_data *pd)
+{
+	if (pd->chan_tx)
+		dma_release_channel(pd->chan_tx);
+	if (pd->chan_rx)
+		dma_release_channel(pd->chan_rx);
+}
+
 static int __devexit riic_remove(struct platform_device *pdev)
 {
 	struct riic_data *pd = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);

 	if (!pd)
 		return 0;

 	i2c_del_adapter(&pd->adap);
+	if (irq >= 0)
+		free_irq(irq, pd);
+	riic_release_dma(pd);
 	iounmap(pd->reg);
 	kfree(pd);

@@ -504,6 +687,7 @@ static int __devinit riic_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	void __iomem *reg = NULL;
 	int ret = 0;
+	int irq;

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -511,6 +695,7 @@ static int __devinit riic_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "platform_get_resource failed.\n");
 		goto clean_up;
 	}
+	irq = platform_get_irq(pdev, 0);

 	if (!pdev->dev.platform_data) {
 		ret = -ENOENT;
@@ -548,22 +733,41 @@ static int __devinit riic_probe(struct platform_device *pdev)

 	strlcpy(adap->name, dev_name(&pdev->dev), sizeof(adap->name));

+	riic_request_dma(pd, riic_data);
+	init_waitqueue_head(&pd->wait);
 	ret = riic_init_setting(pd, riic_data->clock);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "riic_init_setting failed.\n");
 		goto clean_up;
 	}

+	if (irq >= 0) {
+		/* interruption of EEI for DMA */
+		ret = request_irq(irq, riic_irq, 0, dev_name(&pdev->dev), pd);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "request_irq error\n");
+			goto clean_up;
+		}
+	} else if (pd->chan_tx || pd->chan_rx) {
+		dev_err(&pdev->dev, "Interrupt resource needed.\n");
+		goto clean_up;
+	}
+
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "i2c_add_numbered_adapter failed.\n");
-		goto clean_up;
+		goto clean_up2;
 	}

 	dev_info(&pdev->dev, "version %s\n", DRIVER_VERSION);
 	return ret;

+clean_up2:
+	if (irq >= 0)
+		free_irq(irq, pd);
 clean_up:
+	if (pd)
+		riic_release_dma(pd);
 	if (reg)
 		iounmap(reg);
 	kfree(pd);
diff --git a/include/linux/i2c/riic.h b/include/linux/i2c/riic.h
index 5839381..f97b65c 100644
--- a/include/linux/i2c/riic.h
+++ b/include/linux/i2c/riic.h
@@ -21,8 +21,12 @@
 #ifndef _RIIC_H_
 #define _RIIC_H_

+#include <linux/sh_dma.h>
+
 struct riic_platform_data {
 	int	clock;		/* i2c clock (kHZ) */
+	struct sh_dmae_slave dma_tx;
+	struct sh_dmae_slave dma_rx;
 };

 #endif
-- 
1.7.1
