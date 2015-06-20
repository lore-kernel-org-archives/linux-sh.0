From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 20 Jun 2015 00:34:55 +0000
Subject: [PATCH 3/3] rcar_can: fix typo in error message
Message-Id: <7487668.8ZFbI2F5E8@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2010452.WyFito6egU@wasted.cogentembedded.com>
In-Reply-To: <2010452.WyFito6egU@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Fix typo in the first error message printed by rcar_can_open().

Based on the original patch by Vladimir Barinov.

Fixes: 862e2b6af941 ("can: rcar_can: support all input clocks")
Reported-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/can/rcar_can.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-can/drivers/net/can/rcar_can.c
=================================--- linux-can.orig/drivers/net/can/rcar_can.c
+++ linux-can/drivers/net/can/rcar_can.c
@@ -508,7 +508,8 @@ static int rcar_can_open(struct net_devi
 
 	err = clk_prepare_enable(priv->clk);
 	if (err) {
-		netdev_err(ndev, "failed to enable periperal clock, error %d\n",
+		netdev_err(ndev,
+			   "failed to enable peripheral clock, error %d\n",
 			   err);
 		goto out;
 	}

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
