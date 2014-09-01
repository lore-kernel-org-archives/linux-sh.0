From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Sep 2014 14:25:35 +0000
Subject: [PATCH v2] net: sh_eth: fix driver dependencies
Message-Id: <1749721.1a6rN6K2Gg@amdc1032>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Renesas SuperH Ethernet support should be available only on
Renesas ARM SoCs and SuperH architecture.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
---
v2:
- s/ARCH_SH/SUPERH/ (thanks to Sergei Shtylyov)

 drivers/net/ethernet/renesas/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/net/ethernet/renesas/Kconfig
=================================--- a/drivers/net/ethernet/renesas/Kconfig	2014-07-30 14:31:20.479522692 +0200
+++ b/drivers/net/ethernet/renesas/Kconfig	2014-09-01 14:45:36.160544016 +0200
@@ -5,6 +5,7 @@
 config SH_ETH
 	tristate "Renesas SuperH Ethernet support"
 	depends on HAS_DMA
+	depends on ARCH_SHMOBILE || SUPERH || COMPILE_TEST
 	select CRC32
 	select MII
 	select MDIO_BITBANG

