From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:38:43 +0000
Subject: [GIT PULL 26/26] ARM: shmobile: sh73a0: Remove global GPIO_NR definition
Message-Id: <282b583f752f996ee5c33b0cdc18adf3b5094ee0.1375840527.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1375840527.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1375840527.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The total number of SoC GPIOs is only used to compute the base GPIO
number of th PCF8575 GPIO extender on the KZM9G board. As GPIO
allocation became fully dynamic with DT, no other SH73A0 board will use
the GPIO_NR macro. Move it to the KZM9G board file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c         | 16 ++++++++--------
 arch/arm/mach-shmobile/include/mach/sh73a0.h |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 1068120..f199496 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -54,14 +54,14 @@
 /*
  * external GPIO
  */
-#define GPIO_PCF8575_BASE	(GPIO_NR)
-#define GPIO_PCF8575_PORT10	(GPIO_NR + 8)
-#define GPIO_PCF8575_PORT11	(GPIO_NR + 9)
-#define GPIO_PCF8575_PORT12	(GPIO_NR + 10)
-#define GPIO_PCF8575_PORT13	(GPIO_NR + 11)
-#define GPIO_PCF8575_PORT14	(GPIO_NR + 12)
-#define GPIO_PCF8575_PORT15	(GPIO_NR + 13)
-#define GPIO_PCF8575_PORT16	(GPIO_NR + 14)
+#define GPIO_PCF8575_BASE	(310)
+#define GPIO_PCF8575_PORT10	(GPIO_PCF8575_BASE + 8)
+#define GPIO_PCF8575_PORT11	(GPIO_PCF8575_BASE + 9)
+#define GPIO_PCF8575_PORT12	(GPIO_PCF8575_BASE + 10)
+#define GPIO_PCF8575_PORT13	(GPIO_PCF8575_BASE + 11)
+#define GPIO_PCF8575_PORT14	(GPIO_PCF8575_BASE + 12)
+#define GPIO_PCF8575_PORT15	(GPIO_PCF8575_BASE + 13)
+#define GPIO_PCF8575_PORT16	(GPIO_PCF8575_BASE + 14)
 
 /* Dummy supplies, where voltage doesn't matter */
 static struct regulator_consumer_supply dummy_supplies[] = {
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 680dc5f..359b582 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_SH73A0_H__
 #define __ASM_SH73A0_H__
 
-#define GPIO_NR			310
-
 /* DMA slave IDs */
 enum {
 	SHDMA_SLAVE_INVALID,
-- 
1.8.3.2

