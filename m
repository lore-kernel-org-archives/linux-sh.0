From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 26 Sep 2011 08:43:02 +0000
Subject: [PATCH 2/2] usb: r8a66597-udc: add support for SUDMAC
Message-Id: <4E803B16.1090905@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7757 has a USB function with internal DMA controller (SUDMAC).
This patch supports the SUDMAC. The SUDMAC is incompatible with
general-purpose DMAC. So, it doesn't use dmaengine.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/gadget/r8a66597-udc.c |  359 +++++++++++++++++++++++++++++++++++--
 drivers/usb/gadget/r8a66597-udc.h |   26 +++-
 include/linux/usb/r8a66597.h      |   60 ++++++
 3 files changed, 425 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index cd2cd16..4d27cb3 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -28,13 +28,14 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/dma-mapping.h>

 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>

 #include "r8a66597-udc.h"

-#define DRIVER_VERSION	"2009-08-18"
+#define DRIVER_VERSION	"2011-09-26"

 static const char udc_name[] = "r8a66597_udc";
 static const char *r8a66597_ep_name[] = {
@@ -186,6 +187,51 @@ static inline void control_reg_sqclr(struct r8a66597 *r8a66597, u16 pipenum)
 		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
 }

+static void control_reg_sqset(struct r8a66597 *r8a66597, u16 pipenum)
+{
+	unsigned long offset;
+
+	pipe_stop(r8a66597, pipenum);
+
+	if (pipenum = 0)
+		r8a66597_bset(r8a66597, SQSET, DCPCTR);
+	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
+		offset = get_pipectr_addr(pipenum);
+		r8a66597_bset(r8a66597, SQSET, offset);
+	} else
+		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
+}
+
+
+static u16 control_reg_sqmon(struct r8a66597 *r8a66597, u16 pipenum)
+{
+	unsigned long offset;
+
+	if (pipenum = 0)
+		return r8a66597_read(r8a66597, DCPCTR) & SQMON;
+	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
+		offset = get_pipectr_addr(pipenum);
+		return r8a66597_read(r8a66597, offset) & SQMON;
+	} else
+		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
+
+	return 0;
+}
+
+static u16 save_usb_toggle(struct r8a66597 *r8a66597, u16 pipenum)
+{
+	return control_reg_sqmon(r8a66597, pipenum);
+}
+
+static void restore_usb_toggle(struct r8a66597 *r8a66597, u16 pipenum,
+			       u16 toggle)
+{
+	if (toggle)
+		control_reg_sqset(r8a66597, pipenum);
+	else
+		control_reg_sqclr(r8a66597, pipenum);
+}
+
 static inline int get_buffer_size(struct r8a66597 *r8a66597, u16 pipenum)
 {
 	u16 tmp;
@@ -222,18 +268,50 @@ static inline unsigned short mbw_value(struct r8a66597 *r8a66597)
 		return MBW_16;
 }

