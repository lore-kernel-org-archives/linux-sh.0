From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 24 Nov 2015 14:41:00 +0000
Subject: [PATCH v3 4/4] sh_eth: Remove obsolete r8a777x-ether platform_device_id entry
Message-Id: <1448376060-7803-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448376060-7803-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448376060-7803-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 3d7608e4c169af03 ("ARM: shmobile: bockw: remove legacy
board file and config"), R-Car Gen1 SoCs are only supported in generic
DT-only ARM multi-platform builds.  The driver doesn't need to match
platform devices by name anymore, hence remove the corresponding
platform_device_id entry.

Protect sh_eth_set_rate_r8a777x() and r8a777x_data by #ifdef CONFIG_OF,
as they're now referenced on DT platforms only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Add Acked-by,

v2:
  - New.
---
 drivers/net/ethernet/renesas/sh_eth.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 99618bf513b26184..7f3c6109d45ed874 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -551,7 +551,6 @@ static struct sh_eth_cpu_data r8a7740_data = {
 	.select_mii	= 1,
 	.shift_rd0	= 1,
 };
-#endif /* CONFIG_OF */
 
 /* There is CPU dependent code */
 static void sh_eth_set_rate_r8a777x(struct net_device *ndev)
@@ -593,7 +592,6 @@ static struct sh_eth_cpu_data r8a777x_data = {
 	.hw_swap	= 1,
 };
 
-#ifdef CONFIG_OF
 /* R8A7790/1 */
 static struct sh_eth_cpu_data r8a779x_data = {
 	.set_duplex	= sh_eth_set_duplex,
@@ -3281,7 +3279,6 @@ static struct platform_device_id sh_eth_id_table[] = {
 	{ "sh7757-ether", (kernel_ulong_t)&sh7757_data },
 	{ "sh7757-gether", (kernel_ulong_t)&sh7757_data_giga },
 	{ "sh7763-gether", (kernel_ulong_t)&sh7763_data },
-	{ "r8a777x-ether", (kernel_ulong_t)&r8a777x_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, sh_eth_id_table);
-- 
1.9.1

