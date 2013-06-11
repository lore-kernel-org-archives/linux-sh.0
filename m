From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 11 Jun 2013 23:07:29 +0000
Subject: [PATCH] sh_eth: remove '__maybe_unused' annotations
Message-Id: <201306120307.29615.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Now that  the SoC specific support is no longer done with help of #ifdef'fery,
we  no longer need '__maybe_unused' annotations to sh_eth_select_mii() and
sh_eth_set_duplex()...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net-next.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -321,7 +321,7 @@ static int sh_eth_is_gether(struct sh_et
 		return 0;
 }
 
-static void __maybe_unused sh_eth_select_mii(struct net_device *ndev)
+static void sh_eth_select_mii(struct net_device *ndev)
 {
 	u32 value = 0x0;
 	struct sh_eth_private *mdp = netdev_priv(ndev);
@@ -345,7 +345,7 @@ static void __maybe_unused sh_eth_select
 	sh_eth_write(ndev, value, RMII_MII);
 }
 
-static void __maybe_unused sh_eth_set_duplex(struct net_device *ndev)
+static void sh_eth_set_duplex(struct net_device *ndev)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 
