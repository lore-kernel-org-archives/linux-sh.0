From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 13 Jan 2008 13:47:45 +0000
Subject: [PATCH] sh: r2d - enable sm501 usb host function
Message-Id: <20080113134745.30080.48194.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: r2d - enable sm501 usb host function

This patch tells the sm501 mfd driver to build platform data for the sm501 usb
host driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/rts7751r2d/setup.c |    1 +
 1 file changed, 1 insertion(+)

--- 0003/arch/sh/boards/renesas/rts7751r2d/setup.c
+++ work/arch/sh/boards/renesas/rts7751r2d/setup.c	2008-01-13 21:03:13.000000000 +0900
@@ -149,6 +149,7 @@ static struct sm501_initdata sm501_initd
 		.set	= 0x00001fe0,
 		.mask	= 0x0,
 	},
+	.devices	= SM501_USE_USB_HOST,
 };
 
 static struct sm501_platdata sm501_platform_data = {
