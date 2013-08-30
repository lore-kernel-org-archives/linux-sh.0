From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 30 Aug 2013 03:41:08 +0000
Subject: [PATCH net-next v2 2/2] sh_eth: Enable Rx descriptor word 0 shift for r8a7790
Message-Id: <1377834068-6978-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377834068-6978-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1377834068-6978-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kouei Abe <kouei.abe.cp@renesas.com>, Simon Horman <horms+renesas@verge.net.au>

From: Kouei Abe <kouei.abe.cp@renesas.com>

This corrects an oversight when r8a7790 support was added to sh_eth.

Signed-off-by: Kouei Abe <kouei.abe.cp@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* No change

 drivers/net/ethernet/renesas/sh_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 3c0a24a..7aebbe0 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -416,6 +416,7 @@ static struct sh_eth_cpu_data r8a7790_data = {
 	.tpauser	= 1,
 	.hw_swap	= 1,
 	.rmiimode	= 1,
+	.shift_rd0	= 1,
 };
 
 static void sh_eth_set_rate_sh7724(struct net_device *ndev)
-- 
1.8.4.rc4

