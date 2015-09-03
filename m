From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Sep 2015 20:20:12 +0000
Subject: [PATCH 8/9] i2c: rcar: revoke START request early
Message-Id: <1441311613-2681-9-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

If we don't clear START generation as soon as possible, it may cause
another message to be generated. To keep the race window as small as
possible, we clear it right at the beginning of the interrupt. We don't
need checking since we always want to stop START and STOP generation on
the next occasion after we started it.

This patch improves the situation but sadly does not completely fix it.
It is still to be researched if we can do better given this HW design.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 06bd8c45c6af9d..2afa3683a3de4e 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -84,6 +84,7 @@
 
 #define RCAR_BUS_PHASE_START	(MDBS | MIE | ESG)
 #define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
+#define RCAR_BUS_MASK_DATA	(~(ESG | FSB) & 0xFF)
 #define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
 #define RCAR_IRQ_SEND	(MNR | MAL | MST | MAT | MDE)
@@ -288,13 +289,6 @@ static int rcar_i2c_irq_send(struct rcar_i2c_priv *priv, u32 msr)
 	if (!(msr & MDE))
 		return 0;
 
-	/*
-	 * If address transfer phase finished,
-	 * goto data phase.
-	 */
-	if (msr & MAT)
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
-
 	if (priv->pos < msg->len) {
 		/*
 		 * Prepare next data to ICRXTX register.
@@ -346,11 +340,7 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 		return 0;
 
 	if (msr & MAT) {
-		/*
-		 * Address transfer phase finished,
-		 * but, there is no data at this point.
-		 * Do nothing.
-		 */
+		/* Address transfer phase finished, but no data at this point. */
 	} else if (priv->pos < msg->len) {
 		/*
 		 * get received data
@@ -366,8 +356,6 @@ static int rcar_i2c_irq_recv(struct rcar_i2c_priv *priv, u32 msr)
 	 */
 	if (priv->pos + 1 >= msg->len)
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-	else
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 
 	if (priv->pos = msg->len && !(priv->flags & ID_LAST_MSG))
 		rcar_i2c_next_msg(priv);
@@ -435,7 +423,11 @@ static bool rcar_i2c_slave_irq(struct rcar_i2c_priv *priv)
 static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 {
 	struct rcar_i2c_priv *priv = ptr;
-	u32 msr;
+	u32 msr, val;
+
+	/* Clear START or STOP as soon as we can */
+	val = rcar_i2c_read(priv, ICMCR);
+	rcar_i2c_write(priv, ICMCR, val & RCAR_BUS_MASK_DATA);
 
 	msr = rcar_i2c_read(priv, ICMSR);
 
@@ -457,7 +449,6 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	/* Nack */
 	if (msr & MNR) {
 		/* HW automatically sends STOP after received NACK */
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
-- 
2.1.4

