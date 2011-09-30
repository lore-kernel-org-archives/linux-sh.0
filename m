From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Sep 2011 11:07:30 +0000
Subject: [PATCH v2 3/4] usb: r8a66597-udc: use dev_*() instead of printk()
Message-Id: <4E85A2F2.4010408@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch also fix the balance of braces.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - before adding a new function, convert the printk() to dev_*().

 drivers/usb/gadget/r8a66597-udc.c |   99 ++++++++++++++++++++++---------------
 drivers/usb/gadget/r8a66597-udc.h |    1 +
 2 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index cd2cd16..fdc49f0 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -115,13 +115,15 @@ static inline u16 control_reg_get_pid(struct r8a66597 *r8a66597, u16 pipenum)
 	u16 pid = 0;
 	unsigned long offset;

-	if (pipenum = 0)
+	if (pipenum = 0) {
 		pid = r8a66597_read(r8a66597, DCPCTR) & PID;
-	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
+	} else if (pipenum < R8A66597_MAX_NUM_PIPE) {
 		offset = get_pipectr_addr(pipenum);
 		pid = r8a66597_read(r8a66597, offset) & PID;
-	} else
-		printk(KERN_ERR "unexpect pipe num (%d)\n", pipenum);
+	} else {
+		dev_err(r8a66597_to_dev(r8a66597), "unexpect pipe num (%d)\n",
+			pipenum);
+	}

 	return pid;
 }
@@ -131,13 +133,15 @@ static inline void control_reg_set_pid(struct r8a66597 *r8a66597, u16 pipenum,
 {
 	unsigned long offset;

-	if (pipenum = 0)
+	if (pipenum = 0) {
 		r8a66597_mdfy(r8a66597, pid, PID, DCPCTR);
-	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
+	} else if (pipenum < R8A66597_MAX_NUM_PIPE) {
 		offset = get_pipectr_addr(pipenum);
 		r8a66597_mdfy(r8a66597, pid, PID, offset);
-	} else
-		printk(KERN_ERR "unexpect pipe num (%d)\n", pipenum);
+	} else {
+		dev_err(r8a66597_to_dev(r8a66597), "unexpect pipe num (%d)\n",
+			pipenum);
+	}
 }

 static inline void pipe_start(struct r8a66597 *r8a66597, u16 pipenum)
@@ -160,13 +164,15 @@ static inline u16 control_reg_get(struct r8a66597 *r8a66597, u16 pipenum)
 	u16 ret = 0;
 	unsigned long offset;

-	if (pipenum = 0)
+	if (pipenum = 0) {
 		ret = r8a66597_read(r8a66597, DCPCTR);
-	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
+	} else if (pipenum < R8A66597_MAX_NUM_PIPE) {
 		offset = get_pipectr_addr(pipenum);
 		ret = r8a66597_read(r8a66597, offset);
-	} else
-		printk(KERN_ERR "unexpect pipe num (%d)\n", pipenum);
+	} else {
+		dev_err(r8a66597_to_dev(r8a66597), "unexpect pipe num (%d)\n",
+			pipenum);
+	}

 	return ret;
 }
@@ -177,13 +183,15 @@ static inline void control_reg_sqclr(struct r8a66597 *r8a66597, u16 pipenum)

 	pipe_stop(r8a66597, pipenum);

-	if (pipenum = 0)
+	if (pipenum = 0) {
 		r8a66597_bset(r8a66597, SQCLR, DCPCTR);
-	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
+	} else if (pipenum < R8A66597_MAX_NUM_PIPE) {
 		offset = get_pipectr_addr(pipenum);
 		r8a66597_bset(r8a66597, SQCLR, offset);
-	} else
-		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
+	} else {
+		dev_err(r8a66597_to_dev(r8a66597), "unexpect pipe num (%d)\n",
+			pipenum);
+	}
 }

 static inline int get_buffer_size(struct r8a66597 *r8a66597, u16 pipenum)
