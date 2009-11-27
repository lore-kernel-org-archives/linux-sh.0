From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Nov 2009 09:28:03 +0000
Subject: [PATCH] sh: Improve kfr2r09 serial port setup code
Message-Id: <20091127092803.9204.29222.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch improves the serial port communication quality
of port YC401 on the KFR2R09 board. With this fix serial
console is fine at 115200 - up and down keys now work as
expected. Thanks to Hirohide Yamasaki for this fix.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-kfr2r09/setup.c |   51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

--- 0008/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-11-27 18:13:11.000000000 +0900
@@ -414,11 +414,59 @@ static int kfr2r09_usb0_gadget_i2c_setup
 
 	return 0;
 }
+
+static int kfr2r09_serial_i2c_setup(void)
+{
+	struct i2c_adapter *a;
+	struct i2c_msg msg;
+	unsigned char buf[2];
+	int ret;
+
+	a = i2c_get_adapter(0);
+	if (!a)
+		return -ENODEV;
+
+	/* set bit 6 (the 7th bit) of chip at 0x09, register 0x13 */
+	buf[0] = 0x13;
+	msg.addr = 0x09;
+	msg.buf = buf;
+	msg.len = 1;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	buf[0] = 0;
+	msg.addr = 0x09;
+	msg.buf = buf;
+	msg.len = 1;
+	msg.flags = I2C_M_RD;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	buf[1] = buf[0] | (1 << 6);
+	buf[0] = 0x13;
+	msg.addr = 0x09;
+	msg.buf = buf;
+	msg.len = 2;
+	msg.flags = 0;
+	ret = i2c_transfer(a, &msg, 1);
+	if (ret != 1)
+		return -ENODEV;
+
+	return 0;
+}
 #else
 static int kfr2r09_usb0_gadget_i2c_setup(void)
 {
 	return -ENODEV;
 }
+
+static int kfr2r09_serial_i2c_setup(void)
+{
+	return -ENODEV;
+}
 #endif
 
 static int kfr2r09_usb0_gadget_setup(void)
@@ -463,6 +511,9 @@ static int __init kfr2r09_devices_setup(
 	/* enable SCIF1 serial port for YC401 console support */
 	gpio_request(GPIO_FN_SCIF1_RXD, NULL);
 	gpio_request(GPIO_FN_SCIF1_TXD, NULL);
+	kfr2r09_serial_i2c_setup(); /* ECONTMSK(bit6=L10ONEN) set 1 */
+	gpio_request(GPIO_PTG3, NULL); /* HPON_ON */
+	gpio_direction_output(GPIO_PTG3, 1); /* HPON_ON = H */
 
 	/* setup NOR flash at CS0 */
 	ctrl_outl(0x36db0400, BSC_CS0BCR);
