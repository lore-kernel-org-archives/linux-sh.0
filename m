From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Feb 2010 11:10:54 +0000
Subject: [PATCH] sh: ecovec build fix for CONFIG_I2C=n
Message-Id: <20100225111054.6879.44864.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow building the ecovec board support code
even though I2C support is disabled.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0006/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2010-02-25 19:33:55.000000000 +0900
@@ -773,6 +773,7 @@ static struct platform_device *ecovec_de
 	&fsi_device,
 };
 
+#ifdef CONFIG_I2C
 #define EEPROM_ADDR 0x50
 static u8 mac_read(struct i2c_adapter *a, u8 command)
 {
@@ -815,6 +816,12 @@ static void __init sh_eth_init(struct sh
 		msleep(10);
 	}
 }
+#else
+static void __init sh_eth_init(struct sh_eth_plat_data *pd)
+{
+		pr_err("unable to read sh_eth MAC address\n");
+}
+#endif
 
 #define PORT_HIZA 0xA4050158
 #define IODRIVEA  0xA405018A
