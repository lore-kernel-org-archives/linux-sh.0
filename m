From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 15 Feb 2015 14:44:40 +0000
Subject: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Message-Id: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>

Even if R-Car I2C received NACK, after that it might receive ACK
by HW auto restart. In case of that, driver would continue process.
If R-Car I2C didn't receive ACK, the driver would detect timeout
and would report NACK as -ENXIO.

Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on i2c/for-next branch of Wolfram Sang's linux tree.

 drivers/i2c/busses/i2c-rcar.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 71a6e07..dde8abf 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -455,14 +455,20 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	if (msr & MNR) {
 		/* go to stop phase */
 		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
-		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
 	}
 
 	/* Stop */
 	if (msr & MST) {
-		rcar_i2c_flags_set(priv, ID_DONE);
+		if (rcar_i2c_flags_has(priv, ID_NACK)) {
+			/* don't set ID_DONE for expecting ACK
+					after auto-restart by HW */
+			rcar_i2c_write(priv, ICMSR, ~MST);
+		} else {
+			rcar_i2c_flags_set(priv, ID_DONE);
+			rcar_i2c_write(priv, ICMSR, 0);
+		}
 		goto out;
 	}
 
@@ -536,15 +542,14 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
 					     rcar_i2c_flags_has(priv, ID_DONE),
 					     5 * HZ);
 		if (!timeout) {
+			if (rcar_i2c_flags_has(priv, ID_NACK)) {
+				ret = -ENXIO;
+				break;
+			}
 			ret = -ETIMEDOUT;
 			break;
 		}
 
-		if (rcar_i2c_flags_has(priv, ID_NACK)) {
-			ret = -ENXIO;
-			break;
-		}
-
 		if (rcar_i2c_flags_has(priv, ID_ARBLOST)) {
 			ret = -EAGAIN;
 			break;
-- 
1.9.1

