From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 04 Feb 2019 18:08:54 +0000
Subject: [PATCH v2 4/7] sh_eth: offload RX checksum on R8A7740
Message-Id: <047ee1f3-b64c-5421-150e-15993049e1ef@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
In-Reply-To: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

The R-Mobile A1 (R8A7740) SoC manual describes the Ether MAC's RX checksum
offload the same way as it's implemented in the EtherAVB MAC...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- added Geert's tag.

 drivers/net/ethernet/renesas/sh_eth.c |    1 +
 1 file changed, 1 insertion(+)

Index: renesas/drivers/net/ethernet/renesas/sh_eth.c
=================================--- renesas.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ renesas/drivers/net/ethernet/renesas/sh_eth.c
@@ -670,6 +670,7 @@ static struct sh_eth_cpu_data r8a7740_da
 	.no_ade		= 1,
 	.xdfar_rw	= 1,
 	.csmr		= 1,
+	.rx_csum	= 1,
 	.tsu		= 1,
 	.select_mii	= 1,
 	.magic		= 1,
