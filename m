From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 12 Mar 2015 06:35:20 +0000
Subject: [PATCH v3 3/3] usb: renesas_usbhs: add support for USB-DMAC
Message-Id: <1426142120-5072-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426142120-5072-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1426142120-5072-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, balbi@ti.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Some Renesas SoCs have the USB-DMAC. It is able to terminate transfers
when a short packet is received, even if less bytes than the transfer
counter size have been received. Also, it is able to send a short
packet even if the packet size is not multiples of 8bytes.

Since the previous code has used the interruption of USBHS controller
when receiving packets even if this driver has used a dmac, a lot of
interruptions has happened. This patch will reduce such interruptions.

This patch allows to use the USB-DMAC on R-Car H2 and M2.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/common.c |  19 +++++
 drivers/usb/renesas_usbhs/common.h |   7 ++
 drivers/usb/renesas_usbhs/fifo.c   | 165 +++++++++++++++++++++++++++++++++++--
 drivers/usb/renesas_usbhs/fifo.h   |   1 +
 drivers/usb/renesas_usbhs/pipe.c   |  39 +++++++++
 drivers/usb/renesas_usbhs/pipe.h   |   1 +
 include/linux/usb/renesas_usbhs.h  |   2 +
 7 files changed, 228 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 4cf77d3..0f7e850 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -276,6 +276,16 @@ int usbhs_set_device_config(struct usbhs_priv *priv, int devnum,
 }
 
 /*
+ *		interrupt functions
+ */
+void usbhs_xxxsts_clear(struct usbhs_priv *priv, u16 sts_reg, u16 bit)
+{
+	u16 pipe_mask = (u16)GENMASK(usbhs_get_dparam(priv, pipe_size), 0);
+
+	usbhs_write(priv, sts_reg, ~(1 << bit) & pipe_mask);
+}
+
+/*
  *		local functions
  */
 static void usbhsc_set_buswait(struct usbhs_priv *priv)
@@ -487,6 +497,15 @@ static struct renesas_usbhs_platform_info *usbhs_parse_dt(struct device *dev)
 	if (gpio > 0)
 		dparam->enable_gpio = gpio;
 
+	switch (dparam->type) {
+	case USBHS_TYPE_R8A7790:
+	case USBHS_TYPE_R8A7791:
+		dparam->has_usb_dmac = 1;
+		break;
+	default:
+		break;
+	}
+
 	return info;
 }
 
diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
index fc96e92..8c5fc12 100644
--- a/drivers/usb/renesas_usbhs/common.h
+++ b/drivers/usb/renesas_usbhs/common.h
@@ -193,6 +193,7 @@ struct usbhs_priv;
 #define TYPE_BULK	(1 << 14)
 #define TYPE_INT	(2 << 14)
 #define TYPE_ISO	(3 << 14)
+#define BFRE		(1 << 10)	/* BRDY Interrupt Operation Spec. */
 #define DBLB		(1 << 9)	/* Double Buffer Mode */
 #define SHTNAK		(1 << 7)	/* Pipe Disable in Transfer End */
 #define DIR_OUT		(1 << 4)	/* Transfer Direction */
@@ -216,6 +217,7 @@ struct usbhs_priv;
 #define	ACLRM		(1 << 9)	/* Buffer Auto-Clear Mode */
 #define SQCLR		(1 << 8)	/* Toggle Bit Clear */
 #define SQSET		(1 << 7)	/* Toggle Bit Set */
+#define SQMON		(1 << 6)	/* Toggle Bit Check */
 #define PBUSY		(1 << 5)	/* Pipe Busy */
 #define PID_MASK	(0x3)		/* Response PID */
 #define  PID_NAK	0
@@ -324,6 +326,11 @@ int usbhs_set_device_config(struct usbhs_priv *priv, int devnum, u16 upphub,
 			   u16 hubport, u16 speed);
 
 /*
+ * interrupt functions
+ */
+void usbhs_xxxsts_clear(struct usbhs_priv *priv, u16 sts_reg, u16 bit);
+
+/*
  * data
  */
 struct usbhs_priv *usbhs_pdev_to_priv(struct platform_device *pdev);
diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index b737661..8597cf9 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -813,7 +813,8 @@ static void xfer_work(struct work_struct *work)
 	desc->callback		= usbhsf_dma_complete;
 	desc->callback_param	= pipe;
 
