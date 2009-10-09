From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Oct 2009 10:17:14 +0000
Subject: [PATCH] net: allow sh_eth to get mac address through platform data
Message-Id: <20091009101714.31039.91896.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, davem@davemloft.net, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the sh_eth driver to allow passing the mac address
using the platform data structure. This to simplify board
setup code.

Signed-off-by: Magnus Damm <damm@opensource.se>
Tested-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---

 arch/sh/include/asm/sh_eth.h |    1 +
 drivers/net/sh_eth.c         |   20 ++++++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

--- 0001/arch/sh/include/asm/sh_eth.h
+++ work/arch/sh/include/asm/sh_eth.h	2009-10-07 15:04:57.000000000 +0900
@@ -7,6 +7,7 @@ struct sh_eth_plat_data {
 	int phy;
 	int edmac_endian;
 
+	unsigned char mac_addr[6];
 	unsigned no_ether_link:1;
 	unsigned ether_link_active_low:1;
 };
--- 0001/drivers/net/sh_eth.c
+++ work/drivers/net/sh_eth.c	2009-10-07 16:54:29.000000000 +0900
@@ -298,16 +298,20 @@ static void update_mac_address(struct ne
  * When you want use this device, you must set MAC address in bootloader.
  *
  */
-static void read_mac_address(struct net_device *ndev)
+static void read_mac_address(struct net_device *ndev, unsigned char *mac)
 {
 	u32 ioaddr = ndev->base_addr;
 
-	ndev->dev_addr[0] = (ctrl_inl(ioaddr + MAHR) >> 24);
-	ndev->dev_addr[1] = (ctrl_inl(ioaddr + MAHR) >> 16) & 0xFF;
-	ndev->dev_addr[2] = (ctrl_inl(ioaddr + MAHR) >> 8) & 0xFF;
-	ndev->dev_addr[3] = (ctrl_inl(ioaddr + MAHR) & 0xFF);
-	ndev->dev_addr[4] = (ctrl_inl(ioaddr + MALR) >> 8) & 0xFF;
-	ndev->dev_addr[5] = (ctrl_inl(ioaddr + MALR) & 0xFF);
+	if (mac[0] || mac[1] || mac[2] || mac[3] || mac[4] || mac[5]) {
+		memcpy(ndev->dev_addr, mac, 6);
+	} else {
+		ndev->dev_addr[0] = (ctrl_inl(ioaddr + MAHR) >> 24);
+		ndev->dev_addr[1] = (ctrl_inl(ioaddr + MAHR) >> 16) & 0xFF;
+		ndev->dev_addr[2] = (ctrl_inl(ioaddr + MAHR) >> 8) & 0xFF;
+		ndev->dev_addr[3] = (ctrl_inl(ioaddr + MAHR) & 0xFF);
+		ndev->dev_addr[4] = (ctrl_inl(ioaddr + MALR) >> 8) & 0xFF;
+		ndev->dev_addr[5] = (ctrl_inl(ioaddr + MALR) & 0xFF);
+	}
 }
 
 struct bb_info {
@@ -1427,7 +1431,7 @@ static int sh_eth_drv_probe(struct platf
 	mdp->post_fw = POST_FW >> (devno << 1);
 
 	/* read and set MAC address */
-	read_mac_address(ndev);
+	read_mac_address(ndev, pd->mac_addr);
 
 	/* First device only init */
 	if (!devno) {
