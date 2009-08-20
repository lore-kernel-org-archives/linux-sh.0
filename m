From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Aug 2009 13:57:36 +0000
Subject: [PATCH] sh: i2c compile fix for kfr2r09
Message-Id: <20090820135736.23974.96123.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix the kfr2r09 board code so it compiles if CONFIG_I2C=n.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-kfr2r09/setup.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-08-20 12:48:09.000000000 +0900
@@ -219,6 +219,7 @@ static struct platform_device *kfr2r09_d
 #define BSC_CS4WCR 0xfec10030
 #define PORT_MSELCRB 0xa4050182
 
+#ifdef CONFIG_I2C
 static int kfr2r09_usb0_gadget_i2c_setup(void)
 {
 	struct i2c_adapter *a;
@@ -261,6 +262,12 @@ static int kfr2r09_usb0_gadget_i2c_setup
 
 	return 0;
 }
+#else
+static int kfr2r09_usb0_gadget_i2c_setup(void)
+{
+	return -ENODEV;
+}
+#endif
 
 static int kfr2r09_usb0_gadget_setup(void)
 {
