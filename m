From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 14 May 2013 02:37:53 +0000
Subject: [RFC PATCH net-next v2 3/3] sh_eth: add support for r8a7790 SoC
Message-Id: <1368499073-21975-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368499073-21975-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368499073-21975-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--

v2
* Move RMIIMODE portion into a separate patch
---
 drivers/net/ethernet/renesas/Kconfig  | 2 +-
 drivers/net/ethernet/renesas/sh_eth.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/Kconfig b/drivers/net/ethernet/renesas/Kconfig
index bed9841..d664c0f 100644
--- a/drivers/net/ethernet/renesas/Kconfig
+++ b/drivers/net/ethernet/renesas/Kconfig
@@ -9,7 +9,7 @@ config SH_ETH
 		 CPU_SUBTYPE_SH7763 || CPU_SUBTYPE_SH7619 || \
 		 CPU_SUBTYPE_SH7724 || CPU_SUBTYPE_SH7734 || \
 		 CPU_SUBTYPE_SH7757 || ARCH_R8A7740 || \
-		 ARCH_R8A7778 || ARCH_R8A7779)
+		 ARCH_R8A7778 || ARCH_R8A7779 || ARCH_R8A7790)
 	select CRC32
 	select NET_CORE
 	select MII
diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index ff5613d..e832d00 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -344,7 +344,8 @@ static void sh_eth_select_mii(struct net_device *ndev)
 #endif
 
 /* There is CPU dependent code */
-#if defined(CONFIG_ARCH_R8A7778) || defined(CONFIG_ARCH_R8A7779)
+#if defined(CONFIG_ARCH_R8A7778) || defined(CONFIG_ARCH_R8A7779) || \
+	defined(CONFIG_ARCH_R8A7790)
 #define SH_ETH_RESET_DEFAULT	1
 static void sh_eth_set_duplex(struct net_device *ndev)
 {
@@ -372,7 +373,7 @@ static void sh_eth_set_rate(struct net_device *ndev)
 	}
 }
 
-/* R8A7778/9 */
+/* R8A7778, R8A7779, R8A7790 */
 static struct sh_eth_cpu_data sh_eth_my_cpu_data = {
 	.set_duplex	= sh_eth_set_duplex,
 	.set_rate	= sh_eth_set_rate,
-- 
1.8.2.1

