From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:07:55 +0000
Subject: [PATCH 08/13 v4][RFC] Local: Hack: enable SCIF2 without using PFC
Message-Id: <87lhdoyh9p.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Since PFC is not supported yet, this patch manually enables SCIF2 pin

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
---
v3 -> v4

 - new patch

 drivers/clk/shmobile/clk-rcar-gen3.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/clk/shmobile/clk-rcar-gen3.c b/drivers/clk/shmobile/clk-rcar-gen3.c
index 098caac..a5edc7b 100644
--- a/drivers/clk/shmobile/clk-rcar-gen3.c
+++ b/drivers/clk/shmobile/clk-rcar-gen3.c
@@ -119,6 +119,47 @@ static const struct cpg_pll_config cpg_pll_configs[16] __initconst = {
  * Initialization
  */
 
+/*
+ * Pin Function Controller (PFC) definitions.
+ * TODO: Should move to appropriate header.
+ */
+#define PFC_BASE	0xe6060000
+#define PFC_PMMR	0x0	/* LSI Multiplexed Pin Setting Mask Register */
+#define PFC_GPSR5	0x114	/* GPIO/peripheral function select register 5 */
+#define PFC_IPSR12	0x230	/* Peripheral function select register 12 */
+#define PFC_MOD_SEL1	0x504	/* Module select register 1 */
+#define PFC_SIZE	0x1000
+
+/*
+ * Initialize PFC for SCIF2.
+ * TODO: Should move to appropriate source.
+ */
+void InitScif2PinFunction(void)
+{
+	void __iomem *pfc_base;
+	u32 data;
+
+	pfc_base = ioremap_nocache(PFC_BASE, PFC_SIZE);
+	BUG_ON(!pfc_base);
+
+	data = ioread32(pfc_base + PFC_MOD_SEL1);
+	data &= ~BIT(12);
+	iowrite32(~data, pfc_base + PFC_PMMR);
+	iowrite32(data, pfc_base + PFC_MOD_SEL1);
+
+	data = ioread32(pfc_base + PFC_IPSR12);
+	data &= ~0x000000ff;	//IP12[7:4]=4'b0000, IP12[3:0]=4'b0000
+	iowrite32(~data, pfc_base + PFC_PMMR);
+	iowrite32(data, pfc_base + PFC_IPSR12);
+
+	data = ioread32(pfc_base + PFC_GPSR5);
+	data |= 0x00000c00;	//GP5[11],GP5[10]
+	iowrite32(~data, pfc_base + PFC_PMMR);
+	iowrite32(data, pfc_base + PFC_GPSR5);
+
+	iounmap(pfc_base);
+}
+
 static u32 cpg_mode __initdata;
 
 static struct clk * __init
@@ -177,6 +218,7 @@ static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
 	unsigned int i;
 	int num_clks;
 
+	InitScif2PinFunction();
 	cpg_mode = rcar_gen3_read_mode_pins();
 
 	num_clks = of_property_count_strings(np, "clock-output-names");
-- 
1.9.1

