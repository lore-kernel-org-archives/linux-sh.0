From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 14:26:10 +0000
Subject: [PATCH] usb: r8a66597-udc disable interrupts on shutdown fix
Message-Id: <20090819142610.23156.17157.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch improves the disable_controller() function in the
r8a66597-udc driver to disable all interrupts and also clear
status flags. With this patch in place the driver survives
kexec.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/usb/gadget/r8a66597-udc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0005/drivers/usb/gadget/r8a66597-udc.c
+++ work/drivers/usb/gadget/r8a66597-udc.c	2009-08-19 22:04:26.000000000 +0900
@@ -614,8 +614,17 @@ static void disable_controller(struct r8
 	if (r8a66597->pdata->on_chip) {
 		r8a66597_bset(r8a66597, SCKE, SYSCFG0);
 
+		/* disable interrupts */
 		r8a66597_write(r8a66597, 0, INTENB0);
 		r8a66597_write(r8a66597, 0, INTENB1);
+		r8a66597_write(r8a66597, 0, BRDYENB);
+		r8a66597_write(r8a66597, 0, BEMPENB);
+		r8a66597_write(r8a66597, 0, NRDYENB);
+
+		/* clear status */
+		r8a66597_write(r8a66597, 0, BRDYSTS);
+		r8a66597_write(r8a66597, 0, NRDYSTS);
+		r8a66597_write(r8a66597, 0, BEMPSTS);
 
 		r8a66597_bclr(r8a66597, USBE, SYSCFG0);
 		r8a66597_bclr(r8a66597, SCKE, SYSCFG0);
