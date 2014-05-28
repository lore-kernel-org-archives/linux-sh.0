From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:42 +0000
Subject: [PATCH 07/11] i2c: rcar: refactor status bit handling
Message-Id: <1401263086-13720-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The old macros made it harder to see what was actually happening.
Replace them with something more readable.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index f7b14d049d5c..e82d64b5acef 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -87,6 +87,9 @@
 #define RCAR_IRQ_RECV	(MNRE | MALE | MSTE | MATE | MDRE)
 #define RCAR_IRQ_STOP	(MSTE)
 
+#define RCAR_IRQ_ACK_SEND	(~(MAT | MDE))
+#define RCAR_IRQ_ACK_RECV	(~(MAT | MDR))
+
 /*
  * flags
  */
@@ -268,27 +271,18 @@ scgd_find:
  *		status functions
  */
 
-#define rcar_i2c_status_clear(priv) rcar_i2c_status_bit_clear(priv, 0xffffffff)
-static void rcar_i2c_status_bit_clear(struct rcar_i2c_priv *priv, u32 bit)
-{
-	rcar_i2c_write(priv, ICMSR, ~bit);
-}
-
 static int rcar_i2c_prepare_msg(struct rcar_i2c_priv *priv)
 {
 	int read = !!rcar_i2c_is_recv(priv);
 
 	rcar_i2c_write(priv, ICMAR, (priv->msg->addr << 1) | read);
-	rcar_i2c_status_clear(priv);
+	rcar_i2c_write(priv, ICMSR, 0);
 	rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_START);
 	rcar_i2c_write(priv, ICMIER, read ? RCAR_IRQ_RECV : RCAR_IRQ_SEND);
 
 	return 0;
 }
 
-#define rcar_i2c_send_restart(priv) rcar_i2c_status_bit_clear(priv, (MAT | MDE))
-#define rcar_i2c_recv_restart(priv) rcar_i2c_status_bit_clear(priv, (MAT | MDR))
-
 /*
  *		interrupt functions
  */
@@ -348,7 +342,7 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 			return ID_DONE;
 	}
 
-	rcar_i2c_send_restart(priv);
+	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_SEND);
 
 	return 0;
 }
@@ -389,7 +383,7 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 	else
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
-	rcar_i2c_recv_restart(priv);
+	rcar_i2c_write(priv, ICMSR, RCAR_IRQ_ACK_RECV);
 
 	return 0;
 }
@@ -452,7 +446,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 out:
 	if (rcar_i2c_flags_has(priv, ID_DONE)) {
 		rcar_i2c_write(priv, ICMIER, 0);
-		rcar_i2c_status_clear(priv);
+		rcar_i2c_write(priv, ICMSR, 0);
 		wake_up(&priv->wait);
 	}
 
-- 
2.0.0.rc2

