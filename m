From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Feb 2019 18:12:39 +0000
Subject: [PATCH v2 7/7] sh_eth: offload RX checksum on SH7763
Message-Id: <2d6569b3-b83a-b815-30b1-56fde1a7a0e6@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
In-Reply-To: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
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

Index: renesas/drivers/net/ethernet/renesas/sh_eth.c
=================================--- renesas.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ renesas/drivers/net/ethernet/renesas/sh_eth.c
@@ -1092,6 +1092,7 @@ static struct sh_eth_cpu_data sh7763_dat
 	.irq_flags	= IRQF_SHARED,
 	.magic		= 1,
 	.cexcr		= 1,
+	.rx_csum	= 1,
 	.dual_port	= 1,
 };
 