-	if (dmaengine_submit(desc) < 0) {
+	pkt->cookie = dmaengine_submit(desc);
+	if (pkt->cookie < 0) {
 		dev_err(dev, "Failed to submit dma descriptor\n");
 		return;
 	}
@@ -838,6 +839,7 @@ static int usbhsf_dma_prepare_push(struct usbhs_pkt *pkt, int *is_done)
 	struct usbhs_fifo *fifo;
 	int len = pkt->length - pkt->actual;
 	int ret;
+	uintptr_t align_mask;
 
 	if (usbhs_pipe_is_busy(pipe))
 		return 0;
@@ -847,10 +849,14 @@ static int usbhsf_dma_prepare_push(struct usbhs_pkt *pkt, int *is_done)
 	    usbhs_pipe_is_dcp(pipe))
 		goto usbhsf_pio_prepare_push;
 
-	if (len & 0x7) /* 8byte alignment */
+	/* check data length if this driver don't use USB-DMAC */
+	if (!usbhs_get_dparam(priv, has_usb_dmac) && len & 0x7)
 		goto usbhsf_pio_prepare_push;
 
-	if ((uintptr_t)(pkt->buf + pkt->actual) & 0x7) /* 8byte alignment */
+	/* check buffer alignment */
+	align_mask = usbhs_get_dparam(priv, has_usb_dmac) ?
+					USBHS_USB_DMAC_XFER_SIZE - 1 : 0x7;
+	if ((uintptr_t)(pkt->buf + pkt->actual) & align_mask)
 		goto usbhsf_pio_prepare_push;
 
 	/* return at this time if the pipe is running */
@@ -924,7 +930,85 @@ struct usbhs_pkt_handle usbhs_fifo_dma_push_handler = {
 /*
  *		DMA pop handler
  */
-static int usbhsf_dma_try_pop(struct usbhs_pkt *pkt, int *is_done)
+
+static int usbhsf_dma_prepare_pop_with_rx_irq(struct usbhs_pkt *pkt,
+					      int *is_done)
+{
+	return usbhsf_prepare_pop(pkt, is_done);
+}
+
+static int usbhsf_dma_prepare_pop_with_usb_dmac(struct usbhs_pkt *pkt,
+						int *is_done)
+{
+	struct usbhs_pipe *pipe = pkt->pipe;
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
+	struct usbhs_fifo *fifo;
+	int ret;
+
+	if (usbhs_pipe_is_busy(pipe))
+		return 0;
+
+	/* use PIO if packet is less than pio_dma_border or pipe is DCP */
+	if ((pkt->length < usbhs_get_dparam(priv, pio_dma_border)) ||
+	    usbhs_pipe_is_dcp(pipe))
+		goto usbhsf_pio_prepare_pop;
+
+	fifo = usbhsf_get_dma_fifo(priv, pkt);
+	if (!fifo)
+		goto usbhsf_pio_prepare_pop;
+
+	if ((uintptr_t)pkt->buf & (USBHS_USB_DMAC_XFER_SIZE - 1))
+		goto usbhsf_pio_prepare_pop;
+
+	usbhs_pipe_config_change_bfre(pipe, 1);
+
+	ret = usbhsf_fifo_select(pipe, fifo, 0);
+	if (ret < 0)
+		goto usbhsf_pio_prepare_pop;
+
+	if (usbhsf_dma_map(pkt) < 0)
+		goto usbhsf_pio_prepare_pop_unselect;
+
+	/* DMA */
+
+	/*
+	 * usbhs_fifo_dma_pop_handler :: prepare
+	 * enabled irq to come here.
+	 * but it is no longer needed for DMA. disable it.
+	 */
+	usbhsf_rx_irq_ctrl(pipe, 0);
+
+	pkt->trans = pkt->length;
+
+	INIT_WORK(&pkt->work, xfer_work);
+	schedule_work(&pkt->work);
+
+	return 0;
+
+usbhsf_pio_prepare_pop_unselect:
+	usbhsf_fifo_unselect(pipe, fifo);
+usbhsf_pio_prepare_pop:
+
+	/*
+	 * change handler to PIO
+	 */
+	pkt->handler = &usbhs_fifo_pio_pop_handler;
+	usbhs_pipe_config_change_bfre(pipe, 0);
+
+	return pkt->handler->prepare(pkt, is_done);
+}
+
+static int usbhsf_dma_prepare_pop(struct usbhs_pkt *pkt, int *is_done)
+{
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pkt->pipe);
+
+	if (usbhs_get_dparam(priv, has_usb_dmac))
+		return usbhsf_dma_prepare_pop_with_usb_dmac(pkt, is_done);
+	else
+		return usbhsf_dma_prepare_pop_with_rx_irq(pkt, is_done);
+}
+
+static int usbhsf_dma_try_pop_with_rx_irq(struct usbhs_pkt *pkt, int *is_done)
 {
 	struct usbhs_pipe *pipe = pkt->pipe;
 	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
@@ -993,7 +1077,16 @@ usbhsf_pio_prepare_pop:
 	return pkt->handler->try_run(pkt, is_done);
 }
 
