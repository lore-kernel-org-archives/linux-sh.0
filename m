From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 19 Nov 2015 15:56:47 +0000
Subject: [PATCH v3 07/11] i2c: rcar: don't issue stop when HW does it automatically
Message-Id: <1447948611-2615-8-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The manual says (55.4.8.6) that HW does automatically send STOP after
NACK was received. My measuerments confirm that.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d91acc11631554..87fccf20fc4c34 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -455,8 +455,8 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 
 	/* Nack */
 	if (msr & MNR) {
-		/* go to stop phase */
-		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_STOP);
+		/* HW automatically sends STOP after received NACK */
+		rcar_i2c_write(priv, ICMCR, RCAR_BUS_PHASE_DATA);
 		rcar_i2c_write(priv, ICMIER, RCAR_IRQ_STOP);
 		rcar_i2c_flags_set(priv, ID_NACK);
 		goto out;
-- 
2.1.4

