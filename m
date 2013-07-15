From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Jul 2013 23:39:58 +0000
Subject: [PATCH 10/19] sh-pfc: Consolidate pin definition macros
Message-Id: <1373931607-4599-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the pin definition macros to a common header file.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 11 ++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 25 +++++++++----------------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 25 +++++++++----------------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 23 ++++++++---------------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  8 ++++++++
 5 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index d811533..288821b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -1266,19 +1266,12 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(IRQ57_MARK,			PORT329_FN0),
 };
 
-#define R8A73A4_PIN(pin, cfgs)			\
-	{					\
-		.name = __stringify(PORT##pin),	\
-		.enum_id = PORT##pin##_DATA,	\
-		.configs = cfgs,		\
-	}
-
 #define __O	(SH_PFC_PIN_CFG_OUTPUT)
 #define __IO	(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
 #define __PUD	(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
 
-#define R8A73A4_PIN_IO_PU_PD(pin)       R8A73A4_PIN(pin, __IO | __PUD)
-#define R8A73A4_PIN_O(pin)              R8A73A4_PIN(pin, __O)
+#define R8A73A4_PIN_IO_PU_PD(pin)       SH_PFC_PIN_CFG(pin, __IO | __PUD)
+#define R8A73A4_PIN_O(pin)              SH_PFC_PIN_CFG(pin, __O)
 
 static struct sh_pfc_pin pinmux_pins[] = {
 	R8A73A4_PIN_IO_PU_PD(0), R8A73A4_PIN_IO_PU_PD(1),
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index e690051..b5bc1d0 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -1527,13 +1527,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(TRACEAUD_FROM_MEMC_MARK,			MSEL5CR_30_1,	MSEL5CR_29_0),
 };
 
-#define R8A7740_PIN(pin, cfgs)						\
-	{								\
-		.name = __stringify(PORT##pin),				\
-		.enum_id = PORT##pin##_DATA,				\
-		.configs = cfgs,					\
-	}
-
 #define __I		(SH_PFC_PIN_CFG_INPUT)
 #define __O		(SH_PFC_PIN_CFG_OUTPUT)
 #define __IO		(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
@@ -1541,15 +1534,15 @@ static const u16 pinmux_data[] = {
 #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
 #define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
 
-#define R8A7740_PIN_I_PD(pin)		R8A7740_PIN(pin, __I | __PD)
-#define R8A7740_PIN_I_PU(pin)		R8A7740_PIN(pin, __I | __PU)
-#define R8A7740_PIN_I_PU_PD(pin)		R8A7740_PIN(pin, __I | __PUD)
-#define R8A7740_PIN_IO(pin)		R8A7740_PIN(pin, __IO)
-#define R8A7740_PIN_IO_PD(pin)		R8A7740_PIN(pin, __IO | __PD)
-#define R8A7740_PIN_IO_PU(pin)		R8A7740_PIN(pin, __IO | __PU)
-#define R8A7740_PIN_IO_PU_PD(pin)	R8A7740_PIN(pin, __IO | __PUD)
-#define R8A7740_PIN_O(pin)		R8A7740_PIN(pin, __O)
-#define R8A7740_PIN_O_PU_PD(pin)		R8A7740_PIN(pin, __O | __PUD)
+#define R8A7740_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
+#define R8A7740_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
+#define R8A7740_PIN_I_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __I | __PUD)
+#define R8A7740_PIN_IO(pin)		SH_PFC_PIN_CFG(pin, __IO)
+#define R8A7740_PIN_IO_PD(pin)		SH_PFC_PIN_CFG(pin, __IO | __PD)
+#define R8A7740_PIN_IO_PU(pin)		SH_PFC_PIN_CFG(pin, __IO | __PU)
+#define R8A7740_PIN_IO_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __IO | __PUD)
+#define R8A7740_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
+#define R8A7740_PIN_O_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __O | __PUD)
 
 static struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 56-1 (I/O and Pull U/D) */
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 9174ff2..17f1c17 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -829,13 +829,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(MFIv4_MARK,		MSEL4CR_6_1),
 };
 
-#define SH7372_PIN(pin, cfgs)						\
-	{								\
-		.name = __stringify(PORT##pin),				\
-		.enum_id = PORT##pin##_DATA,				\
-		.configs = cfgs,					\
-	}
-
 #define __I		(SH_PFC_PIN_CFG_INPUT)
 #define __O		(SH_PFC_PIN_CFG_OUTPUT)
 #define __IO		(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
@@ -843,15 +836,15 @@ static const u16 pinmux_data[] = {
 #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
 #define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
 
-#define SH7372_PIN_I_PD(pin)		SH7372_PIN(pin, __I | __PD)
-#define SH7372_PIN_I_PU(pin)		SH7372_PIN(pin, __I | __PU)
-#define SH7372_PIN_I_PU_PD(pin)		SH7372_PIN(pin, __I | __PUD)
-#define SH7372_PIN_IO(pin)		SH7372_PIN(pin, __IO)
-#define SH7372_PIN_IO_PD(pin)		SH7372_PIN(pin, __IO | __PD)
-#define SH7372_PIN_IO_PU(pin)		SH7372_PIN(pin, __IO | __PU)
-#define SH7372_PIN_IO_PU_PD(pin)	SH7372_PIN(pin, __IO | __PUD)
-#define SH7372_PIN_O(pin)		SH7372_PIN(pin, __O)
-#define SH7372_PIN_O_PU_PD(pin)		SH7372_PIN(pin, __O | __PUD)
+#define SH7372_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
+#define SH7372_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
+#define SH7372_PIN_I_PU_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PUD)
+#define SH7372_PIN_IO(pin)		SH_PFC_PIN_CFG(pin, __IO)
+#define SH7372_PIN_IO_PD(pin)		SH_PFC_PIN_CFG(pin, __IO | __PD)
+#define SH7372_PIN_IO_PU(pin)		SH_PFC_PIN_CFG(pin, __IO | __PU)
+#define SH7372_PIN_IO_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __IO | __PUD)
+#define SH7372_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
+#define SH7372_PIN_O_PU_PD(pin)		SH_PFC_PIN_CFG(pin, __O | __PUD)
 
 static struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 57-1 (I/O and Pull U/D) */
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 914b142..1d35b42 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1157,13 +1157,6 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(EDBGREQ_PU_MARK, MSEL4CR_MSEL1_1),
 };
 
-#define SH73A0_PIN(pin, cfgs)						\
-	{								\
-		.name = __stringify(PORT##pin),				\
-		.enum_id = PORT##pin##_DATA,				\
-		.configs = cfgs,					\
-	}
-
 #define __I		(SH_PFC_PIN_CFG_INPUT)
 #define __O		(SH_PFC_PIN_CFG_OUTPUT)
 #define __IO		(SH_PFC_PIN_CFG_INPUT | SH_PFC_PIN_CFG_OUTPUT)
@@ -1171,14 +1164,14 @@ static const u16 pinmux_data[] = {
 #define __PU		(SH_PFC_PIN_CFG_PULL_UP)
 #define __PUD		(SH_PFC_PIN_CFG_PULL_DOWN | SH_PFC_PIN_CFG_PULL_UP)
 
-#define SH73A0_PIN_I_PD(pin)		SH73A0_PIN(pin, __I | __PD)
-#define SH73A0_PIN_I_PU(pin)		SH73A0_PIN(pin, __I | __PU)
-#define SH73A0_PIN_I_PU_PD(pin)		SH73A0_PIN(pin, __I | __PUD)
-#define SH73A0_PIN_IO(pin)		SH73A0_PIN(pin, __IO)
-#define SH73A0_PIN_IO_PD(pin)		SH73A0_PIN(pin, __IO | __PD)
-#define SH73A0_PIN_IO_PU(pin)		SH73A0_PIN(pin, __IO | __PU)
-#define SH73A0_PIN_IO_PU_PD(pin)	SH73A0_PIN(pin, __IO | __PUD)
-#define SH73A0_PIN_O(pin)		SH73A0_PIN(pin, __O)
+#define SH73A0_PIN_I_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PD)
+#define SH73A0_PIN_I_PU(pin)		SH_PFC_PIN_CFG(pin, __I | __PU)
+#define SH73A0_PIN_I_PU_PD(pin)		SH_PFC_PIN_CFG(pin, __I | __PUD)
+#define SH73A0_PIN_IO(pin)		SH_PFC_PIN_CFG(pin, __IO)
+#define SH73A0_PIN_IO_PD(pin)		SH_PFC_PIN_CFG(pin, __IO | __PD)
+#define SH73A0_PIN_IO_PU(pin)		SH_PFC_PIN_CFG(pin, __IO | __PU)
+#define SH73A0_PIN_IO_PU_PD(pin)	SH_PFC_PIN_CFG(pin, __IO | __PUD)
+#define SH73A0_PIN_O(pin)		SH_PFC_PIN_CFG(pin, __O)
 
 static struct sh_pfc_pin pinmux_pins[] = {
 	/* Table 25-1 (I/O and Pull U/D) */
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index ebddfe0..f7c5b80 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -273,6 +273,14 @@ struct sh_pfc_soc_info {
 		.enum_id = data_or_mark,				\
 	}
 
+/* SH_PFC_PIN_CFG - Expand to a sh_pfc_pin entry (named PORT#) with config */
+#define SH_PFC_PIN_CFG(pin, cfgs)					\
+	{								\
+		.name = __stringify(PORT##pin),				\
+		.enum_id = PORT##pin##_DATA,				\
+		.configs = cfgs,					\
+	}
+
 /* PINMUX_DATA_ALL - Expand to a list of PORT_name_DATA, PORT_name_FN0,
  *		     PORT_name_OUT, PORT_name_IN marks
  */
-- 
1.8.1.5

