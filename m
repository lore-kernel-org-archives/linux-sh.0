From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Dec 2013 19:25:14 +0000
Subject: [PATCH 1/4] pinctrl: sh-pfc: Constify enum_ids and var_field_width compound literals
Message-Id: <1387221917-15437-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The enum_ids and var_field_width fields of struct pinmux_data_reg and
pinmux_cfg_reg are initialized using compound literals. Cast them to
const to store them in .rodata.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e17ccab..cdd0338 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -76,12 +76,13 @@ struct pinmux_cfg_reg {
 
 #define PINMUX_CFG_REG(name, r, r_width, f_width) \
 	.reg = r, .reg_width = r_width, .field_width = f_width,		\
-	.enum_ids = (u16 [(r_width / f_width) * (1 << f_width)])
+	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])
 
 #define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
 	.reg = r, .reg_width = r_width,	\
-	.var_field_width = (unsigned long [r_width]) { var_fw0, var_fwn, 0 }, \
-	.enum_ids = (u16 [])
+	.var_field_width = (const unsigned long [r_width]) \
+		{ var_fw0, var_fwn, 0 }, \
+	.enum_ids = (const u16 [])
 
 struct pinmux_data_reg {
 	unsigned long reg, reg_width;
@@ -90,7 +91,7 @@ struct pinmux_data_reg {
 
 #define PINMUX_DATA_REG(name, r, r_width) \
 	.reg = r, .reg_width = r_width,	\
-	.enum_ids = (u16 [r_width]) \
+	.enum_ids = (const u16 [r_width]) \
 
 struct pinmux_irq {
 	int irq;
-- 
1.8.3.2