-static int usbhsf_dma_pop_done(struct usbhs_pkt *pkt, int *is_done)
+static int usbhsf_dma_try_pop(struct usbhs_pkt *pkt, int *is_done)
+{
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pkt->pipe);
+
+	BUG_ON(usbhs_get_dparam(priv, has_usb_dmac));
+
+	return usbhsf_dma_try_pop_with_rx_irq(pkt, is_done);
+}
+
+static int usbhsf_dma_pop_done_with_rx_irq(struct usbhs_pkt *pkt, int *is_done)
 {
 	struct usbhs_pipe *pipe = pkt->pipe;
 	int maxp = usbhs_pipe_get_maxpacket(pipe);
@@ -1017,8 +1110,68 @@ static int usbhsf_dma_pop_done(struct usbhs_pkt *pkt, int *is_done)
 	return 0;
 }
 
+static size_t usbhs_dma_calc_received_size(struct usbhs_pkt *pkt,
+					   struct dma_chan *chan, int dtln)
+{
+	struct usbhs_pipe *pipe = pkt->pipe;
+	struct dma_tx_state state;
+	size_t received_size;
+	int maxp = usbhs_pipe_get_maxpacket(pipe);
+
+	dmaengine_tx_status(chan, pkt->cookie, &state);
+	received_size = pkt->length - state.residue;
+
+	if (dtln) {
+		received_size -= USBHS_USB_DMAC_XFER_SIZE;
+		received_size &= ~(maxp - 1);
+		received_size += dtln;
+	}
+
+	return received_size;
+}
+
+static int usbhsf_dma_pop_done_with_usb_dmac(struct usbhs_pkt *pkt,
+					     int *is_done)
+{
+	struct usbhs_pipe *pipe = pkt->pipe;
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
+	struct usbhs_fifo *fifo = usbhs_pipe_to_fifo(pipe);
+	struct dma_chan *chan = usbhsf_dma_chan_get(fifo, pkt);
+	int rcv_len;
+
+	/*
+	 * Since the driver disables rx_irq in DMA mode, the interrupt handler
+	 * cannot the BRDYSTS. So, the function clears it here because the
+	 * driver may use PIO mode next time.
+	 */
+	usbhs_xxxsts_clear(priv, BRDYSTS, usbhs_pipe_number(pipe));
+
+	rcv_len = usbhsf_fifo_rcv_len(priv, fifo);
+	usbhsf_fifo_clear(pipe, fifo);
+	pkt->actual = usbhs_dma_calc_received_size(pkt, chan, rcv_len);
+
+	usbhsf_dma_stop(pipe, fifo);
+	usbhsf_dma_unmap(pkt);
+	usbhsf_fifo_unselect(pipe, pipe->fifo);
+
+	/* The driver can assume the rx transaction is always "done" */
+	*is_done = 1;
+
+	return 0;
+}
+
+static int usbhsf_dma_pop_done(struct usbhs_pkt *pkt, int *is_done)
+{
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pkt->pipe);
+
+	if (usbhs_get_dparam(priv, has_usb_dmac))
+		return usbhsf_dma_pop_done_with_usb_dmac(pkt, is_done);
+	else
+		return usbhsf_dma_pop_done_with_rx_irq(pkt, is_done);
+}
+
 struct usbhs_pkt_handle usbhs_fifo_dma_pop_handler = {
-	.prepare	= usbhsf_prepare_pop,
+	.prepare	= usbhsf_dma_prepare_pop,
 	.try_run	= usbhsf_dma_try_pop,
 	.dma_done	= usbhsf_dma_pop_done
 };
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index f07037c1..04d3f8a 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -58,6 +58,7 @@ struct usbhs_pkt {
 		     struct usbhs_pkt *pkt);
 	struct work_struct work;
 	dma_addr_t dma;
+	dma_cookie_t cookie;
 	void *buf;
 	int length;
 	int trans;
