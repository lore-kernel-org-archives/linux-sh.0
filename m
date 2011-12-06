From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Dec 2011 16:52:49 +0000
Subject: [PATCH 06/07] ARM: mach-shmobile: r8a7779 PFC ioremap() workaround
Message-Id: <20111206165249.19348.79956.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Since the common pfc code does not support ioremap(),
hack the code to make use of the serial debug console
mapping. Magically makes the r8a7779 PFC code work.

Will be dropped when the pfc code knows how to ioremap().

Never-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pfc-r8a7779.c |   42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

--- 0010/arch/arm/mach-shmobile/pfc-r8a7779.c
+++ work/arch/arm/mach-shmobile/pfc-r8a7779.c	2011-12-07 00:21:46.000000000 +0900
@@ -163,7 +163,7 @@ static struct pinmux_gpio pinmux_gpios[]
 };
 
 static struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xffc00004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xfdc00004, 32, 1) {
 		GP_0_31_FN, FN_IP3_31_29,
 		GP_0_30_FN, FN_IP3_26_24,
 		GP_0_29_FN, FN_IP3_22_21,
@@ -197,7 +197,7 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_0_1_FN, FN_AVS2,
 		GP_0_0_FN, FN_AVS1 }
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xffc00008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xfdc00008, 32, 1) {
 		GP_1_31_FN, FN_IP5_23_21,
 		GP_1_30_FN, FN_IP5_20_17,
 		GP_1_29_FN, FN_IP5_16_15,
@@ -231,7 +231,7 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_1_1_FN, FN_IP4_4_2,
 		GP_1_0_FN, FN_IP4_1_0 }
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xffc0000c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xfdc0000c, 32, 1) {
 		GP_2_31_FN, FN_IP10_28_26,
 		GP_2_30_FN, FN_IP10_25_24,
 		GP_2_29_FN, FN_IP10_23_21,
@@ -265,7 +265,7 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_2_1_FN, FN_IP8_20,
 		GP_2_0_FN, FN_IP5_27_24 }
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xffc00010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xfdc00010, 32, 1) {
 		GP_3_31_FN, FN_IP6_3_2,
 		GP_3_30_FN, FN_IP6_1_0,
 		GP_3_29_FN, FN_IP5_30_29,
@@ -299,7 +299,7 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_3_1_FN, FN_IP11_2_0,
 		GP_3_0_FN, FN_IP10_31_29 }
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xffc00014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xfdc00014, 32, 1) {
 		GP_4_31_FN, FN_IP8_19,
 		GP_4_30_FN, FN_IP8_18,
 		GP_4_29_FN, FN_IP8_17_16,
@@ -333,7 +333,7 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_4_1_FN, FN_IP6_7_6,
 		GP_4_0_FN, FN_IP6_5_4 }
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xffc00018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xfdc00018, 32, 1) {
 		GP_5_31_FN, FN_IP3_5,
 		GP_5_30_FN, FN_IP3_4,
 		GP_5_29_FN, FN_IP3_3,
@@ -367,7 +367,7 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_5_1_FN, FN_A2,
 		GP_5_0_FN, FN_A1 }
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xffc0001c, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xfdc0001c, 32, 1) {
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -384,13 +384,13 @@ static struct pinmux_cfg_reg pinmux_conf
 		GP_6_1_FN, FN_IP3_7,
 		GP_6_0_FN, FN_IP3_6 }
 	},
-	{ PINMUX_CFG_REG("INOUTSEL0", 0xffc40004, 32, 1) { GP_INOUTSEL(0) } },
-	{ PINMUX_CFG_REG("INOUTSEL1", 0xffc41004, 32, 1) { GP_INOUTSEL(1) } },
-	{ PINMUX_CFG_REG("INOUTSEL2", 0xffc42004, 32, 1) { GP_INOUTSEL(2) } },
-	{ PINMUX_CFG_REG("INOUTSEL3", 0xffc43004, 32, 1) { GP_INOUTSEL(3) } },
-	{ PINMUX_CFG_REG("INOUTSEL4", 0xffc44004, 32, 1) { GP_INOUTSEL(4) } },
-	{ PINMUX_CFG_REG("INOUTSEL5", 0xffc45004, 32, 1) { GP_INOUTSEL(5) } },
-	{ PINMUX_CFG_REG("INOUTSEL6", 0xffc46004, 32, 1) {
+	{ PINMUX_CFG_REG("INOUTSEL0", 0xfdc40004, 32, 1) { GP_INOUTSEL(0) } },
+	{ PINMUX_CFG_REG("INOUTSEL1", 0xfdc41004, 32, 1) { GP_INOUTSEL(1) } },
+	{ PINMUX_CFG_REG("INOUTSEL2", 0xfdc42004, 32, 1) { GP_INOUTSEL(2) } },
+	{ PINMUX_CFG_REG("INOUTSEL3", 0xfdc43004, 32, 1) { GP_INOUTSEL(3) } },
+	{ PINMUX_CFG_REG("INOUTSEL4", 0xfdc44004, 32, 1) { GP_INOUTSEL(4) } },
+	{ PINMUX_CFG_REG("INOUTSEL5", 0xfdc45004, 32, 1) { GP_INOUTSEL(5) } },
+	{ PINMUX_CFG_REG("INOUTSEL6", 0xfdc46004, 32, 1) {
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, 0,
@@ -411,13 +411,13 @@ static struct pinmux_cfg_reg pinmux_conf
 };
 
 static struct pinmux_data_reg pinmux_data_regs[] = {
-	{ PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
-	{ PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
-	{ PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
-	{ PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
-	{ PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
-	{ PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
-	{ PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
+	{ PINMUX_DATA_REG("INDT0", 0xfdc40008, 32) { GP_INDT(0) } },
+	{ PINMUX_DATA_REG("INDT1", 0xfdc41008, 32) { GP_INDT(1) } },
+	{ PINMUX_DATA_REG("INDT2", 0xfdc42008, 32) { GP_INDT(2) } },
+	{ PINMUX_DATA_REG("INDT3", 0xfdc43008, 32) { GP_INDT(3) } },
+	{ PINMUX_DATA_REG("INDT4", 0xfdc44008, 32) { GP_INDT(4) } },
+	{ PINMUX_DATA_REG("INDT5", 0xfdc45008, 32) { GP_INDT(5) } },
+	{ PINMUX_DATA_REG("INDT6", 0xfdc46008, 32) {
 		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
 		0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
 		GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
