From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Jan 2010 07:41:19 +0000
Subject: [PATCH] usb: r8a66597-hdc disable interrupts fix
Message-Id: <20100127074119.25763.59310.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch improves disable_controller() in the r8a66597-hdc
driver to disable all interrupts and clear status flags. It
also makes sure that disable_controller() is called during
probe(). This fixes the relatively rare case of unexpected
pending interrupts after kexec reboot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/usb/host/r8a66597-hcd.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- 0001/drivers/usb/host/r8a66597-hcd.c
+++ work/drivers/usb/host/r8a66597-hcd.c	2010-01-26 18:12:57.000000000 +0900
@@ -216,8 +216,17 @@ static void disable_controller(struct r8
 {
 	int port;
 
+	/* disable interrupts */
 	r8a66597_write(r8a66597, 0, INTENB0);
-	r8a66597_write(r8a66597, 0, INTSTS0);
+	r8a66597_write(r8a66597, 0, INTENB1);
+	r8a66597_write(r8a66597, 0, BRDYENB);
+	r8a66597_write(r8a66597, 0, BEMPENB);
+	r8a66597_write(r8a66597, 0, NRDYENB);
+
+	/* clear status */
+	r8a66597_write(r8a66597, 0, BRDYSTS);
+	r8a66597_write(r8a66597, 0, NRDYSTS);
+	r8a66597_write(r8a66597, 0, BEMPSTS);
 
 	for (port = 0; port < r8a66597->max_root_hub; port++)
 		r8a66597_disable_port(r8a66597, port);
@@ -2466,6 +2475,12 @@ static int __devinit r8a66597_probe(stru
 	r8a66597->rh_timer.data = (unsigned long)r8a66597;
 	r8a66597->reg = (unsigned long)reg;
 
+	/* make sure no interrupts are pending */
+	ret = r8a66597_clock_enable(r8a66597);
+	if (ret < 0)
+		goto clean_up3;
+	disable_controller(r8a66597);
+
 	for (i = 0; i < R8A66597_MAX_NUM_PIPE; i++) {
 		INIT_LIST_HEAD(&r8a66597->pipe_queue[i]);
 		init_timer(&r8a66597->td_timer[i]);
