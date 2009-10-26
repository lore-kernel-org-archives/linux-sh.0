From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 26 Oct 2009 10:44:37 +0000
Subject: [PATCH] sh: mac address through private data for sh_eth on ecovec24
Message-Id: <20091026104437.25084.57539.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the ecovec24 board code to pass the mac
address to the sh_eth driver using platform data.
Also, remove the static clock to allow Runtime PM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c |   33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

--- 0003/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-10-07 15:11:51.000000000 +0900
@@ -414,12 +414,9 @@ static u8 mac_read(struct i2c_adapter *a
 	return buf;
 }
 
-#define MAC_LEN 6
-static void __init sh_eth_init(void)
+static void __init sh_eth_init(struct sh_eth_plat_data *pd)
 {
 	struct i2c_adapter *a = i2c_get_adapter(1);
-	struct clk *eth_clk;
-	u8 mac[MAC_LEN];
 	int i;
 
 	if (!a) {
@@ -427,33 +424,11 @@ static void __init sh_eth_init(void)
 		return;
 	}
 
-	eth_clk = clk_get(NULL, "eth0");
-	if (!eth_clk) {
-		pr_err("can not get eth0 clk\n");
-		return;
-	}
-
 	/* read MAC address frome EEPROM */
-	for (i = 0; i < MAC_LEN; i++) {
-		mac[i] = mac_read(a, 0x10 + i);
+	for (i = 0; i < sizeof(pd->mac_addr); i++) {
+		pd->mac_addr[i] = mac_read(a, 0x10 + i);
 		msleep(10);
 	}
-
-	/* clock enable */
-	clk_enable(eth_clk);
-
-	/* reset sh-eth */
-	ctrl_outl(0x1, SH_ETH_ADDR + 0x0);
-
-	/* set MAC addr */
-	ctrl_outl((mac[0] << 24) |
-		  (mac[1] << 16) |
-		  (mac[2] <<  8) |
-		  (mac[3] <<  0), SH_ETH_MAHR);
-	ctrl_outl((mac[4] <<  8) |
-		  (mac[5] <<  0), SH_ETH_MALR);
-
-	clk_put(eth_clk);
 }
 
 #define PORT_HIZA 0xA4050158
@@ -665,7 +640,7 @@ arch_initcall(arch_setup);
 
 static int __init devices_setup(void)
 {
-	sh_eth_init();
+	sh_eth_init(&sh_eth_plat);
 	return 0;
 }
 device_initcall(devices_setup);
