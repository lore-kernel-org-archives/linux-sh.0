From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 02 May 2018 19:54:48 +0000
Subject: [PATCH 1/2] sh_eth: use TSU register accessors for TSU_POST<n>
Message-Id: <297c4665-de06-ddf2-5c97-4d56c781b299@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4a17ab65-4d9c-897e-c340-7d86e0296f2f@cogentembedded.com>
In-Reply-To: <4a17ab65-4d9c-897e-c340-7d86e0296f2f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

There's no particularly good reason TSU_POST<n> registers get accessed
circumventing sh_eth_tsu_{read|write}() -- start using those, removing
(badly named) sh_eth_tsu_get_post_reg_offset(),  while at it...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -2610,12 +2610,6 @@ static int sh_eth_change_mtu(struct net_
 }
 
 /* For TSU_POSTn. Please refer to the manual about this (strange) bitfields */
-static void *sh_eth_tsu_get_post_reg_offset(struct sh_eth_private *mdp,
-					    int entry)
-{
-	return sh_eth_tsu_get_offset(mdp, TSU_POST1) + (entry / 8 * 4);
-}
-
 static u32 sh_eth_tsu_get_post_mask(int entry)
 {
 	return 0x0f << (28 - ((entry % 8) * 4));
@@ -2630,27 +2624,25 @@ static void sh_eth_tsu_enable_cam_entry_
 					     int entry)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
+	int reg = TSU_POST1 + entry / 8;
 	u32 tmp;
-	void *reg_offset;
 
-	reg_offset = sh_eth_tsu_get_post_reg_offset(mdp, entry);
-	tmp = ioread32(reg_offset);
-	iowrite32(tmp | sh_eth_tsu_get_post_bit(mdp, entry), reg_offset);
+	tmp = sh_eth_tsu_read(mdp, reg);
+	sh_eth_tsu_write(mdp, tmp | sh_eth_tsu_get_post_bit(mdp, entry), reg);
 }
 
 static bool sh_eth_tsu_disable_cam_entry_post(struct net_device *ndev,
 					      int entry)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
+	int reg = TSU_POST1 + entry / 8;
 	u32 post_mask, ref_mask, tmp;
-	void *reg_offset;
 
-	reg_offset = sh_eth_tsu_get_post_reg_offset(mdp, entry);
 	post_mask = sh_eth_tsu_get_post_mask(entry);
 	ref_mask = sh_eth_tsu_get_post_bit(mdp, entry) & ~post_mask;
 
-	tmp = ioread32(reg_offset);
-	iowrite32(tmp & ~post_mask, reg_offset);
+	tmp = sh_eth_tsu_read(mdp, reg);
+	sh_eth_tsu_write(mdp, tmp & ~post_mask, reg);
 
 	/* If other port enables, the function returns "true" */
 	return tmp & ref_mask;
