From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:50:39 +0000
Subject: [PATCH v3 05/81] sh: sh7786: Fix port E, G and J GPIOs
Message-Id: <1355611915-25060-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The port E, G and J GPIOs don't match the SoC datasheet (they seem to
have been copied from the SH7785). Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/sh/include/cpu-sh4/cpu/sh7786.h    |    8 +++-----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    4 ++--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index 977862f..0df09e6 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -32,16 +32,14 @@ enum {
 	GPIO_PD3, GPIO_PD2, GPIO_PD1, GPIO_PD0,
 
 	/* PE */
-	GPIO_PE5, GPIO_PE4, GPIO_PE3, GPIO_PE2,
-	GPIO_PE1, GPIO_PE0,
+	GPIO_PE7, GPIO_PE6,
 
 	/* PF */
 	GPIO_PF7, GPIO_PF6, GPIO_PF5, GPIO_PF4,
 	GPIO_PF3, GPIO_PF2, GPIO_PF1, GPIO_PF0,
 
 	/* PG */
-	GPIO_PG7, GPIO_PG6, GPIO_PG5, GPIO_PG4,
-	GPIO_PG3, GPIO_PG2, GPIO_PG1, GPIO_PG0,
+	GPIO_PG7, GPIO_PG6, GPIO_PG5,
 
 	/* PH */
 	GPIO_PH7, GPIO_PH6, GPIO_PH5, GPIO_PH4,
@@ -49,7 +47,7 @@ enum {
 
 	/* PJ */
 	GPIO_PJ7, GPIO_PJ6, GPIO_PJ5, GPIO_PJ4,
-	GPIO_PJ3, GPIO_PJ2, GPIO_PJ1, GPIO_PJ0,
+	GPIO_PJ3, GPIO_PJ2, GPIO_PJ1,
 
 	/* DU */
 	GPIO_FN_DCLKIN, GPIO_FN_DCLKOUT, GPIO_FN_ODDF,
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
index 4229e07..c24a777 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
@@ -468,8 +468,8 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	PINMUX_GPIO(GPIO_PD0, PD0_DATA),
 
 	/* PE */
-	PINMUX_GPIO(GPIO_PE5, PE7_DATA),
-	PINMUX_GPIO(GPIO_PE4, PE6_DATA),
+	PINMUX_GPIO(GPIO_PE7, PE7_DATA),
+	PINMUX_GPIO(GPIO_PE6, PE6_DATA),
 
 	/* PF */
 	PINMUX_GPIO(GPIO_PF7, PF7_DATA),
-- 
1.7.8.6

