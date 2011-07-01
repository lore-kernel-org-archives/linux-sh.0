From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 01 Jul 2011 01:00:50 +0000
Subject: [PATCH 2/2] i2c: i2c-riic: add dmaengine supporting
Message-Id: <4E0D1C42.2080804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ben-linux@fluff.org
Cc: linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

We can use the dmaengine for the driver, if the dma_tx and/or
dma_rx in riic_platform_data is set. If we use it, we have to set
the irq number for EEI in the resource.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/i2c/busses/i2c-riic.c |  283 ++++++++++++++++++++++++++++++++++------
 include/linux/i2c/riic.h      |    4 +
 2 files changed, 244 insertions(+), 43 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index dcc183b..22dd779 100644
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

 #define DRIVER_VERSION	"2011-07-01"
@@ -199,6 +208,7 @@ static void riic_clear_bit(struct riic_data *pd, unsigned char val,
 	riic_write(pd, tmp, offset);
 }

+
 static void riic_set_clock(struct riic_data *pd, int clock)
 {
 	switch (clock) {
@@ -244,7 +254,8 @@ static void riic_init_setting(struct riic_data *pd, int clock)
 	riic_set_clock(pd, clock);

 	riic_set_bit(pd, ICCR1_ICE, RIIC_ICCR1);
-	riic_set_bit(pd, ICMR3_RDRFS | ICMR3_WAIT | ICMR3_ACKWP, RIIC_ICMR3);
+	riic_set_bit(pd, ICMR3_WAIT | ICMR3_ACKWP, RIIC_ICMR3);
+	riic_set_bit(pd, ICIER_TIE | ICIER_RIE, RIIC_ICIER);
 }

 static int riic_check_busy(struct riic_data *pd)
@@ -304,10 +315,79 @@ static int riic_send_slave_address(struct riic_data *pd, int read)
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
+	if (!pd->dma_callbacked && !ret) {
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
@@ -320,15 +400,12 @@ static int riic_master_transmit(struct riic_data *pd, int stop)
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
@@ -353,12 +430,72 @@ static void riic_set_receive_ack(struct riic_data *pd, int ack)
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
+	if (!pd->dma_callbacked && !ret) {
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
@@ -386,40 +523,26 @@ static int riic_master_receive(struct riic_data *pd, int restart)
 		goto force_exit;
 	}

-	/* receive data */
-	index = 0;
-	while ((pd->msg->len - 1) > index) {
-		ret = riic_wait_for_icsr2(pd, ICSR2_RDRF);
-		if (ret < 0)
-			return ret;
+	/* step 4 */
+	riic_read(pd, RIIC_ICDRR);	/* dummy read */

-		if ((index + 1) >= (pd->msg->len - 1))
-			break;
-
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
@@ -428,11 +551,11 @@ static int riic_master_receive(struct riic_data *pd, int restart)
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
@@ -476,14 +599,68 @@ static struct i2c_algorithm riic_algorithm = {
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
+	}
+	if (riic_data->dma_rx.slave_id) {
+		dma_cap_zero(mask);
+		dma_cap_set(DMA_SLAVE, mask);
+		pd->chan_rx = dma_request_channel(mask, riic_filter,
+						  &riic_data->dma_rx);
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

@@ -498,6 +675,7 @@ static int __devinit riic_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	void __iomem *reg = NULL;
 	int ret = 0;
+	int irq;

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -505,6 +683,7 @@ static int __devinit riic_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "platform_get_resource error.\n");
 		goto clean_up;
 	}
+	irq = platform_get_irq(pdev, 0);

 	if (!pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "no platform data\n");
@@ -541,18 +720,36 @@ static int __devinit riic_probe(struct platform_device *pdev)

 	strlcpy(adap->name, pdev->name, sizeof(adap->name));

+	riic_request_dma(pd, riic_data);
+	init_waitqueue_head(&pd->wait);
 	riic_init_setting(pd, riic_data->clock);
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

 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "i2c_add_numbered_adapter error.\n");
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