+static void r8a66597_change_curpipe(struct r8a66597 *r8a66597, u16 pipenum,
+				    u16 isel, u16 fifosel)
+{
+	u16 tmp, mask, loop;
+	int i = 0;
+
+	if (!pipenum) {
+		mask = ISEL | CURPIPE;
+		loop = isel;
+	} else {
+		mask = CURPIPE;
+		loop = pipenum;
+	}
+	r8a66597_mdfy(r8a66597, loop, mask, fifosel);
+
+	do {
+		tmp = r8a66597_read(r8a66597, fifosel);
+		if (i++ > 1000000) {
+			printk(KERN_ERR "r8a66597: register%x, loop %x "
+			       "is timeout\n", fifosel, loop);
+			break;
+		}
+		ndelay(1);
+	} while ((tmp & mask) != loop);
+}
+
 static inline void pipe_change(struct r8a66597 *r8a66597, u16 pipenum)
 {
 	struct r8a66597_ep *ep = r8a66597->pipenum2ep[pipenum];

 	if (ep->use_dma)
-		return;
+		r8a66597_bclr(r8a66597, DREQE, ep->fifosel);

 	r8a66597_mdfy(r8a66597, pipenum, CURPIPE, ep->fifosel);

 	ndelay(450);

-	r8a66597_bset(r8a66597, mbw_value(r8a66597), ep->fifosel);
+	if (r8a66597_is_sudmac(r8a66597) && ep->use_dma)
+		r8a66597_bclr(r8a66597, mbw_value(r8a66597), ep->fifosel);
+	else
+		r8a66597_bset(r8a66597, mbw_value(r8a66597), ep->fifosel);
+
+	if (ep->use_dma)
+		r8a66597_bset(r8a66597, DREQE, ep->fifosel);
 }

 static int pipe_buffer_setting(struct r8a66597 *r8a66597,
@@ -337,9 +415,15 @@ static void r8a66597_ep_setting(struct r8a66597 *r8a66597,
 	ep->fifoaddr = CFIFO;
 	ep->fifosel = CFIFOSEL;
 	ep->fifoctr = CFIFOCTR;
-	ep->fifotrn = 0;

 	ep->pipectr = get_pipectr_addr(pipenum);
+	if (is_bulk_pipe(pipenum) || is_isoc_pipe(pipenum)) {
+		ep->pipetre = get_pipetre_addr(pipenum);
+		ep->pipetrn = get_pipetrn_addr(pipenum);
+	} else {
+		ep->pipetre = 0;
+		ep->pipetrn = 0;
+	}
 	ep->pipenum = pipenum;
 	ep->ep.maxpacket = le16_to_cpu(desc->wMaxPacketSize);
 	r8a66597->pipenum2ep[pipenum] = ep;
@@ -495,6 +579,124 @@ static void start_ep0_write(struct r8a66597_ep *ep,
 	}
 }

+static void disable_fifosel(struct r8a66597 *r8a66597, u16 pipenum,
+			    u16 fifosel)
+{
+	u16 tmp;
+
+	tmp = r8a66597_read(r8a66597, fifosel) & CURPIPE;
+	if (tmp = pipenum)
+		r8a66597_change_curpipe(r8a66597, 0, 0, fifosel);
+}
+
+static void change_bfre_mode(struct r8a66597 *r8a66597, u16 pipenum,
+			     int enable)
+{
+	struct r8a66597_ep *ep = r8a66597->pipenum2ep[pipenum];
+	u16 tmp, toggle;
+
+	/* check current BFRE bit */
+	r8a66597_write(r8a66597, pipenum, PIPESEL);
+	tmp = r8a66597_read(r8a66597, PIPECFG) & R8A66597_BFRE;
+	if ((enable && tmp) || (!enable && !tmp))
+		return;
+
+	/* change BFRE bit */
+	pipe_stop(r8a66597, pipenum);
+	disable_fifosel(r8a66597, pipenum, CFIFOSEL);
+	disable_fifosel(r8a66597, pipenum, D0FIFOSEL);
+	disable_fifosel(r8a66597, pipenum, D1FIFOSEL);
+
+	toggle = save_usb_toggle(r8a66597, pipenum);
+
+	r8a66597_write(r8a66597, pipenum, PIPESEL);
+	if (enable)
+		r8a66597_bset(r8a66597, R8A66597_BFRE, PIPECFG);
+	else
+		r8a66597_bclr(r8a66597, R8A66597_BFRE, PIPECFG);
+
+	/* initialize for internal BFRE flag */
+	r8a66597_bset(r8a66597, ACLRM, ep->pipectr);
+	r8a66597_bclr(r8a66597, ACLRM, ep->pipectr);
+
+	restore_usb_toggle(r8a66597, pipenum, toggle);
+}
+
+static int sudmac_alloc_channel(struct r8a66597 *r8a66597,
+				struct r8a66597_ep *ep,
+				struct r8a66597_request *req)
+{
+	struct r8a66597_dma *dma;
+
+	if (!r8a66597_is_sudmac(r8a66597))
+		return -ENODEV;
+
+	/* Check transfer type */
+	if (!is_bulk_pipe(ep->pipenum))
+		return -EIO;
+
+	if (r8a66597->dma.used)
+		return -EBUSY;
+
+	/* set SUDMAC parameters */
+	dma = &r8a66597->dma;
+	dma->used = 1;
+	if (ep->desc->bEndpointAddress & USB_DIR_IN) {
+		dma->dir = 1;
+	} else {
+		dma->dir = 0;
+		change_bfre_mode(r8a66597, ep->pipenum, 1);
+	}
+
+	/* set r8a66597_ep paramters */
+	ep->use_dma = 1;
+	ep->dma = dma;
+	ep->fifoaddr = D0FIFO;
+	ep->fifosel = D0FIFOSEL;
+	ep->fifoctr = D0FIFOCTR;
+
+	/* dma mapping */
+	req->req.dma = dma_map_single(ep->r8a66597->gadget.dev.parent,
+				req->req.buf, req->req.length,
+				dma->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	return 0;
+}
+
+static void sudmac_free_channel(struct r8a66597 *r8a66597,
+				struct r8a66597_ep *ep,
+				struct r8a66597_request *req)
+{
+	if (!r8a66597_is_sudmac(r8a66597))
+		return;
+
+	dma_unmap_single(ep->r8a66597->gadget.dev.parent,
+			 req->req.dma, req->req.length,
+			 ep->dma->dir ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+
+	r8a66597_bclr(r8a66597, DREQE, ep->fifosel);
+	r8a66597_change_curpipe(r8a66597, 0, 0, ep->fifosel);
+
+	ep->dma->used = 0;
+	ep->use_dma = 0;
+	ep->fifoaddr = CFIFO;
+	ep->fifosel = CFIFOSEL;
+	ep->fifoctr = CFIFOCTR;
+}
+
+static void sudmac_start(struct r8a66597 *r8a66597, struct r8a66597_ep *ep,
+			 struct r8a66597_request *req)
+{
+	BUG_ON(req->req.length = 0);
+
+	r8a66597_sudmac_write(r8a66597, LBA_WAIT, CH0CFG);
+	r8a66597_sudmac_write(r8a66597, req->req.dma, CH0BA);
+	r8a66597_sudmac_write(r8a66597, req->req.length, CH0BBC);
+	r8a66597_sudmac_write(r8a66597, CH0ENDE, DINTCTRL);
+
+	r8a66597_sudmac_write(r8a66597, DEN, CH0DEN);
+}
+
 static void start_packet_write(struct r8a66597_ep *ep,
 				struct r8a66597_request *req)
 {
@@ -505,11 +707,29 @@ static void start_packet_write(struct r8a66597_ep *ep,
 	disable_irq_empty(r8a66597, ep->pipenum);
 	pipe_start(r8a66597, ep->pipenum);

-	tmp = r8a66597_read(r8a66597, ep->fifoctr);
-	if (unlikely((tmp & FRDY) = 0))
-		pipe_irq_enable(r8a66597, ep->pipenum);
-	else
-		irq_packet_write(ep, req);
+	if (req->req.length = 0) {
+		transfer_complete(ep, req, 0);
+	} else {
+		r8a66597_write(r8a66597, ~(1 << ep->pipenum), BRDYSTS);
+		if (sudmac_alloc_channel(r8a66597, ep, req) < 0) {
+			/* PIO mode */
+			pipe_change(r8a66597, ep->pipenum);
+			disable_irq_empty(r8a66597, ep->pipenum);
+			pipe_start(r8a66597, ep->pipenum);
+			tmp = r8a66597_read(r8a66597, ep->fifoctr);
+			if (unlikely((tmp & FRDY) = 0))
+				pipe_irq_enable(r8a66597, ep->pipenum);
+			else
+				irq_packet_write(ep, req);
+		} else {
+			/* DMA mode */
+			pipe_change(r8a66597, ep->pipenum);
+			disable_irq_nrdy(r8a66597, ep->pipenum);
+			pipe_start(r8a66597, ep->pipenum);
+			enable_irq_nrdy(r8a66597, ep->pipenum);
+			sudmac_start(r8a66597, ep, req);
+		}
+	}
 }

 static void start_packet_read(struct r8a66597_ep *ep,
@@ -524,17 +744,26 @@ static void start_packet_read(struct r8a66597_ep *ep,
 		pipe_start(r8a66597, pipenum);
 		pipe_irq_enable(r8a66597, pipenum);
 	} else {
-		if (ep->use_dma) {
-			r8a66597_bset(r8a66597, TRCLR, ep->fifosel);
-			pipe_change(r8a66597, pipenum);
-			r8a66597_bset(r8a66597, TRENB, ep->fifosel);
+		pipe_stop(r8a66597, pipenum);
+		if (ep->pipetre) {
+			enable_irq_nrdy(r8a66597, pipenum);
+			r8a66597_write(r8a66597, TRCLR, ep->pipetre);
 			r8a66597_write(r8a66597,
-				(req->req.length + ep->ep.maxpacket - 1)
-					/ ep->ep.maxpacket,
-				ep->fifotrn);
+				DIV_ROUND_UP(req->req.length, ep->ep.maxpacket),
+				ep->pipetrn);
+			r8a66597_bset(r8a66597, TRENB, ep->pipetre);
+		}
+
+		if (sudmac_alloc_channel(r8a66597, ep, req) < 0) {
+			/* PIO mode */
+			change_bfre_mode(r8a66597, ep->pipenum, 0);
+			pipe_start(r8a66597, pipenum);	/* trigger once */
+			pipe_irq_enable(r8a66597, pipenum);
+		} else {
+			pipe_change(r8a66597, pipenum);
+			sudmac_start(r8a66597, ep, req);
+			pipe_start(r8a66597, pipenum);	/* trigger once */
 		}
-		pipe_start(r8a66597, pipenum);	/* trigger once */
-		pipe_irq_enable(r8a66597, pipenum);
 	}
 }

@@ -690,6 +919,9 @@ __acquires(r8a66597->lock)
 	if (!list_empty(&ep->queue))
 		restart = 1;

+	if (ep->use_dma)
+		sudmac_free_channel(ep->r8a66597, ep, req);
+
 	spin_unlock(&ep->r8a66597->lock);
 	req->req.complete(&ep->ep, &req->req);
 	spin_lock(&ep->r8a66597->lock);
@@ -1163,6 +1395,64 @@ __acquires(r8a66597->lock)
 	}
 }

+static void sudmac_finish(struct r8a66597 *r8a66597, struct r8a66597_ep *ep)
+{
+	u16 pipenum;
+	struct r8a66597_request *req;
+	u32 len;
+	int i = 0;
+
+	pipenum = ep->pipenum;
+	pipe_change(r8a66597, pipenum);
+
+	while (!(r8a66597_read(r8a66597, ep->fifoctr) & FRDY)) {
+		udelay(1);
+		if (unlikely(i++ >= 10000)) {	/* timeout = 10 msec */
+			printk(KERN_ERR "%s: FRDY was not set (%d)\n",
+				__func__, pipenum);
+			return;
+		}
+	}
+
+	r8a66597_bset(r8a66597, BCLR, ep->fifoctr);
+	req = get_request_from_ep(ep);
+
+	/* prepare parameters */
+	len = r8a66597_sudmac_read(r8a66597, CH0CBC);
+	req->req.actual += len;
+
+	/* clear */
+	r8a66597_sudmac_write(r8a66597, CH0STCLR, DSTSCLR);
+
+	/* check transfer finish */
+	if ((!req->req.zero && (req->req.actual = req->req.length))
+			|| (len % ep->ep.maxpacket)) {
+		if (ep->dma->dir) {
+			disable_irq_ready(r8a66597, pipenum);
+			enable_irq_empty(r8a66597, pipenum);
+		} else {
+			/* Clear the interrupt flag for next transfer */
+			r8a66597_write(r8a66597, ~(1 << pipenum), BRDYSTS);
+			transfer_complete(ep, req, 0);
+		}
+	}
+}
+
+static void r8a66597_sudmac_irq(struct r8a66597 *r8a66597)
+{
+	u32 irqsts;
+	struct r8a66597_ep *ep;
+	u16 pipenum;
+
+	irqsts = r8a66597_sudmac_read(r8a66597, DINTSTS);
+	if (irqsts & CH0ENDS) {
+		r8a66597_sudmac_write(r8a66597, CH0ENDC, DINTSTSCLR);
+		pipenum = (r8a66597_read(r8a66597, D0FIFOSEL) & CURPIPE);
+		ep = r8a66597->pipenum2ep[pipenum];
+		sudmac_finish(r8a66597, ep);
+	}
+}
+
 static irqreturn_t r8a66597_irq(int irq, void *_r8a66597)
 {
 	struct r8a66597 *r8a66597 = _r8a66597;
@@ -1173,6 +1463,9 @@ static irqreturn_t r8a66597_irq(int irq, void *_r8a66597)
 	u16 savepipe;
 	u16 mask0;

+	if (r8a66597_is_sudmac(r8a66597))
+		r8a66597_sudmac_irq(r8a66597);
+
 	spin_lock(&r8a66597->lock);

 	intsts0 = r8a66597_read(r8a66597, INTSTS0);
@@ -1547,6 +1840,8 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 	usb_del_gadget_udc(&r8a66597->gadget);
 	del_timer_sync(&r8a66597->timer);
 	iounmap(r8a66597->reg);
+	if (r8a66597->pdata->sudmac)
+		iounmap(r8a66597->sudmac_reg);
 	free_irq(platform_get_irq(pdev, 0), r8a66597);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 #ifdef CONFIG_HAVE_CLK
@@ -1563,6 +1858,26 @@ static void nop_completion(struct usb_ep *ep, struct usb_request *r)
 {
 }

+static int __init r8a66597_sudmac_ioremap(struct r8a66597 *r8a66597,
+					  struct platform_device *pdev)
+{
+	struct resource *res;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sudmac");
+	if (!res) {
+		dev_err(&pdev->dev, "platform_get_resource error(sudmac).\n");
+		return -ENODEV;
+	}
+
+	r8a66597->sudmac_reg = ioremap(res->start, resource_size(res));
+	if (r8a66597->sudmac_reg = NULL) {
+		dev_err(&pdev->dev, "ioremap error(sudmac).\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int __init r8a66597_probe(struct platform_device *pdev)
 {
 #ifdef CONFIG_HAVE_CLK
@@ -1640,6 +1955,11 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 		clk_enable(r8a66597->clk);
 	}
 #endif
+	if (r8a66597->pdata->sudmac) {
+		ret = r8a66597_sudmac_ioremap(r8a66597, pdev);
+		if (ret < 0)
+			goto clean_up2;
+	}

 	disable_controller(r8a66597); /* make sure controller is disabled */

@@ -1672,7 +1992,6 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	r8a66597->ep[0].fifoaddr = CFIFO;
 	r8a66597->ep[0].fifosel = CFIFOSEL;
 	r8a66597->ep[0].fifoctr = CFIFOCTR;
-	r8a66597->ep[0].fifotrn = 0;
 	r8a66597->ep[0].pipectr = get_pipectr_addr(0);
 	r8a66597->pipenum2ep[0] = &r8a66597->ep[0];
 	r8a66597->epaddr2ep[0] = &r8a66597->ep[0];
@@ -1705,6 +2024,8 @@ clean_up2:
 #endif
 clean_up:
 	if (r8a66597) {
+		if (r8a66597->sudmac_reg)
+			iounmap(r8a66597->sudmac_reg);
 		if (r8a66597->ep0_req)
 			r8a66597_free_request(&r8a66597->ep[0].ep,
 						r8a66597->ep0_req);
diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index 37d0dd5..93376f7 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -53,6 +53,7 @@
 	((pipenum >= R8A66597_BASE_PIPENUM_ISOC) && \
 	 (pipenum < (R8A66597_BASE_PIPENUM_ISOC + R8A66597_MAX_NUM_ISOC)))

+#define r8a66597_is_sudmac(r8a66597)	(r8a66597->pdata->sudmac)
 struct r8a66597_pipe_info {
 	u16	pipe;
 	u16	epnum;
@@ -70,6 +71,7 @@ struct r8a66597_request {
 struct r8a66597_ep {
 	struct usb_ep		ep;
 	struct r8a66597		*r8a66597;
+	struct r8a66597_dma	*dma;

 	struct list_head	queue;
 	unsigned		busy:1;
@@ -85,13 +87,20 @@ struct r8a66597_ep {
 	unsigned char		fifoaddr;
 	unsigned char		fifosel;
 	unsigned char		fifoctr;
-	unsigned char		fifotrn;
 	unsigned char		pipectr;
+	unsigned char		pipetre;
+	unsigned char		pipetrn;
+};
+
+struct r8a66597_dma {
+	unsigned		used:1;
+	unsigned		dir:1;	/* 1 = IN(write), 0 = OUT(read) */
 };

 struct r8a66597 {
 	spinlock_t		lock;
 	void __iomem		*reg;
+	void __iomem		*sudmac_reg;

 #ifdef CONFIG_HAVE_CLK
 	struct clk *clk;
@@ -104,6 +113,7 @@ struct r8a66597 {
 	struct r8a66597_ep	ep[R8A66597_MAX_NUM_PIPE];
 	struct r8a66597_ep	*pipenum2ep[R8A66597_MAX_NUM_PIPE];
 	struct r8a66597_ep	*epaddr2ep[16];
+	struct r8a66597_dma	dma;

 	struct timer_list	timer;
 	struct usb_request	*ep0_req;	/* for internal request */
@@ -260,7 +270,21 @@ static inline u16 get_xtal_from_pdata(struct r8a66597_platdata *pdata)
 	return clock;
 }

+static inline u32 r8a66597_sudmac_read(struct r8a66597 *r8a66597,
+				       unsigned long offset)
+{
+	return ioread32(r8a66597->sudmac_reg + offset);
+}
+
+static inline void r8a66597_sudmac_write(struct r8a66597 *r8a66597, u32 val,
+					 unsigned long offset)
+{
+	iowrite32(val, r8a66597->sudmac_reg + offset);
+}
+
 #define get_pipectr_addr(pipenum)	(PIPE1CTR + (pipenum - 1) * 2)
+#define get_pipetre_addr(pipenum)	(PIPE1TRE + (pipenum - 1) * 4)
+#define get_pipetrn_addr(pipenum)	(PIPE1TRN + (pipenum - 1) * 4)

 #define enable_irq_ready(r8a66597, pipenum)	\
 	enable_pipe_irq(r8a66597, pipenum, BRDYENB)
diff --git a/include/linux/usb/r8a66597.h b/include/linux/usb/r8a66597.h
index b6b8660..55805f9 100644
--- a/include/linux/usb/r8a66597.h
+++ b/include/linux/usb/r8a66597.h
@@ -48,6 +48,9 @@ struct r8a66597_platdata {

 	/* (external controller only) set one = WR0_N shorted to WR1_N */
 	unsigned	wr0_shorted_to_wr1:1;
+
+	/* set one = using SUDMAC */
+	unsigned	sudmac:1;
 };

 /* Register definitions */
@@ -417,5 +420,62 @@ struct r8a66597_platdata {
 #define	USBSPD		0x00C0
 #define	RTPORT		0x0001

+/* SUDMAC registers */
+#define CH0CFG		0x00
+#define CH1CFG		0x04
+#define CH0BA		0x10
+#define CH1BA		0x14
+#define CH0BBC		0x18
+#define CH1BBC		0x1C
+#define CH0CA		0x20
+#define CH1CA		0x24
+#define CH0CBC		0x28
+#define CH1CBC		0x2C
+#define CH0DEN		0x30
+#define CH1DEN		0x34
+#define DSTSCLR		0x38
+#define DBUFCTRL	0x3C
+#define DINTCTRL	0x40
+#define DINTSTS		0x44
+#define DINTSTSCLR	0x48
+#define CH0SHCTRL	0x50
+#define CH1SHCTRL	0x54
+
+/* SUDMAC Configuration Registers */
+#define SENDBUFM	0x1000 /* b12: Transmit Buffer Mode */
+#define RCVENDM		0x0100 /* b8: Receive Data Transfer End Mode */
+#define LBA_WAIT	0x0030 /* b5-4: Local Bus Access Wait */
+
+/* DMA Enable Registers */
+#define DEN		0x0001 /* b1: DMA Transfer Enable */
+
+/* DMA Status Clear Register */
+#define CH1STCLR	0x0002 /* b2: Ch1 DMA Status Clear */
+#define CH0STCLR	0x0001 /* b1: Ch0 DMA Status Clear */
+
+/* DMA Buffer Control Register */
+#define CH1BUFW		0x0200 /* b9: Ch1 DMA Buffer Data Transfer Enable */
+#define CH0BUFW		0x0100 /* b8: Ch0 DMA Buffer Data Transfer Enable */
+#define CH1BUFS		0x0002 /* b2: Ch1 DMA Buffer Data Status */
+#define CH0BUFS		0x0001 /* b1: Ch0 DMA Buffer Data Status */
+
+/* DMA Interrupt Control Register */
+#define CH1ERRE		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Enable */
+#define CH0ERRE		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Enable */
+#define CH1ENDE		0x0002 /* b2: Ch1 DMA Transfer End Int Enable */
+#define CH0ENDE		0x0001 /* b1: Ch0 DMA Transfer End Int Enable */
+
+/* DMA Interrupt Status Register */
+#define CH1ERRS		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Status */
+#define CH0ERRS		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Status */
+#define CH1ENDS		0x0002 /* b2: Ch1 DMA Transfer End Int Status */
+#define CH0ENDS		0x0001 /* b1: Ch0 DMA Transfer End Int Status */
+
+/* DMA Interrupt Status Clear Register */
+#define CH1ERRC		0x0200 /* b9: Ch1 SHwy Res Err Detect Int Stat Clear */
+#define CH0ERRC		0x0100 /* b8: Ch0 SHwy Res Err Detect Int Stat Clear */
+#define CH1ENDC		0x0002 /* b2: Ch1 DMA Transfer End Int Stat Clear */
+#define CH0ENDC		0x0001 /* b1: Ch0 DMA Transfer End Int Stat Clear */
+
 #endif /* __LINUX_USB_R8A66597_H */

-- 
1.7.1

