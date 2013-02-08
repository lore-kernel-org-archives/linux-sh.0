From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 08 Feb 2013 15:02:51 +0000
Subject: [PATCH RFC] sh: pfc: Add ability to use separate read & write GPIO data regs
Message-Id: <1360335771-4468-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On several devices, there are separate registers for data input
and data output.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/sh/pfc/core.c  |    5 +++--
 include/linux/sh_pfc.h |    8 +++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index 6816937..173126e 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -163,14 +163,14 @@ void sh_pfc_write_bit(struct pinmux_data_reg *dr, unsigned long in_pos,
 
 	pr_debug("write_bit addr = %lx, value = %d, pos = %ld, "
 		 "r_width = %ld\n",
-		 dr->reg, !!value, pos, dr->reg_width);
+		 dr->wreg, !!value, pos, dr->reg_width);
 
 	if (value)
 		set_bit(pos, &dr->reg_shadow);
 	else
 		clear_bit(pos, &dr->reg_shadow);
 
-	gpio_write_raw_reg(dr->mapped_reg, dr->reg_width, dr->reg_shadow);
+	gpio_write_raw_reg(dr->mapped_wreg, dr->reg_width, dr->reg_shadow);
 }
 EXPORT_SYMBOL_GPL(sh_pfc_write_bit);
 
@@ -256,6 +256,7 @@ static int setup_data_reg(struct sh_pfc *pfc, unsigned gpio)
 			break;
 
 		data_reg->mapped_reg = pfc_phys_to_virt(pfc, data_reg->reg);
+		data_reg->mapped_wreg = pfc_phys_to_virt(pfc, data_reg->wreg);
 
 		for (n = 0; n < data_reg->reg_width; n++) {
 			if (data_reg->enum_ids[n] = gpiop->enum_id) {
diff --git a/include/linux/sh_pfc.h b/include/linux/sh_pfc.h
index c19a092..bbf955b 100644
--- a/include/linux/sh_pfc.h
+++ b/include/linux/sh_pfc.h
@@ -68,10 +68,16 @@ struct pinmux_data_reg {
 	unsigned long reg, reg_width, reg_shadow;
 	pinmux_enum_t *enum_ids;
 	void __iomem *mapped_reg;
+	unsigned long wreg;	/* separate write reg */
+	void __iomem *mapped_wreg;
 };
 
 #define PINMUX_DATA_REG(name, r, r_width) \
-	.reg = r, .reg_width = r_width,	\
+	.reg = r, .wreg = r, .reg_width = r_width,	\
+	.enum_ids = (pinmux_enum_t [r_width]) \
+
+#define PINMUX_DATA_REG2(name, r, r2, r_width) \
+	.reg = r, .wreg = r2, .reg_width = r_width,	\
 	.enum_ids = (pinmux_enum_t [r_width]) \
 
 struct pinmux_irq {
-- 
1.7.5.4

