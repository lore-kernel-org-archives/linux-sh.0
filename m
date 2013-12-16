From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Dec 2013 19:25:16 +0000
Subject: [PATCH 3/4] pinctrl: sh-pfc: sh: Constify pins and cfg_regs arrays
Message-Id: <1387221917-15437-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The arrays are never modified, declare them as const.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh7203.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7722.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c | 2 +-
 drivers/pinctrl/sh-pfc/pfc-shx3.c   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7203.c b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
index bf3d8f2..3bda7ba 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7203.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7203.c
@@ -702,7 +702,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(SSCK0_PF_MARK, PF0MD_11),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PA */
 	PINMUX_GPIO(PA7),
 	PINMUX_GPIO(PA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7264.c b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
index 673a595..e1cb6dc 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7264.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7264.c
@@ -1071,7 +1071,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(SD_D2_MARK, PK0MD_10),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* Port A */
 	PINMUX_GPIO(PA3),
 	PINMUX_GPIO(PA2),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7269.c b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
index a19b60f..7a11320 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7269.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7269.c
@@ -1451,7 +1451,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(PWM1A_MARK, PJ0MD_100),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* Port A */
 	PINMUX_GPIO(PA1),
 	PINMUX_GPIO(PA0),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7720.c b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
index 7a26809..13d05f8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7720.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7720.c
@@ -576,7 +576,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(SIM_CLK_MARK, PSELD_1_0_10, PTV0_FN),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	PINMUX_GPIO(PTA7),
 	PINMUX_GPIO(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7722.c b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
index add3093..914d872 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7722.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7722.c
@@ -754,7 +754,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(KEYOUT5_IN5_MARK, HIZA14_KEYSC, KEYOUT5_IN5),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	PINMUX_GPIO(PTA7),
 	PINMUX_GPIO(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7723.c b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
index 1cecc91..4eb7eae 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7723.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7723.c
@@ -917,7 +917,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(SIUBISLD_MARK, PSD1_PSD0_FN2, PTZ0_FN),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	PINMUX_GPIO(PTA7),
 	PINMUX_GPIO(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7724.c b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
index 1085ab5..74a1a7f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7724.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7724.c
@@ -1146,7 +1146,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(SCIF3_I_TXD_MARK,	PSB14_1, PTZ3_FN),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	PINMUX_GPIO(PTA7),
 	PINMUX_GPIO(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index ec0c47c..e53dd1c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -1357,7 +1357,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_DATA(IP11_28, ST_CLKOUT),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	PINMUX_GPIO_GP_ALL(),
 };
 
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7757.c b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
index 33d75e5..625661a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7757.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7757.c
@@ -1074,7 +1074,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(ON_DQ0_MARK, PS8_8_FN2, PTZ0_FN),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PTA */
 	PINMUX_GPIO(PTA7),
 	PINMUX_GPIO(PTA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7785.c b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
index 517eb49..b38dd7e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7785.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7785.c
@@ -671,7 +671,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(IRQOUT_MARK, P2MSEL2_1),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PA */
 	PINMUX_GPIO(PA7),
 	PINMUX_GPIO(PA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7786.c b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
index 623345f..6cb4e0a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7786.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7786.c
@@ -407,7 +407,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(SSI3_SCK_MARK,	P2MSEL6_1, P2MSEL5_1, PJ1_FN),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PA */
 	PINMUX_GPIO(PA7),
 	PINMUX_GPIO(PA6),
diff --git a/drivers/pinctrl/sh-pfc/pfc-shx3.c b/drivers/pinctrl/sh-pfc/pfc-shx3.c
index 55262bd..a3fcb22 100644
--- a/drivers/pinctrl/sh-pfc/pfc-shx3.c
+++ b/drivers/pinctrl/sh-pfc/pfc-shx3.c
@@ -285,7 +285,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(IRQOUT_MARK,	PH0_FN),
 };
 
-static struct sh_pfc_pin pinmux_pins[] = {
+static const struct sh_pfc_pin pinmux_pins[] = {
 	/* PA */
 	PINMUX_GPIO(PA7),
 	PINMUX_GPIO(PA6),
-- 
1.8.3.2

