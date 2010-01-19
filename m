From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Jan 2010 07:31:13 +0000
Subject: [PATCH] sh: add high impedance mode management for SIUA pins on
Message-Id: <Pine.LNX.4.64.1001190828360.4607@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This improves power management for the SIUA controller on sh7722. Similar 
patches might be desired for other SIU-enabled SH platforms.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
index cb9d07b..0688a75 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7722.c
@@ -278,6 +278,7 @@ enum {
 	HIZA8_LCDC, HIZA8_HIZ,
 	HIZA7_LCDC, HIZA7_HIZ,
 	HIZA6_LCDC, HIZA6_HIZ,
+	HIZB4_SIUA, HIZB4_HIZ,
 	HIZB1_VIO, HIZB1_HIZ,
 	HIZB0_VIO, HIZB0_HIZ,
 	HIZC15_IRQ7, HIZC15_HIZ,
@@ -546,7 +547,7 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(VIO_VD2_MARK, PSE3_VIO, MSELB9_VIO2,
 		    HIZB0_VIO, FOE_VIO_VD2),
 	PINMUX_DATA(VIO_HD2_MARK, PSE3_VIO, MSELB9_VIO2,
-		    HIZB1_VIO, HIZB1_VIO, FCE_VIO_HD2),
+		    HIZB1_VIO, FCE_VIO_HD2),
 	PINMUX_DATA(VIO_CLK2_MARK, PSE3_VIO, MSELB9_VIO2,
 		    HIZB1_VIO, FRB_VIO_CLK2),
 
@@ -658,14 +659,14 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(SDHICLK_MARK, SDHICLK),
 
 	/* SIU - Port A */
-	PINMUX_DATA(SIUAOLR_MARK, PSC13_SIUAOLR, SIUAOLR_SIOF1_SYNC),
-	PINMUX_DATA(SIUAOBT_MARK, PSC14_SIUAOBT, SIUAOBT_SIOF1_SCK),
-	PINMUX_DATA(SIUAISLD_MARK, PSC15_SIUAISLD, SIUAISLD_SIOF1_RXD),
-	PINMUX_DATA(SIUAILR_MARK, PSC11_SIUAILR, SIUAILR_SIOF1_SS2),
-	PINMUX_DATA(SIUAIBT_MARK, PSC12_SIUAIBT, SIUAIBT_SIOF1_SS1),
-	PINMUX_DATA(SIUAOSLD_MARK, PSB0_SIUAOSLD, SIUAOSLD_SIOF1_TXD),
-	PINMUX_DATA(SIUMCKA_MARK, PSE11_SIUMCKA_SIOF1_MCK, PSB1_SIUMCKA, PTK0),
-	PINMUX_DATA(SIUFCKA_MARK, PSE11_SIUFCKA, PTK0),
+	PINMUX_DATA(SIUAOLR_MARK, PSC13_SIUAOLR, HIZB4_SIUA, SIUAOLR_SIOF1_SYNC),
+	PINMUX_DATA(SIUAOBT_MARK, PSC14_SIUAOBT, HIZB4_SIUA, SIUAOBT_SIOF1_SCK),
+	PINMUX_DATA(SIUAISLD_MARK, PSC15_SIUAISLD, HIZB4_SIUA, SIUAISLD_SIOF1_RXD),
+	PINMUX_DATA(SIUAILR_MARK, PSC11_SIUAILR, HIZB4_SIUA, SIUAILR_SIOF1_SS2),
+	PINMUX_DATA(SIUAIBT_MARK, PSC12_SIUAIBT, HIZB4_SIUA, SIUAIBT_SIOF1_SS1),
+	PINMUX_DATA(SIUAOSLD_MARK, PSB0_SIUAOSLD, HIZB4_SIUA, SIUAOSLD_SIOF1_TXD),
+	PINMUX_DATA(SIUMCKA_MARK, PSE11_SIUMCKA_SIOF1_MCK, HIZB4_SIUA, PSB1_SIUMCKA, PTK0),
+	PINMUX_DATA(SIUFCKA_MARK, PSE11_SIUFCKA, HIZB4_SIUA, PTK0),
 
 	/* SIU - Port B */
 	PINMUX_DATA(SIUBOLR_MARK, PSB11_SIUBOLR, SIOSTRB1_SIUBOLR),
@@ -1612,7 +1613,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0,
 		0, 0,
 		0, 0,
-		0, 0,
+		HIZB4_SIUA, HIZB4_HIZ,
 		0, 0,
 		0, 0,
 		HIZB1_VIO, HIZB1_HIZ,
-- 
1.6.2.4

