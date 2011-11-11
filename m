From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:45:43 +0000
Subject: [PATCH 10/20] ARM: mach-shmobile: move helper macro PORTCR to sh_pfc.h
Message-Id: <87mxc39y23.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/pfc-sh7367.c |   16 ----------------
 arch/arm/mach-shmobile/pfc-sh7372.c |   16 ----------------
 arch/arm/mach-shmobile/pfc-sh7377.c |   17 -----------------
 arch/arm/mach-shmobile/pfc-sh73a0.c |   12 ------------
 include/linux/sh_pfc.h              |   17 +++++++++++++++++
 5 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7367.c b/arch/arm/mach-shmobile/pfc-sh7367.c
index 32fbf02..e6e5246 100644
--- a/arch/arm/mach-shmobile/pfc-sh7367.c
+++ b/arch/arm/mach-shmobile/pfc-sh7367.c
@@ -1287,22 +1287,6 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(DIVLOCK),
 };
 
-/* helper for top 4 bits in PORTnCR */
-#define PCRH(in, in_pd, in_pu, out)		\
-	0, (out), (in), 0,			\
-	0, 0, 0, 0,				\
-	0, 0, (in_pd), 0,			\
-	0, 0, (in_pu), 0
-
-#define PORTCR(nr, reg)						\
-	{ PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
-		PCRH(PORT##nr##_IN, PORT##nr##_IN_PD,		\
-		     PORT##nr##_IN_PU, PORT##nr##_OUT),		\
-		PORT##nr##_FN0, PORT##nr##_FN1, PORT##nr##_FN2,	\
-		PORT##nr##_FN3,	PORT##nr##_FN4, PORT##nr##_FN5,	\
-		PORT##nr##_FN6, PORT##nr##_FN7 }		\
-	}
-
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(0, 0xe6050000), /* PORT0CR */
 	PORTCR(1, 0xe6050001), /* PORT1CR */
diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 4b43626..1bd6585 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -1199,22 +1199,6 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(SDENC_DV_CLKI),
 };
 
-/* helper for top 4 bits in PORTnCR */
-#define PCRH(in, in_pd, in_pu, out)		\
-	0, (out), (in), 0,			\
-	0, 0, 0, 0,				\
-	0, 0, (in_pd), 0,			\
-	0, 0, (in_pu), 0
-
-#define PORTCR(nr, reg)						\
-	{ PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
-		PCRH(PORT##nr##_IN, PORT##nr##_IN_PD,		\
-		     PORT##nr##_IN_PU, PORT##nr##_OUT),		\
-		PORT##nr##_FN0, PORT##nr##_FN1, PORT##nr##_FN2,	\
-		PORT##nr##_FN3,	PORT##nr##_FN4, PORT##nr##_FN5,	\
-		PORT##nr##_FN6, PORT##nr##_FN7 }		\
-	}
-
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(0,	0xE6051000), /* PORT0CR */
 	PORTCR(1,	0xE6051001), /* PORT1CR */
diff --git a/arch/arm/mach-shmobile/pfc-sh7377.c b/arch/arm/mach-shmobile/pfc-sh7377.c
index fb3cfd3..2f10511 100644
--- a/arch/arm/mach-shmobile/pfc-sh7377.c
+++ b/arch/arm/mach-shmobile/pfc-sh7377.c
@@ -1300,23 +1300,6 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(RESETOUTS),
 };
 
-/* helper for top 4 bits in PORTnCR */
-#define PCRH(in, in_pd, in_pu, out)	\
-	0, (out), (in), 0,	\
-		0, 0, 0, 0,	\
-		0, 0, (in_pd), 0,	\
-		0, 0, (in_pu), 0
-
-#define PORTCR(nr, reg)	\
-	{ PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {	\
-			PCRH(PORT##nr##_IN, PORT##nr##_IN_PD,	\
-				 PORT##nr##_IN_PU, PORT##nr##_OUT),	\
-				PORT##nr##_FN0, PORT##nr##_FN1,	\
-				PORT##nr##_FN2, PORT##nr##_FN3,	\
-				PORT##nr##_FN4, PORT##nr##_FN5,	\
-				PORT##nr##_FN6, PORT##nr##_FN7 }	\
-	}
-
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(0, 0xe6050000), /* PORT0CR */
 	PORTCR(1, 0xe6050001), /* PORT1CR */
diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index a1ea119..e05634c 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -2221,18 +2221,6 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(FSIAISLD_PU),
 };
 
-#define PORTCR(nr, reg)	\
-	{ PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) { \
-		0, \
-		/*0001*/ PORT##nr##_OUT , \
-		/*0010*/ PORT##nr##_IN , 0, 0, 0, 0, 0, 0, 0, \
-		/*1010*/ PORT##nr##_IN_PD, 0, 0, 0, \
-		/*1110*/ PORT##nr##_IN_PU, 0, \
-		PORT##nr##_FN0, PORT##nr##_FN1,	PORT##nr##_FN2, \
-		PORT##nr##_FN3,	PORT##nr##_FN4, PORT##nr##_FN5, \
-		PORT##nr##_FN6, PORT##nr##_FN7, 0, 0, 0, 0, 0, 0, 0, 0 } \
-	}
-
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
 	PORTCR(0, 0xe6050000), /* PORT0CR */
 	PORTCR(1, 0xe6050001), /* PORT1CR */
diff --git a/include/linux/sh_pfc.h b/include/linux/sh_pfc.h
index 5f6322a..8446789 100644
--- a/include/linux/sh_pfc.h
+++ b/include/linux/sh_pfc.h
@@ -162,5 +162,22 @@ int unregister_pinmux(struct pinmux_info *pip);
 	PINMUX_DATA(PORT##nr##_DATA, PORT##nr##_FN0, PORT##nr##_OUT,	\
 		    PORT##nr##_IN, PORT##nr##_IN_PD, PORT##nr##_IN_PU)
 
+/* helper macro for top 4 bits in PORTnCR */
+#define _PCRH(in, in_pd, in_pu, out)	\
+	0, (out), (in), 0,		\
+	0, 0, 0, 0,			\
+	0, 0, (in_pd), 0,		\
+	0, 0, (in_pu), 0
+
+#define PORTCR(nr, reg)							\
+	{								\
+		PINMUX_CFG_REG("PORT" nr "CR", reg, 8, 4) {		\
+			_PCRH(PORT##nr##_IN, PORT##nr##_IN_PD,		\
+			      PORT##nr##_IN_PU, PORT##nr##_OUT),	\
+				PORT##nr##_FN0, PORT##nr##_FN1,		\
+				PORT##nr##_FN2, PORT##nr##_FN3,		\
+				PORT##nr##_FN4, PORT##nr##_FN5,		\
+				PORT##nr##_FN6, PORT##nr##_FN7 }	\
+	}
 
 #endif /* __SH_PFC_H */
-- 
1.7.5.4

