From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:25 +0000
Subject: [PATCH v3 05/64] sh-pfc: sh73a0: Add FSI pin groups and functions
Message-Id: <1362740544-19164-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 244 ++++++++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 2dc58e2..09848f8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -1550,6 +1550,185 @@ static struct pinmux_range pinmux_ranges[] = {
 	{.begin = 288, .end = 309,},
 };
 
+static const unsigned int fsia_mclk_in_pins[] = {
+	/* CK */
+	49,
+};
+static const unsigned int fsia_mclk_in_mux[] = {
+	FSIACK_MARK,
+};
+static const unsigned int fsia_mclk_out_pins[] = {
+	/* OMC */
+	49,
+};
+static const unsigned int fsia_mclk_out_mux[] = {
+	FSIAOMC_MARK,
+};
+static const unsigned int fsia_sclk_in_pins[] = {
+	/* ILR, IBT */
+	50, 51,
+};
+static const unsigned int fsia_sclk_in_mux[] = {
+	FSIAILR_MARK, FSIAIBT_MARK,
+};
+static const unsigned int fsia_sclk_out_pins[] = {
+	/* OLR, OBT */
+	50, 51,
+};
+static const unsigned int fsia_sclk_out_mux[] = {
+	FSIAOLR_MARK, FSIAOBT_MARK,
+};
+static const unsigned int fsia_data_in_pins[] = {
+	/* ISLD */
+	55,
+};
+static const unsigned int fsia_data_in_mux[] = {
+	FSIAISLD_MARK,
+};
+static const unsigned int fsia_data_out_pins[] = {
+	/* OSLD */
+	52,
+};
+static const unsigned int fsia_data_out_mux[] = {
+	FSIAOSLD_MARK,
+};
+static const unsigned int fsia_spdif_pins[] = {
+	/* SPDIF */
+	53,
+};
+static const unsigned int fsia_spdif_mux[] = {
+	FSIASPDIF_MARK,
+};
+
+static const unsigned int fsib_mclk_in_pins[] = {
+	/* CK */
+	54,
+};
+static const unsigned int fsib_mclk_in_mux[] = {
+	FSIBCK_MARK,
+};
+static const unsigned int fsib_mclk_out_pins[] = {
+	/* OMC */
+	54,
+};
+static const unsigned int fsib_mclk_out_mux[] = {
+	FSIBOMC_MARK,
+};
+static const unsigned int fsib_sclk_in_pins[] = {
+	/* ILR, IBT */
+	37, 36,
+};
+static const unsigned int fsib_sclk_in_mux[] = {
+	FSIBILR_MARK, FSIBIBT_MARK,
+};
+static const unsigned int fsib_sclk_out_pins[] = {
+	/* OLR, OBT */
+	37, 36,
+};
+static const unsigned int fsib_sclk_out_mux[] = {
+	FSIBOLR_MARK, FSIBOBT_MARK,
+};
+static const unsigned int fsib_data_in_pins[] = {
+	/* ISLD */
+	39,
+};
+static const unsigned int fsib_data_in_mux[] = {
+	FSIBISLD_MARK,
+};
+static const unsigned int fsib_data_out_pins[] = {
+	/* OSLD */
+	38,
+};
+static const unsigned int fsib_data_out_mux[] = {
+	FSIBOSLD_MARK,
+};
+static const unsigned int fsib_spdif_pins[] = {
+	/* SPDIF */
+	53,
+};
+static const unsigned int fsib_spdif_mux[] = {
+	FSIBSPDIF_MARK,
+};
+
+static const unsigned int fsic_mclk_in_pins[] = {
+	/* CK */
+	54,
+};
+static const unsigned int fsic_mclk_in_mux[] = {
+	FSICCK_MARK,
+};
+static const unsigned int fsic_mclk_out_pins[] = {
+	/* OMC */
+	54,
+};
+static const unsigned int fsic_mclk_out_mux[] = {
+	FSICOMC_MARK,
+};
+static const unsigned int fsic_sclk_in_pins[] = {
+	/* ILR, IBT */
+	46, 45,
+};
+static const unsigned int fsic_sclk_in_mux[] = {
+	FSICILR_MARK, FSICIBT_MARK,
+};
+static const unsigned int fsic_sclk_out_pins[] = {
+	/* OLR, OBT */
+	46, 45,
+};
+static const unsigned int fsic_sclk_out_mux[] = {
+	FSICOLR_MARK, FSICOBT_MARK,
+};
+static const unsigned int fsic_data_in_pins[] = {
+	/* ISLD */
+	48,
+};
+static const unsigned int fsic_data_in_mux[] = {
+	FSICISLD_MARK,
+};
+static const unsigned int fsic_data_out_pins[] = {
+	/* OSLD, OSLDT1, OSLDT2, OSLDT3 */
+	47, 44, 42, 16,
+};
+static const unsigned int fsic_data_out_mux[] = {
+	FSICOSLD_MARK, FSICOSLDT1_MARK, FSICOSLDT2_MARK, FSICOSLDT3_MARK,
+};
+static const unsigned int fsic_spdif_0_pins[] = {
+	/* SPDIF */
+	53,
+};
+static const unsigned int fsic_spdif_0_mux[] = {
+	PORT53_FSICSPDIF_MARK,
+};
+static const unsigned int fsic_spdif_1_pins[] = {
+	/* SPDIF */
+	47,
+};
+static const unsigned int fsic_spdif_1_mux[] = {
+	PORT47_FSICSPDIF_MARK,
+};
+
+static const unsigned int fsid_sclk_in_pins[] = {
+	/* ILR, IBT */
+	46, 45,
+};
+static const unsigned int fsid_sclk_in_mux[] = {
+	FSIDILR_MARK, FSIDIBT_MARK,
+};
+static const unsigned int fsid_sclk_out_pins[] = {
+	/* OLR, OBT */
+	46, 45,
+};
+static const unsigned int fsid_sclk_out_mux[] = {
+	FSIDOLR_MARK, FSIDOBT_MARK,
+};
+static const unsigned int fsid_data_in_pins[] = {
+	/* ISLD */
+	48,
+};
+static const unsigned int fsid_data_in_mux[] = {
+	FSIDISLD_MARK,
+};
+
 static const unsigned int i2c2_0_pins[] = {
 	/* SCL, SDA */
 	237, 236,
@@ -2037,6 +2216,31 @@ static const unsigned int scifb_ctrl_1_mux[] = {
 };
 
 static const struct sh_pfc_pin_group pinmux_groups[] = {
+	SH_PFC_PIN_GROUP(fsia_mclk_in),
+	SH_PFC_PIN_GROUP(fsia_mclk_out),
+	SH_PFC_PIN_GROUP(fsia_sclk_in),
+	SH_PFC_PIN_GROUP(fsia_sclk_out),
+	SH_PFC_PIN_GROUP(fsia_data_in),
+	SH_PFC_PIN_GROUP(fsia_data_out),
+	SH_PFC_PIN_GROUP(fsia_spdif),
+	SH_PFC_PIN_GROUP(fsib_mclk_in),
+	SH_PFC_PIN_GROUP(fsib_mclk_out),
+	SH_PFC_PIN_GROUP(fsib_sclk_in),
+	SH_PFC_PIN_GROUP(fsib_sclk_out),
+	SH_PFC_PIN_GROUP(fsib_data_in),
+	SH_PFC_PIN_GROUP(fsib_data_out),
+	SH_PFC_PIN_GROUP(fsib_spdif),
+	SH_PFC_PIN_GROUP(fsic_mclk_in),
+	SH_PFC_PIN_GROUP(fsic_mclk_out),
+	SH_PFC_PIN_GROUP(fsic_sclk_in),
+	SH_PFC_PIN_GROUP(fsic_sclk_out),
+	SH_PFC_PIN_GROUP(fsic_data_in),
+	SH_PFC_PIN_GROUP(fsic_data_out),
+	SH_PFC_PIN_GROUP(fsic_spdif_0),
+	SH_PFC_PIN_GROUP(fsic_spdif_1),
+	SH_PFC_PIN_GROUP(fsid_sclk_in),
+	SH_PFC_PIN_GROUP(fsid_sclk_out),
+	SH_PFC_PIN_GROUP(fsid_data_in),
 	SH_PFC_PIN_GROUP(i2c2_0),
 	SH_PFC_PIN_GROUP(i2c2_1),
 	SH_PFC_PIN_GROUP(i2c2_2),
@@ -2099,6 +2303,42 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scifb_ctrl_1),
 };
 
