From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 May 2012 01:33:18 +0000
Subject: [PATCH 07/12 v2] ARM: mach-shmobile: pfc-r8a7740: Add HDMI GPIO support
Message-Id: <877gw3vfz8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch is based on v1.0 manual

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - same as v1

 arch/arm/mach-shmobile/include/mach/r8a7740.h |    4 ++++
 arch/arm/mach-shmobile/pfc-r8a7740.c          |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 9d447ab..2764846 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -565,6 +565,10 @@ enum {
 	GPIO_FN_RESETP_PULLUP,
 	GPIO_FN_RESETP_PLAIN,
 
+	/* HDMI */
+	GPIO_FN_HDMI_HPD,
+	GPIO_FN_HDMI_CEC,
+
 	/* SDENC */
 	GPIO_FN_SDENC_CPG,
 	GPIO_FN_SDENC_DV_CLKI,
diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index 670fe18..0dda816 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -560,6 +560,9 @@ enum {
 	/* SDENC */
 	SDENC_CPG_MARK,		SDENC_DV_CLKI_MARK,
 
+	/* HDMI */
+	HDMI_HPD_MARK, HDMI_CEC_MARK,
+
 	/* DEBUG */
 	EDEBGREQ_PULLUP_MARK,	/* for JTAG */
 	EDEBGREQ_PULLDOWN_MARK,
@@ -1620,9 +1623,11 @@ static pinmux_enum_t pinmux_data[] = {
 
 	/* Port210 */
 	PINMUX_DATA(IRQ9_PORT210_MARK,		PORT210_FN0,	MSEL1CR_9_1),
+	PINMUX_DATA(HDMI_HPD_MARK,		PORT210_FN1),
 
 	/* Port211 */
 	PINMUX_DATA(IRQ16_PORT211_MARK,		PORT211_FN0,	MSEL1CR_16_1),
+	PINMUX_DATA(HDMI_CEC_MARK,		PORT211_FN1),
 
 	/* LCDC select */
 	PINMUX_DATA(LCDC0_SELECT_MARK,				MSEL3CR_6_0),
@@ -2097,6 +2102,10 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	GPIO_FN(SDENC_CPG),
 	GPIO_FN(SDENC_DV_CLKI),
 
+	/* HDMI */
+	GPIO_FN(HDMI_HPD),
+	GPIO_FN(HDMI_CEC),
+
 	/* SYSC */
 	GPIO_FN(RESETP_PULLUP),
 	GPIO_FN(RESETP_PLAIN),
-- 
1.7.5.4