@@ -297,17 +305,18 @@ static void pipe_buffer_release(struct r8a66597 *r8a66597,
 	if (info->pipe = 0)
 		return;

-	if (is_bulk_pipe(info->pipe))
+	if (is_bulk_pipe(info->pipe)) {
 		r8a66597->bulk--;
-	else if (is_interrupt_pipe(info->pipe))
+	} else if (is_interrupt_pipe(info->pipe)) {
 		r8a66597->interrupt--;
-	else if (is_isoc_pipe(info->pipe)) {
+	} else if (is_isoc_pipe(info->pipe)) {
 		r8a66597->isochronous--;
 		if (info->type = R8A66597_BULK)
 			r8a66597->bulk--;
-	} else
-		printk(KERN_ERR "ep_release: unexpect pipenum (%d)\n",
-				info->pipe);
+	} else {
+		dev_err(r8a66597_to_dev(r8a66597),
+			"ep_release: unexpect pipenum (%d)\n", info->pipe);
+	}
 }

 static void pipe_initialize(struct r8a66597_ep *ep)
@@ -381,7 +390,8 @@ static int alloc_pipe_config(struct r8a66597_ep *ep,
 	case USB_ENDPOINT_XFER_BULK:
 		if (r8a66597->bulk >= R8A66597_MAX_NUM_BULK) {
 			if (r8a66597->isochronous >= R8A66597_MAX_NUM_ISOC) {
-				printk(KERN_ERR "bulk pipe is insufficient\n");
+				dev_err(r8a66597_to_dev(r8a66597),
+					"bulk pipe is insufficient\n");
 				return -ENODEV;
 			} else {
 				info.pipe = R8A66597_BASE_PIPENUM_ISOC
@@ -397,7 +407,8 @@ static int alloc_pipe_config(struct r8a66597_ep *ep,
 		break;
 	case USB_ENDPOINT_XFER_INT:
 		if (r8a66597->interrupt >= R8A66597_MAX_NUM_INT) {
-			printk(KERN_ERR "interrupt pipe is insufficient\n");
+			dev_err(r8a66597_to_dev(r8a66597),
+				"interrupt pipe is insufficient\n");
 			return -ENODEV;
 		}
 		info.pipe = R8A66597_BASE_PIPENUM_INT + r8a66597->interrupt;
@@ -406,7 +417,8 @@ static int alloc_pipe_config(struct r8a66597_ep *ep,
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		if (r8a66597->isochronous >= R8A66597_MAX_NUM_ISOC) {
-			printk(KERN_ERR "isochronous pipe is insufficient\n");
+			dev_err(r8a66597_to_dev(r8a66597),
+				"isochronous pipe is insufficient\n");
 			return -ENODEV;
 		}
 		info.pipe = R8A66597_BASE_PIPENUM_ISOC + r8a66597->isochronous;
@@ -414,7 +426,7 @@ static int alloc_pipe_config(struct r8a66597_ep *ep,
 		counter = &r8a66597->isochronous;
 		break;
 	default:
-		printk(KERN_ERR "unexpect xfer type\n");
+		dev_err(r8a66597_to_dev(r8a66597), "unexpect xfer type\n");
 		return -EINVAL;
 	}
 	ep->type = info.type;
@@ -429,7 +441,8 @@ static int alloc_pipe_config(struct r8a66597_ep *ep,

 	ret = pipe_buffer_setting(r8a66597, &info);
 	if (ret < 0) {
-		printk(KERN_ERR "pipe_buffer_setting fail\n");
+		dev_err(r8a66597_to_dev(r8a66597),
+			"pipe_buffer_setting fail\n");
 		return ret;
 	}

@@ -564,7 +577,8 @@ static void start_ep0(struct r8a66597_ep *ep, struct r8a66597_request *req)
 		control_end(ep->r8a66597, 0);
 		break;
 	default:
-		printk(KERN_ERR "start_ep0: unexpect ctsq(%x)\n", ctsq);
+		dev_err(r8a66597_to_dev(ep->r8a66597),
+			"start_ep0: unexpect ctsq(%x)\n", ctsq);
 		break;
 	}
 }
@@ -718,7 +732,8 @@ static void irq_ep0_write(struct r8a66597_ep *ep, struct r8a66597_request *req)
 	do {
 		tmp = r8a66597_read(r8a66597, ep->fifoctr);
 		if (i++ > 100000) {
-			printk(KERN_ERR "pipe0 is busy. maybe cpu i/o bus"
+			dev_err(r8a66597_to_dev(r8a66597),
+				"pipe0 is busy. maybe cpu i/o bus "
 				"conflict. please power off this controller.");
 			return;
 		}
@@ -769,7 +784,8 @@ static void irq_packet_write(struct r8a66597_ep *ep,
 	if (unlikely((tmp & FRDY) = 0)) {
 		pipe_stop(r8a66597, pipenum);
 		pipe_irq_disable(r8a66597, pipenum);
-		printk(KERN_ERR "write fifo not ready. pipnum=%d\n", pipenum);
+		dev_err(r8a66597_to_dev(r8a66597),
+			"write fifo not ready. pipnum=%d\n", pipenum);
 		return;
 	}

@@ -819,7 +835,7 @@ static void irq_packet_read(struct r8a66597_ep *ep,
 		req->req.status = -EPIPE;
 		pipe_stop(r8a66597, pipenum);
 		pipe_irq_disable(r8a66597, pipenum);
-		printk(KERN_ERR "read fifo not ready");
+		dev_err(r8a66597_to_dev(r8a66597), "read fifo not ready");
 		return;
 	}

@@ -1095,7 +1111,7 @@ static void r8a66597_update_usb_speed(struct r8a66597 *r8a66597)
 		break;
 	default:
 		r8a66597->gadget.speed = USB_SPEED_UNKNOWN;
-		printk(KERN_ERR "USB speed unknown\n");
+		dev_err(r8a66597_to_dev(r8a66597), "USB speed unknown\n");
 	}
 }

@@ -1158,7 +1174,8 @@ __acquires(r8a66597->lock)
 		control_end(r8a66597, 0);
 		break;
 	default:
-		printk(KERN_ERR "ctrl_stage: unexpect ctsq(%x)\n", ctsq);
+		dev_err(r8a66597_to_dev(r8a66597),
+			"ctrl_stage: unexpect ctsq(%x)\n", ctsq);
 		break;
 	}
 }
@@ -1458,13 +1475,15 @@ static int r8a66597_start(struct usb_gadget_driver *driver,

 	retval = device_add(&r8a66597->gadget.dev);
 	if (retval) {
-		printk(KERN_ERR "device_add error (%d)\n", retval);
+		dev_err(r8a66597_to_dev(r8a66597), "device_add error (%d)\n",
+			retval);
 		goto error;
 	}

 	retval = bind(&r8a66597->gadget);
 	if (retval) {
-		printk(KERN_ERR "bind to driver error (%d)\n", retval);
+		dev_err(r8a66597_to_dev(r8a66597),
+			"bind to driver error (%d)\n", retval);
 		device_del(&r8a66597->gadget.dev);
 		goto error;
 	}
@@ -1579,7 +1598,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENODEV;
-		printk(KERN_ERR "platform_get_resource error.\n");
+		dev_err(&pdev->dev, "platform_get_resource error.\n");
 		goto clean_up;
 	}

@@ -1589,14 +1608,14 @@ static int __init r8a66597_probe(struct platform_device *pdev)

 	if (irq < 0) {
 		ret = -ENODEV;
-		printk(KERN_ERR "platform_get_irq error.\n");
+		dev_err(&pdev->dev, "platform_get_irq error.\n");
 		goto clean_up;
 	}

 	reg = ioremap(res->start, resource_size(res));
 	if (reg = NULL) {
 		ret = -ENOMEM;
-		printk(KERN_ERR "ioremap error.\n");
+		dev_err(&pdev->dev, "ioremap error.\n");
 		goto clean_up;
 	}

@@ -1604,7 +1623,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	r8a66597 = kzalloc(sizeof(struct r8a66597), GFP_KERNEL);
 	if (r8a66597 = NULL) {
 		ret = -ENOMEM;
-		printk(KERN_ERR "kzalloc error\n");
+		dev_err(&pdev->dev, "kzalloc error\n");
 		goto clean_up;
 	}

@@ -1646,7 +1665,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 	ret = request_irq(irq, r8a66597_irq, IRQF_DISABLED | IRQF_SHARED,
 			udc_name, r8a66597);
 	if (ret < 0) {
-		printk(KERN_ERR "request_irq error (%d)\n", ret);
+		dev_err(&pdev->dev, "request_irq error (%d)\n", ret);
 		goto clean_up2;
 	}

diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index 37d0dd5..99681c7 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -124,6 +124,7 @@ struct r8a66597 {
 #define gadget_to_r8a66597(_gadget)	\
 		container_of(_gadget, struct r8a66597, gadget)
 #define r8a66597_to_gadget(r8a66597) (&r8a66597->gadget)
+#define r8a66597_to_dev(r8a66597)	(r8a66597->gadget.dev.parent)

 static inline u16 r8a66597_read(struct r8a66597 *r8a66597, unsigned long offset)
 {
-- 
1.7.1
