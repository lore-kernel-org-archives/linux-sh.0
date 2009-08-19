From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 14:19:08 +0000
Subject: [PATCH] usb: r8a66597-udc buffer management update
Message-Id: <20090819141908.23074.40037.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the r8a66597-udc buffer management code.

Use fixed buffers for bulk and isochronous pipes, also make
sure to handle the isochronous-as-bulk case. With fixed buffers
there is no need to keep track of used buffers with bi_bufnum.

Also, this fixes a potential buffer offset problem where the
base offset incorrectly varies with the number of pipes used.

The m66592 driver recently got fixed in a similar way.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/usb/gadget/r8a66597-udc.c |   32 +++++++++++---------------------
 drivers/usb/gadget/r8a66597-udc.h |    1 -
 2 files changed, 11 insertions(+), 22 deletions(-)

--- 0003/drivers/usb/gadget/r8a66597-udc.c
+++ work/drivers/usb/gadget/r8a66597-udc.c	2009-08-19 23:01:08.000000000 +0900
@@ -252,24 +252,27 @@ static int pipe_buffer_setting(struct r8
 		buf_bsize = 0;
 		break;
 	case R8A66597_BULK:
-		bufnum = r8a66597->bi_bufnum +
-			 (info->pipe - R8A66597_BASE_PIPENUM_BULK) * 16;
-		r8a66597->bi_bufnum += 16;
+		/* isochronous pipes may be used as bulk pipes */
+		if (info->pipe > R8A66597_BASE_PIPENUM_BULK)
+			bufnum = info->pipe - R8A66597_BASE_PIPENUM_BULK;
+		else
+			bufnum = info->pipe - R8A66597_BASE_PIPENUM_ISOC;
+
+		bufnum = R8A66597_BASE_BUFNUM + (bufnum * 16);
 		buf_bsize = 7;
 		pipecfg |= R8A66597_DBLB;
 		if (!info->dir_in)
 			pipecfg |= R8A66597_SHTNAK;
 		break;
 	case R8A66597_ISO:
-		bufnum = r8a66597->bi_bufnum +
+		bufnum = R8A66597_BASE_BUFNUM +
 			 (info->pipe - R8A66597_BASE_PIPENUM_ISOC) * 16;
-		r8a66597->bi_bufnum += 16;
 		buf_bsize = 7;
 		break;
 	}
-	if (r8a66597->bi_bufnum > R8A66597_MAX_BUFNUM) {
-		printk(KERN_ERR "r8a66597 pipe memory is insufficient(%d)\n",
-				r8a66597->bi_bufnum);
+
+	if (buf_bsize && ((bufnum + 16) >= R8A66597_MAX_BUFNUM)) {
+		pr_err(KERN_ERR "r8a66597 pipe memory is insufficient\n");
 		return -ENOMEM;
 	}
 
@@ -289,17 +292,6 @@ static void pipe_buffer_release(struct r
 	if (info->pipe = 0)
 		return;
 
-	switch (info->type) {
-	case R8A66597_BULK:
-		if (is_bulk_pipe(info->pipe))
-			r8a66597->bi_bufnum -= 16;
-		break;
-	case R8A66597_ISO:
-		if (is_isoc_pipe(info->pipe))
-			r8a66597->bi_bufnum -= 16;
-		break;
-	}
-
 	if (is_bulk_pipe(info->pipe))
 		r8a66597->bulk--;
 	else if (is_interrupt_pipe(info->pipe))
@@ -1553,8 +1545,6 @@ static int __init r8a66597_probe(struct 
 	r8a66597->timer.data = (unsigned long)r8a66597;
 	r8a66597->reg = (unsigned long)reg;
 
-	r8a66597->bi_bufnum = R8A66597_BASE_BUFNUM;
-
 #ifdef CONFIG_HAVE_CLK
 	if (r8a66597->pdata->on_chip) {
 		snprintf(clk_name, sizeof(clk_name), "usb%d", pdev->id);
--- 0003/drivers/usb/gadget/r8a66597-udc.h
+++ work/drivers/usb/gadget/r8a66597-udc.h	2009-08-19 20:33:16.000000000 +0900
@@ -112,7 +112,6 @@ struct r8a66597 {
 	u16			old_dvsq;
 
 	/* pipe config */
-	unsigned short bi_bufnum;	/* bulk and isochronous's bufnum */
 	unsigned char bulk;
 	unsigned char interrupt;
 	unsigned char isochronous;
