From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2012 09:37:16 +0000
Subject: [PATCH 13/27 v2] ARM: shmobile: r8a7740: add FSI-B (for HDMI) GPIO support
Message-Id: <87oboox453.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In order to enable FSI-B selection from platform board,
this patch adds its interface to GPIO framework.

This patch is based on v1.0 manual

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/mach-shmobile/include/mach/r8a7740.h |    5 ++++-
 arch/arm/mach-shmobile/pfc-r8a7740.c          |   11 +++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 2764846..6468fcc 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -139,7 +139,7 @@ enum {
 	GPIO_FN_DBGMD10,	GPIO_FN_DBGMD11,	GPIO_FN_DBGMD20,
 	GPIO_FN_DBGMD21,
 
-	/* FSI */
+	/* FSI-A */
 	GPIO_FN_FSIAISLD_PORT0,		/* FSIAISLD Port 0/5 */
 	GPIO_FN_FSIAISLD_PORT5,
 	GPIO_FN_FSIASPDIF_PORT9,	/* FSIASPDIF Port 9/18 */
@@ -150,6 +150,9 @@ enum {
 	GPIO_FN_FSIACK,		GPIO_FN_FSIAILR,
 	GPIO_FN_FSIAIBT,
 
+	/* FSI-B */
+	GPIO_FN_FSIBCK,
+
 	/* FMSI */
 	GPIO_FN_FMSISLD_PORT1, /* FMSISLD Port 1/6 */
 	GPIO_FN_FMSISLD_PORT6,
diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index 0dda816..03def0f 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -169,7 +169,7 @@ enum {
 	DBGMD10_MARK,	DBGMD11_MARK,	DBGMD20_MARK,
 	DBGMD21_MARK,
 
-	/* FSI */
+	/* FSI-A */
 	FSIAISLD_PORT0_MARK,	/* FSIAISLD Port 0/5 */
 	FSIAISLD_PORT5_MARK,
 	FSIASPDIF_PORT9_MARK,	/* FSIASPDIF Port 9/18 */
@@ -178,6 +178,9 @@ enum {
 	FSIAOBT_MARK,	FSIAOSLD_MARK,	FSIAOMC_MARK,
 	FSIACK_MARK,	FSIAILR_MARK,	FSIAIBT_MARK,
 
+	/* FSI-B */
+	FSIBCK_MARK,
+
 	/* FMSI */
 	FMSISLD_PORT1_MARK, /* FMSISLD Port 1/6 */
 	FMSISLD_PORT6_MARK,
@@ -774,6 +777,7 @@ static pinmux_enum_t pinmux_data[] = {
 
 	/* Port11 */
 	PINMUX_DATA(FSIACK_MARK,		PORT11_FN1),
+	PINMUX_DATA(FSIBCK_MARK,		PORT11_FN2),
 	PINMUX_DATA(IRQ2_PORT11_MARK,		PORT11_FN0,	MSEL1CR_2_0),
 
 	/* Port12 */
@@ -1696,7 +1700,7 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(DBGMD10),	GPIO_FN(DBGMD11),	GPIO_FN(DBGMD20),
 	GPIO_FN(DBGMD21),
 
-	/* FSI */
+	/* FSI-A */
 	GPIO_FN(FSIAISLD_PORT0),	/* FSIAISLD Port 0/5 */
 	GPIO_FN(FSIAISLD_PORT5),
 	GPIO_FN(FSIASPDIF_PORT9),	/* FSIASPDIF Port 9/18 */
@@ -1705,6 +1709,9 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(FSIAOBT),	GPIO_FN(FSIAOSLD),	GPIO_FN(FSIAOMC),
 	GPIO_FN(FSIACK),	GPIO_FN(FSIAILR),	GPIO_FN(FSIAIBT),
 
+	/* FSI-B */
+	GPIO_FN(FSIBCK),
+
 	/* FMSI */
 	GPIO_FN(FMSISLD_PORT1), /* FMSISLD Port 1/6 */
 	GPIO_FN(FMSISLD_PORT6),
-- 
1.7.5.4

