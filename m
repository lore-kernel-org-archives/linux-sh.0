From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Oct 2009 10:47:34 +0000
Subject: [PATCH] sh: mac address through private data for sh_eth on ms7724se
Message-Id: <20091027104734.26330.25913.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20091026104437.25084.57539.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091026104437.25084.57539.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the ms7724se board code to pass the mac
address to the sh_eth driver using platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This depends on the sh_eth platform data mac patch.

 arch/sh/boards/mach-se/7724/setup.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-10-27 18:07:05.000000000 +0900
@@ -507,7 +507,7 @@ static int __init sh_eth_is_eeprom_ready
 static void __init sh_eth_init(void)
 {
 	int i;
-	u16 mac[3];
+	u16 mac;
 
 	/* check EEPROM status */
 	if (!sh_eth_is_eeprom_ready())
@@ -521,16 +521,10 @@ static void __init sh_eth_init(void)
 		if (!sh_eth_is_eeprom_ready())
 			return;
 
-		mac[i] = ctrl_inw(EEPROM_DATA);
-		mac[i] = ((mac[i] & 0xFF) << 8) | (mac[i] >> 8); /* swap */
+		mac = ctrl_inw(EEPROM_DATA);
+		sh_eth_plat.mac_addr[i << 1] = mac & 0xff;
+		sh_eth_plat.mac_addr[(i << 1) + 1] = mac >> 8;
 	}
-
-	/* reset sh-eth */
-	ctrl_outl(0x1, SH_ETH_ADDR + 0x0);
-
-	/* set MAC addr */
-	ctrl_outl(((mac[0] << 16) | (mac[1])), SH_ETH_MAHR);
-	ctrl_outl((mac[2]), SH_ETH_MALR);
 }
 
 #define SW4140    0xBA201000
