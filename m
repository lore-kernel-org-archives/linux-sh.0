From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 27 Jan 2019 17:42:12 +0000
Subject: [PATCH 7/7] sh_eth: offload RX checksum on SH7763
Message-Id: <e8ce7a88-b689-6114-66e4-c45a95087a1f@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
In-Reply-To: <fc43bfa2-4312-b52b-a749-e3e43e242a95@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

The SH7763 SoC manual describes the Ether MAC's RX checksum offload
the same way as it's implemented in the EtherAVB MACs...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    1 +
 1 file changed, 1 insertion(+)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -1092,6 +1092,7 @@ static struct sh_eth_cpu_data sh7763_dat
 	.irq_flags	= IRQF_SHARED,
 	.magic		= 1,
 	.cexcr		= 1,
+	.rx_csum	= 1,
 	.dual_port	= 1,
 };
 
