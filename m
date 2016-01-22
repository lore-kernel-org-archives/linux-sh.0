From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Fri, 22 Jan 2016 12:26:26 +0000
Subject: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
Notes:

* This is based on https://git.kernel.org/cgit/linux/kernel/git/horms/renes=
as-bsp.git/commit/drivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0.x&=
id=CD10385afc15cef6bfbaea4aa5da41193b24fe82

* This is compile tested *only*. The intention is to get some feedback
  if this is the way we want to go.

 drivers/clk/shmobile/r8a7795-cpg-mssr.c | 248 ++++++++++++++++++++++++++++=
++++
 drivers/clk/shmobile/renesas-cpg-mssr.h |   2 +
 2 files changed, 250 insertions(+)

diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c b/drivers/clk/shmobile=
/r8a7795-cpg-mssr.c
index 23e98fe..a7ac1b0 100644
--- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
+++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
@@ -20,6 +20,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
+#include <linux/slab.h>
=20
 #include <dt-bindings/clock/r8a7795-cpg-mssr.h>
=20
@@ -61,6 +62,7 @@ enum r8a7795_clk_types {
 	CLK_TYPE_GEN3_PLL2,
 	CLK_TYPE_GEN3_PLL3,
 	CLK_TYPE_GEN3_PLL4,
+	CLK_TYPE_GEN3_SD,
 };
=20
 static const struct cpg_core_clk r8a7795_core_clks[] __initconst =3D {
@@ -99,6 +101,12 @@ static const struct cpg_core_clk r8a7795_core_clks[] __=
initconst =3D {
 	DEF_FIXED("s3d1",       R8A7795_CLK_S3D1,  CLK_S3,         1, 1),
 	DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         2, 1),
 	DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         4, 1),
+
+	DEF_SD("sd0",           R8A7795_CLK_SD0,   CLK_PLL1_DIV2, 0x0074),
+	DEF_SD("sd1",           R8A7795_CLK_SD1,   CLK_PLL1_DIV2, 0x0078),
+	DEF_SD("sd2",           R8A7795_CLK_SD2,   CLK_PLL1_DIV2, 0x0268),
+	DEF_SD("sd3",           R8A7795_CLK_SD3,   CLK_PLL1_DIV2, 0x026c),
+
 	DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 48, 1),
 	DEF_FIXED("cp",         R8A7795_CLK_CP,    CLK_EXTAL,      2, 1),
=20
@@ -199,6 +207,243 @@ static const unsigned int r8a7795_crit_mod_clks[] __i=
nitconst =3D {
 	MOD_CLK_ID(408),	/* INTC-AP (GIC) */
 };