+static const char * const fsia_groups[] = {
+	"fsia_mclk_in",
+	"fsia_mclk_out",
+	"fsia_sclk_in",
+	"fsia_sclk_out",
+	"fsia_data_in",
+	"fsia_data_out",
+	"fsia_spdif",
+};
+
+static const char * const fsib_groups[] = {
+	"fsib_mclk_in",
+	"fsib_mclk_out",
+	"fsib_sclk_in",
+	"fsib_sclk_out",
+	"fsib_data_in",
+	"fsib_data_out",
+	"fsib_spdif",
+};
+
+static const char * const fsic_groups[] = {
+	"fsic_mclk_in",
+	"fsic_mclk_out",
+	"fsic_sclk_in",
+	"fsic_sclk_out",
+	"fsic_data_in",
+	"fsic_data_out",
+	"fsic_spdif",
+};
+
+static const char * const fsid_groups[] = {
+	"fsid_sclk_in",
+	"fsid_sclk_out",
+	"fsid_data_in",
+};
+
 static const char * const i2c2_groups[] = {
 	"i2c2_0",
 	"i2c2_1",
@@ -2199,6 +2439,10 @@ static const char * const scifb_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(fsia),
+	SH_PFC_FUNCTION(fsib),
+	SH_PFC_FUNCTION(fsic),
+	SH_PFC_FUNCTION(fsid),
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 	SH_PFC_FUNCTION(lcd),
-- 
1.8.1.5

