From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:44 +0000
Subject: [PATCH 09/11] i2c: rcar: reuse status bits as enable bits
Message-Id: <1401263086-13720-10-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Status register and enable register are identical regarding their
layout. Use the bit definitions for both.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 4b088e67f2fd..d489d54ebc6f 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -59,7 +59,7 @@
 #define FSB	(1 << 1)	/* force stop bit */
 #define ESG	(1 << 0)	/* en startbit gen */
 
-/* ICMSR */
+/* ICMSR (also for ICMIE) */
 #define MNR	(1 << 6)	/* nack received */
 #define MAL	(1 << 5)	/* arbitration lost */
 #define MST	(1 << 4)	/* sent a stop */
@@ -68,23 +68,14 @@
 #define MDR	(1 << 1)
 #define MAT	(1 << 0)	/* slave addr xfer done */
 
-/* ICMIE */
-#define MNRE	(1 << 6)	/* nack irq en */
-#define MALE	(1 << 5)	/* arblos irq en */
-#define MSTE	(1 << 4)	/* stop irq en */
-#define MDEE	(1 << 3)
-#define MDTE	(1 << 2)
-#define MDRE	(1 << 1)
-#define MATE	(1 << 0)	/* address sent irq en */
-
 
 #define RCAR_BUS_PHASE_START	(MDBS | MIE | ESG)
 #define RCAR_BUS_PHASE_DATA	(MDBS | MIE)
 #define RCAR_BUS_PHASE_STOP	(MDBS | MIE | FSB)
 
-#define RCAR_IRQ_SEND	(MNRE | MALE | MSTE | MATE | MDEE)
-#define RCAR_IRQ_RECV	(MNRE | MALE | MSTE | MATE | MDRE)
-#define RCAR_IRQ_STOP	(MSTE)
+#define RCAR_IRQ_SEND	(MNR | MAL | MST | MAT | MDE)
+#define RCAR_IRQ_RECV	(MNR | MAL | MST | MAT | MDR)
+#define RCAR_IRQ_STOP	(MST)
 
 #define RCAR_IRQ_ACK_SEND	(~(MAT | MDE))
 #define RCAR_IRQ_ACK_RECV	(~(MAT | MDR))
-- 
2.0.0.rc2