=20
+/* -----------------------------------------------------------------------=
------
+ * SDn Clock
+ *
+ */
+#define CPG_SD_STP_N_HCK	BIT(9)
+#define CPG_SD_STP_N_CK		BIT(8)
+#define CPG_SD_SD_N_SRCFC_MASK	(0x7 << CPG_SD_SD_N_SRCFC_SHIFT)
+#define CPG_SD_SD_N_SRCFC_SHIFT	2
+#define CPG_SD_SD_N_FC_MASK	(0x3 << CPG_SD_SD_N_FC_SHIFT)
+#define CPG_SD_SD_N_FC_SHIFT	0
+
+#define CPG_SD_STP_MASK		(CPG_SD_STP_N_HCK | CPG_SD_STP_N_CK)
+#define CPG_SD_FC_MASK		(CPG_SD_SD_N_SRCFC_MASK | CPG_SD_SD_N_FC_MASK)
+
+/* CPG_SD_DIV_TABLE_DATA(stp_n_hck, stp_n_ck, sd_n_srcfc, sd_n_fc, div) */
+#define CPG_SD_DIV_TABLE_DATA(_a, _b, _c, _d, _e) \
+{ \
+	.val =3D ((_a) ? CPG_SD_STP_N_HCK : 0) | \
+	       ((_b) ? CPG_SD_STP_N_CK : 0) | \
+	       (((_c) << CPG_SD_SD_N_SRCFC_SHIFT) & CPG_SD_SD_N_SRCFC_MASK) | \
+	       (((_d) << CPG_SD_SD_N_FC_SHIFT) & CPG_SD_SD_N_FC_MASK), \
+	.div =3D (_e), \
+}
+
+struct sd_div_table {
+	u32 val;
+	unsigned int div;
+};
+
+struct sd_clock {
+	struct clk_hw hw;
+	void __iomem *reg;
+	const struct sd_div_table *div_table;
+	int div_num;
+	unsigned int div_min;
+	unsigned int div_max;
+};
+
+/* SDn divider
+ *                     sd_n_srcfc sd_n_fc   div
+ * stp_n_hck stp_n_ck  (div)      (div)     =3D sd_n_srcfc x sd_n_fc
+ *-------------------------------------------------------------------
+ *  0         0         0 (1)      1 (4)      4
+ *  0         0         1 (2)      1 (4)      8
+ *  1         0         2 (4)      1 (4)     16
+ *  1         0         3 (8)      1 (4)     32
+ *  1         0         4 (16)     1 (4)     64
+ *  0         0         0 (1)      0 (2)      2
+ *  0         0         1 (2)      0 (2)      4
+ *  1         0         2 (4)      0 (2)      8
+ *  1         0         3 (8)      0 (2)     16
+ *  1         0         4 (16)     0 (2)     32
+ */
+static const struct sd_div_table cpg_sd_div_table[] =3D {
+/*	CPG_SD_DIV_TABLE_DATA(stp_n_hck, stp_n_ck, sd_n_srcfc, sd_n_fc, div) */
+	CPG_SD_DIV_TABLE_DATA(0,        0,        0,          1,        4),
+	CPG_SD_DIV_TABLE_DATA(0,        0,        1,          1,        8),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        2,          1,       16),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        3,          1,       32),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        4,          1,       64),
+	CPG_SD_DIV_TABLE_DATA(0,        0,        0,          0,        2),
+	CPG_SD_DIV_TABLE_DATA(0,        0,        1,          0,        4),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        2,          0,        8),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        3,          0,       16),
+	CPG_SD_DIV_TABLE_DATA(1,        0,        4,          0,       32),
+};
+
+#define to_sd_clock(_hw) container_of(_hw, struct sd_clock, hw)
+
+static int cpg_sd_clock_endisable(struct clk_hw *hw, bool enable)
+{
+	struct sd_clock *clock =3D to_sd_clock(hw);
+	u32 val, sd_fc;
+	int i;
+
+	val =3D clk_readl(clock->reg);
+
+	if (enable) {
+		sd_fc =3D val & CPG_SD_FC_MASK;
+		for (i =3D 0; i < clock->div_num; i++)
+			if (sd_fc =3D (clock->div_table[i].val & CPG_SD_FC_MASK))
+				break;
+
+		if (i >=3D clock->div_num) {
+			pr_err("%s: 0x%4x is not support of division ratio.\n",
+				__func__, sd_fc);
+			return -ENODATA;
+		}
+
+		val &=3D ~(CPG_SD_STP_MASK);
+		val |=3D clock->div_table[i].val & CPG_SD_STP_MASK;
+	} else
+		val |=3D CPG_SD_STP_MASK;
+
+	clk_writel(val, clock->reg);
+
+	return 0;
+}
+
+static int cpg_sd_clock_enable(struct clk_hw *hw)
+{
+	return cpg_sd_clock_endisable(hw, true);
+}
+
+static void cpg_sd_clock_disable(struct clk_hw *hw)
+{
+	cpg_sd_clock_endisable(hw, false);
+}
+
+static int cpg_sd_clock_is_enabled(struct clk_hw *hw)
+{
+	struct sd_clock *clock =3D to_sd_clock(hw);
+
+	return !(clk_readl(clock->reg) & CPG_SD_STP_MASK);
+}
+
+static unsigned long cpg_sd_clock_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct sd_clock *clock =3D to_sd_clock(hw);
+	u32 rate =3D parent_rate;
+	u32 val, sd_fc;
+	int i;
+
+	val =3D clk_readl(clock->reg);
+
+	sd_fc =3D val & CPG_SD_FC_MASK;
+	for (i =3D 0; i < clock->div_num; i++)
+		if (sd_fc =3D (clock->div_table[i].val & CPG_SD_FC_MASK))
+			break;
+
+	if (i >=3D clock->div_num) {
+		pr_err("%s: 0x%4x is not support of division ratio.\n",
+			__func__, sd_fc);
+		return 0;
+	}
+
+	do_div(rate, clock->div_table[i].div);
+
+	return rate;
+}
+
+static unsigned int cpg_sd_clock_calc_div(struct sd_clock *clock,
+					  unsigned long rate,
+					  unsigned long parent_rate)
+{
+	unsigned int div;
+
+	if (!rate)
+		rate =3D 1;
+
+	div =3D DIV_ROUND_CLOSEST(parent_rate, rate);
+
+	return clamp_t(unsigned int, div, clock->div_min, clock->div_max);
+}
+
+static long cpg_sd_clock_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *parent_rate)
+{
+	struct sd_clock *clock =3D to_sd_clock(hw);
+	unsigned int div =3D cpg_sd_clock_calc_div(clock, rate, *parent_rate);
+
+	return *parent_rate / div;
+}
+
+static int cpg_sd_clock_set_rate(struct clk_hw *hw, unsigned long rate,
+				   unsigned long parent_rate)
+{
+	struct sd_clock *clock =3D to_sd_clock(hw);
+	unsigned int div =3D cpg_sd_clock_calc_div(clock, rate, parent_rate);
+	u32 val;
+	int i;
+
+	for (i =3D 0; i < clock->div_num; i++)
+		if (div =3D clock->div_table[i].div)
+			break;
+
+	if (i >=3D clock->div_num) {
+		pr_err("%s: Not support divider range : div=3D%d (%lu/%lu).\n",
+			__func__, div, parent_rate, rate);
+		return -EINVAL;
+	}
+
+	val =3D clk_readl(clock->reg);
+	val &=3D ~(CPG_SD_STP_MASK | CPG_SD_FC_MASK);
+	val |=3D clock->div_table[i].val & (CPG_SD_STP_MASK | CPG_SD_FC_MASK);
+	clk_writel(val, clock->reg);
+
+	return 0;
+}
+
+static const struct clk_ops cpg_sd_clock_ops =3D {
+	.enable =3D cpg_sd_clock_enable,
+	.disable =3D cpg_sd_clock_disable,
+	.is_enabled =3D cpg_sd_clock_is_enabled,
+	.recalc_rate =3D cpg_sd_clock_recalc_rate,
+	.round_rate =3D cpg_sd_clock_round_rate,
+	.set_rate =3D cpg_sd_clock_set_rate,
+};
+
+static struct clk * __init cpg_sd_clk_register(const struct cpg_core_clk *=
core,
+					       void __iomem *base,
+					       const char *parent_name)
+{
+	struct clk_init_data init;
+	struct sd_clock *clock;
+	struct clk *clk;
+	int i;
+
+	clock =3D kzalloc(sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return ERR_PTR(-ENOMEM);
+
+	init.name =3D core->name;
+	init.ops =3D &cpg_sd_clock_ops;
+	init.flags =3D CLK_IS_BASIC | CLK_SET_RATE_PARENT;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	clock->reg =3D base + core->offset;
+	clock->hw.init =3D &init;
+	clock->div_table =3D cpg_sd_div_table;
+	clock->div_num =3D ARRAY_SIZE(cpg_sd_div_table);
+
+	clock->div_max =3D clock->div_table[0].div;
+	clock->div_min =3D clock->div_max;
+	for (i =3D 1; i < clock->div_num; i++) {
+		clock->div_max =3D max(clock->div_max, clock->div_table[i].div);
+		clock->div_min =3D min(clock->div_min, clock->div_table[i].div);
+	}
+
+	clk =3D clk_register(NULL, &clock->hw);
+	if (IS_ERR(clk))
+		kfree(clock);
+
+	return clk;
+}
=20
 #define CPG_PLL0CR	0x00d8
 #define CPG_PLL2CR	0x002c
@@ -324,6 +569,9 @@ struct clk * __init r8a7795_cpg_clk_register(struct dev=
ice *dev,
 		mult =3D (((value >> 24) & 0x7f) + 1) * 2;
 		break;
=20
+	case CLK_TYPE_GEN3_SD:
+		return cpg_sd_clk_register(core, base, __clk_get_name(parent));
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/clk/shmobile/renesas-cpg-mssr.h b/drivers/clk/shmobile=
/renesas-cpg-mssr.h
index e09f03c..952b695 100644
--- a/drivers/clk/shmobile/renesas-cpg-mssr.h
+++ b/drivers/clk/shmobile/renesas-cpg-mssr.h
@@ -53,6 +53,8 @@ enum clk_types {
 	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div =3D _div, .mult =3D _mult)
 #define DEF_DIV6P1(_name, _id, _parent, _offset)	\
 	DEF_BASE(_name, _id, CLK_TYPE_DIV6P1, _parent, .offset =3D _offset)
+#define DEF_SD(_name, _id, _parent, _offset)	\
+	DEF_BASE(_name, _id, CLK_TYPE_GEN3_SD, _parent, .offset =3D _offset)
=20
=20
     /*
--=20
2.5.1