diff --git a/drivers/usb/renesas_usbhs/pipe.c b/drivers/usb/renesas_usbhs/pipe.c
index 007f45a..4f9c335 100644
--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -84,6 +84,17 @@ static void __usbhsp_pipe_xxx_set(struct usbhs_pipe *pipe,
 		usbhs_bset(priv, pipe_reg, mask, val);
 }
 
+static u16 __usbhsp_pipe_xxx_get(struct usbhs_pipe *pipe,
+				 u16 dcp_reg, u16 pipe_reg)
+{
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
+
+	if (usbhs_pipe_is_dcp(pipe))
+		return usbhs_read(priv, dcp_reg);
+	else
+		return usbhs_read(priv, pipe_reg);
+}
+
 /*
  *		DCPCFG/PIPECFG functions
  */
@@ -92,6 +103,11 @@ static void usbhsp_pipe_cfg_set(struct usbhs_pipe *pipe, u16 mask, u16 val)
 	__usbhsp_pipe_xxx_set(pipe, DCPCFG, PIPECFG, mask, val);
 }
 
+static u16 usbhsp_pipe_cfg_get(struct usbhs_pipe *pipe)
+{
+	return __usbhsp_pipe_xxx_get(pipe, DCPCFG, PIPECFG);
+}
+
 /*
  *		PIPEnTRN/PIPEnTRE functions
  */
@@ -616,6 +632,11 @@ void usbhs_pipe_data_sequence(struct usbhs_pipe *pipe, int sequence)
 	usbhsp_pipectrl_set(pipe, mask, val);
 }
 
+static int usbhs_pipe_get_data_sequence(struct usbhs_pipe *pipe)
+{
+	return !!(usbhsp_pipectrl_get(pipe) & SQMON);
+}
+
 void usbhs_pipe_clear(struct usbhs_pipe *pipe)
 {
 	if (usbhs_pipe_is_dcp(pipe)) {
@@ -626,6 +647,24 @@ void usbhs_pipe_clear(struct usbhs_pipe *pipe)
 	}
 }
 
+void usbhs_pipe_config_change_bfre(struct usbhs_pipe *pipe, int enable)
+{
+	int sequence;
+
+	if (usbhs_pipe_is_dcp(pipe))
+		return;
+
+	usbhsp_pipe_select(pipe);
+	/* check if the driver needs to change the BFRE value */
+	if (!(enable ^ !!(usbhsp_pipe_cfg_get(pipe) & BFRE)))
+		return;
+
+	sequence = usbhs_pipe_get_data_sequence(pipe);
+	usbhsp_pipe_cfg_set(pipe, BFRE, enable ? BFRE : 0);
+	usbhs_pipe_clear(pipe);
+	usbhs_pipe_data_sequence(pipe, sequence);
+}
+
 static struct usbhs_pipe *usbhsp_get_pipe(struct usbhs_priv *priv, u32 type)
 {
 	struct usbhs_pipe *pos, *pipe;
diff --git a/drivers/usb/renesas_usbhs/pipe.h b/drivers/usb/renesas_usbhs/pipe.h
index d24a059..b0bc7b6 100644
--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -97,6 +97,7 @@ void usbhs_pipe_set_trans_count_if_bulk(struct usbhs_pipe *pipe, int len);
 void usbhs_pipe_select_fifo(struct usbhs_pipe *pipe, struct usbhs_fifo *fifo);
 void usbhs_pipe_config_update(struct usbhs_pipe *pipe, u16 devsel,
 			      u16 epnum, u16 maxp);
+void usbhs_pipe_config_change_bfre(struct usbhs_pipe *pipe, int enable);
 
 #define usbhs_pipe_sequence_data0(pipe)	usbhs_pipe_data_sequence(pipe, 0)
 #define usbhs_pipe_sequence_data1(pipe)	usbhs_pipe_data_sequence(pipe, 1)
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index 9fd9e48..f06529c 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -165,6 +165,8 @@ struct renesas_usbhs_driver_param {
 	 */
 	u32 has_otg:1; /* for controlling PWEN/EXTLP */
 	u32 has_sudmac:1; /* for SUDMAC */
+	u32 has_usb_dmac:1; /* for USB-DMAC */
+#define USBHS_USB_DMAC_XFER_SIZE	32	/* hardcode the xfer size */
 };
 
 #define USBHS_TYPE_R8A7790 1
-- 
1.9.1

