From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 27 Jan 2019 17:40:23 +0000
Subject: [PATCH 5/7] sh_eth: offload RX checksum on R8A77980
Message-Id: <32f4bec9-35e6-6bbe-f9b6-a8996fc0793d@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
In-Reply-To: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

The R-Car V3H (R8A77980) SoC manual describes the Ether MAC's RX checksum
offload the same way as it's implemented in the EtherAVB MAC...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    1 +
 1 file changed, 1 insertion(+)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -796,6 +796,7 @@ static struct sh_eth_cpu_data r8a77980_d
 	.no_ade		= 1,
 	.xdfar_rw	= 1,
 	.csmr		= 1,
+	.rx_csum	= 1,
 	.select_mii	= 1,
 	.magic		= 1,
 	.cexcr		= 1,
