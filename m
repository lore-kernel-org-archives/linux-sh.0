From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Sep 2015 10:22:48 +0000
Subject: [PATCH 01/05][RFC] clk: Initialize on-stack struct clk_init_data
Message-Id: <20150915102248.15716.67003.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150915102238.15716.91170.sendpatchset@little-apple>
In-Reply-To: <20150915102238.15716.91170.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Make sure on-stack struct clk_init_data is initialized
to allow extending the structure with new members without
having to update all the users.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/clk/at91/clk-h32mx.c              |    2 +-
 drivers/clk/at91/clk-main.c               |    8 ++++----
 drivers/clk/at91/clk-master.c             |    2 +-
 drivers/clk/at91/clk-peripheral.c         |    4 ++--
 drivers/clk/at91/clk-pll.c                |    2 +-
 drivers/clk/at91/clk-plldiv.c             |    2 +-
 drivers/clk/at91/clk-programmable.c       |    2 +-
 drivers/clk/at91/clk-slow.c               |    8 ++++----
 drivers/clk/at91/clk-smd.c                |    2 +-
 drivers/clk/at91/clk-system.c             |    2 +-
 drivers/clk/at91/clk-usb.c                |    6 +++---
 drivers/clk/at91/clk-utmi.c               |    2 +-
 drivers/clk/bcm/clk-iproc-armpll.c        |    2 +-
 drivers/clk/bcm/clk-iproc-asiu.c          |    2 +-
 drivers/clk/bcm/clk-iproc-pll.c           |    2 +-
 drivers/clk/berlin/berlin2-avpll.c        |    4 ++--
 drivers/clk/berlin/berlin2-pll.c          |    2 +-
 drivers/clk/clk-axi-clkgen.c              |    2 +-
 drivers/clk/clk-cdce925.c                 |    2 +-
 drivers/clk/clk-composite.c               |    2 +-
 drivers/clk/clk-divider.c                 |    2 +-
 drivers/clk/clk-fixed-factor.c            |    2 +-
 drivers/clk/clk-fixed-rate.c              |    2 +-
 drivers/clk/clk-fractional-divider.c      |    2 +-
 drivers/clk/clk-gate.c                    |    2 +-
 drivers/clk/clk-highbank.c                |    2 +-
 drivers/clk/clk-ls1x.c                    |    2 +-
 drivers/clk/clk-mb86s7x.c                 |    4 ++--
 drivers/clk/clk-mux.c                     |    2 +-
 drivers/clk/clk-nomadik.c                 |    4 ++--
 drivers/clk/clk-pwm.c                     |    2 +-
 drivers/clk/clk-qoriq.c                   |    2 +-
 drivers/clk/clk-si5351.c                  |    2 +-
 drivers/clk/clk-si570.c                   |    2 +-
 drivers/clk/clk-stm32f4.c                 |    2 +-
 drivers/clk/clk-u300.c                    |    4 ++--
 drivers/clk/clk-vt8500.c                  |    4 ++--
 drivers/clk/clk-xgene.c                   |    4 ++--
 drivers/clk/h8300/clk-h8s2678.c           |    2 +-
 drivers/clk/hisilicon/clk-hi3620.c        |    2 +-
 drivers/clk/hisilicon/clk-hi6220-stub.c   |    2 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       |    2 +-
 drivers/clk/hisilicon/clkdivider-hi6220.c |    2 +-
 drivers/clk/hisilicon/clkgate-separated.c |    2 +-
 drivers/clk/imx/clk-busy.c                |    4 ++--
 drivers/clk/imx/clk-cpu.c                 |    2 +-
 drivers/clk/imx/clk-fixup-div.c           |    2 +-
 drivers/clk/imx/clk-fixup-mux.c           |    2 +-
 drivers/clk/imx/clk-gate-exclusive.c      |    2 +-
 drivers/clk/imx/clk-gate2.c               |    2 +-
 drivers/clk/imx/clk-pfd.c                 |    2 +-
 drivers/clk/imx/clk-pllv1.c               |    2 +-
 drivers/clk/imx/clk-pllv2.c               |    2 +-
 drivers/clk/imx/clk-pllv3.c               |    2 +-
 drivers/clk/ingenic/cgu.c                 |    2 +-
 drivers/clk/keystone/gate.c               |    2 +-
 drivers/clk/keystone/pll.c                |    2 +-
 drivers/clk/meson/clk-cpu.c               |    2 +-
 drivers/clk/meson/clk-pll.c               |    2 +-
 drivers/clk/mmp/clk-apbc.c                |    2 +-
 drivers/clk/mmp/clk-apmu.c                |    2 +-
 drivers/clk/mmp/clk-frac.c                |    2 +-
 drivers/clk/mmp/clk-gate.c                |    2 +-
 drivers/clk/mmp/clk-mix.c                 |    2 +-
 drivers/clk/mvebu/clk-corediv.c           |    2 +-
 drivers/clk/mvebu/clk-cpu.c               |    2 +-
 drivers/clk/mxs/clk-div.c                 |    2 +-
 drivers/clk/mxs/clk-frac.c                |    2 +-
 drivers/clk/mxs/clk-pll.c                 |    2 +-
 drivers/clk/mxs/clk-ref.c                 |    2 +-
 drivers/clk/pistachio/clk-pll.c           |    2 +-
 drivers/clk/rockchip/clk-cpu.c            |    2 +-
 drivers/clk/rockchip/clk-inverter.c       |    2 +-
 drivers/clk/rockchip/clk-mmc-phase.c      |    2 +-
 drivers/clk/rockchip/clk-pll.c            |    2 +-
 drivers/clk/samsung/clk-cpu.c             |    2 +-
 drivers/clk/samsung/clk-pll.c             |    4 ++--
 drivers/clk/samsung/clk-s3c2410-dclk.c    |    2 +-
 drivers/clk/shmobile/clk-div6.c           |    2 +-
 drivers/clk/shmobile/clk-mstp.c           |    2 +-
 drivers/clk/shmobile/clk-rcar-gen2.c      |    2 +-
 drivers/clk/sirf/clk-atlas7.c             |    2 +-
 drivers/clk/socfpga/clk-gate-a10.c        |    2 +-
 drivers/clk/socfpga/clk-gate.c            |    2 +-
 drivers/clk/socfpga/clk-periph-a10.c      |    2 +-
 drivers/clk/socfpga/clk-periph.c          |    2 +-
 drivers/clk/socfpga/clk-pll-a10.c         |    2 +-
 drivers/clk/socfpga/clk-pll.c             |    2 +-
 drivers/clk/spear/clk-aux-synth.c         |    2 +-
 drivers/clk/spear/clk-frac-synth.c        |    2 +-
 drivers/clk/spear/clk-gpt-synth.c         |    2 +-
 drivers/clk/spear/clk-vco-pll.c           |    3 ++-
 drivers/clk/st/clk-flexgen.c              |    2 +-
 drivers/clk/st/clkgen-fsyn.c              |    4 ++--
 drivers/clk/st/clkgen-mux.c               |    2 +-
 drivers/clk/st/clkgen-pll.c               |    2 +-
 drivers/clk/sunxi/clk-sun6i-ar100.c       |    2 +-
 drivers/clk/tegra/clk-audio-sync.c        |    2 +-
 drivers/clk/tegra/clk-divider.c           |    2 +-
 drivers/clk/tegra/clk-emc.c               |    2 +-
 drivers/clk/tegra/clk-periph-gate.c       |    2 +-
 drivers/clk/tegra/clk-periph.c            |    2 +-
 drivers/clk/tegra/clk-pll-out.c           |    2 +-
 drivers/clk/tegra/clk-pll.c               |    2 +-
 drivers/clk/tegra/clk-super.c             |    2 +-
 drivers/clk/ti/clk-dra7-atl.c             |    2 +-
 drivers/clk/ti/divider.c                  |    2 +-
 drivers/clk/ti/dpll.c                     |    4 ++--
 drivers/clk/ti/gate.c                     |    2 +-
 drivers/clk/ti/interface.c                |    2 +-
 drivers/clk/ti/mux.c                      |    2 +-
 drivers/clk/ux500/clk-prcc.c              |    2 +-
 drivers/clk/ux500/clk-prcmu.c             |    2 +-
 drivers/clk/ux500/clk-sysctrl.c           |    2 +-
 drivers/clk/versatile/clk-icst.c          |    2 +-
 drivers/clk/versatile/clk-sp810.c         |    2 +-
 drivers/clk/versatile/clk-vexpress-osc.c  |    2 +-
 drivers/clk/zte/clk.c                     |    4 ++--
 118 files changed, 139 insertions(+), 138 deletions(-)

--- 0001/drivers/clk/at91/clk-h32mx.c
+++ work/drivers/clk/at91/clk-h32mx.c	2015-09-15 19:03:12.050513000 +0900
@@ -96,7 +96,7 @@ void __init of_sama5d4_clk_h32mx_setup(s
 				     struct at91_pmc *pmc)
 {
 	struct clk_sama5d4_h32mx *h32mxclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *parent_name;
 	struct clk *clk;
 
--- 0001/drivers/clk/at91/clk-main.c
+++ work/drivers/clk/at91/clk-main.c	2015-09-15 19:03:12.050513000 +0900
@@ -148,7 +148,7 @@ at91_clk_register_main_osc(struct at91_p
 	int ret;
 	struct clk_main_osc *osc;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !irq || !name || !parent_name)
 		return ERR_PTR(-EINVAL);
@@ -302,7 +302,7 @@ at91_clk_register_main_rc_osc(struct at9
 	int ret;
 	struct clk_main_rc_osc *osc;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !irq || !name || !frequency)
 		return ERR_PTR(-EINVAL);
@@ -433,7 +433,7 @@ at91_clk_register_rm9200_main(struct at9
 {
 	struct clk_rm9200_main *clkmain;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !name)
 		return ERR_PTR(-EINVAL);
@@ -567,7 +567,7 @@ at91_clk_register_sam9x5_main(struct at9
 	int ret;
 	struct clk_sam9x5_main *clkmain;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !irq || !name)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/at91/clk-master.c
+++ work/drivers/clk/at91/clk-master.c	2015-09-15 19:03:12.050513000 +0900
@@ -141,7 +141,7 @@ at91_clk_register_master(struct at91_pmc
 	int ret;
 	struct clk_master *master;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !irq || !name || !num_parents || !parent_names)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/at91/clk-peripheral.c
+++ work/drivers/clk/at91/clk-peripheral.c	2015-09-15 19:03:12.050513000 +0900
@@ -106,7 +106,7 @@ at91_clk_register_peripheral(struct at91
 {
 	struct clk_peripheral *periph;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !name || !parent_name || id > PERIPHERAL_ID_MAX)
 		return ERR_PTR(-EINVAL);
@@ -316,7 +316,7 @@ at91_clk_register_sam9x5_peripheral(stru
 {
 	struct clk_sam9x5_peripheral *periph;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !name || !parent_name)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/at91/clk-pll.c
+++ work/drivers/clk/at91/clk-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -315,7 +315,7 @@ at91_clk_register_pll(struct at91_pmc *p
 {
 	struct clk_pll *pll;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 	int offset = PLL_REG(id);
 	u32 tmp;
--- 0001/drivers/clk/at91/clk-plldiv.c
+++ work/drivers/clk/at91/clk-plldiv.c	2015-09-15 19:03:12.050513000 +0900
@@ -85,7 +85,7 @@ at91_clk_register_plldiv(struct at91_pmc
 {
 	struct clk_plldiv *plldiv;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	plldiv = kzalloc(sizeof(*plldiv), GFP_KERNEL);
 	if (!plldiv)
--- 0001/drivers/clk/at91/clk-programmable.c
+++ work/drivers/clk/at91/clk-programmable.c	2015-09-15 19:03:12.050513000 +0900
@@ -180,7 +180,7 @@ at91_clk_register_programmable(struct at
 {
 	struct clk_programmable *prog;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (id > PROG_ID_MAX)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/at91/clk-slow.c
+++ work/drivers/clk/at91/clk-slow.c	2015-09-15 19:03:12.050513000 +0900
@@ -129,7 +129,7 @@ at91_clk_register_slow_osc(void __iomem
 {
 	struct clk_slow_osc *osc;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!sckcr || !name || !parent_name)
 		return ERR_PTR(-EINVAL);
@@ -241,7 +241,7 @@ at91_clk_register_slow_rc_osc(void __iom
 {
 	struct clk_slow_rc_osc *osc;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!sckcr || !name)
 		return ERR_PTR(-EINVAL);
@@ -338,7 +338,7 @@ at91_clk_register_sam9x5_slow(void __iom
 {
 	struct clk_sam9x5_slow *slowck;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!sckcr || !name || !parent_names || !num_parents)
 		return ERR_PTR(-EINVAL);
@@ -409,7 +409,7 @@ at91_clk_register_sam9260_slow(struct at
 {
 	struct clk_sam9260_slow *slowck;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!pmc || !name)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/at91/clk-smd.c
+++ work/drivers/clk/at91/clk-smd.c	2015-09-15 19:03:12.050513000 +0900
@@ -119,7 +119,7 @@ at91sam9x5_clk_register_smd(struct at91_
 {
 	struct at91sam9x5_clk_smd *smd;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	smd = kzalloc(sizeof(*smd), GFP_KERNEL);
 	if (!smd)
--- 0001/drivers/clk/at91/clk-system.c
+++ work/drivers/clk/at91/clk-system.c	2015-09-15 19:03:12.050513000 +0900
@@ -105,7 +105,7 @@ at91_clk_register_system(struct at91_pmc
 {
 	struct clk_system *sys;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	if (!parent_name || id > SYSTEM_MAX_ID)
--- 0001/drivers/clk/at91/clk-usb.c
+++ work/drivers/clk/at91/clk-usb.c	2015-09-15 19:03:12.050513000 +0900
@@ -202,7 +202,7 @@ at91sam9x5_clk_register_usb(struct at91_
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
 	if (!usb)
@@ -231,7 +231,7 @@ at91sam9n12_clk_register_usb(struct at91
 {
 	struct at91sam9x5_clk_usb *usb;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
 	if (!usb)
@@ -346,7 +346,7 @@ at91rm9200_clk_register_usb(struct at91_
 {
 	struct at91rm9200_clk_usb *usb;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	usb = kzalloc(sizeof(*usb), GFP_KERNEL);
 	if (!usb)
--- 0001/drivers/clk/at91/clk-utmi.c
+++ work/drivers/clk/at91/clk-utmi.c	2015-09-15 19:03:12.050513000 +0900
@@ -99,7 +99,7 @@ at91_clk_register_utmi(struct at91_pmc *
 	int ret;
 	struct clk_utmi *utmi;
 	struct clk *clk = NULL;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	utmi = kzalloc(sizeof(*utmi), GFP_KERNEL);
 	if (!utmi)
--- 0001/drivers/clk/bcm/clk-iproc-armpll.c
+++ work/drivers/clk/bcm/clk-iproc-armpll.c	2015-09-15 19:03:12.050513000 +0900
@@ -244,7 +244,7 @@ void __init iproc_armpll_setup(struct de
 	int ret;
 	struct clk *clk;
 	struct iproc_arm_pll *pll;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *parent_name;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
--- 0001/drivers/clk/bcm/clk-iproc-asiu.c
+++ work/drivers/clk/bcm/clk-iproc-asiu.c	2015-09-15 19:03:12.050513000 +0900
@@ -216,7 +216,7 @@ void __init iproc_asiu_setup(struct devi
 		goto err_iomap_gate;
 
 	for (i = 0; i < num_clks; i++) {
-		struct clk_init_data init;
+		struct clk_init_data init = {};
 		struct clk *clk;
 		const char *parent_name;
 		struct iproc_asiu_clk *asiu_clk;
--- 0001/drivers/clk/bcm/clk-iproc-pll.c
+++ work/drivers/clk/bcm/clk-iproc-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -586,7 +586,7 @@ void __init iproc_pll_clk_setup(struct d
 	struct clk *clk;
 	struct iproc_pll *pll;
 	struct iproc_clk *iclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *parent_name;
 
 	if (WARN_ON(!pll_ctrl) || WARN_ON(!clk_ctrl))
--- 0001/drivers/clk/berlin/berlin2-avpll.c
+++ work/drivers/clk/berlin/berlin2-avpll.c	2015-09-15 19:03:12.050513000 +0900
@@ -193,7 +193,7 @@ struct clk * __init berlin2_avpll_vco_re
 			       u8 vco_flags, unsigned long flags)
 {
 	struct berlin2_avpll_vco *vco;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	vco = kzalloc(sizeof(*vco), GFP_KERNEL);
 	if (!vco)
@@ -369,7 +369,7 @@ struct clk * __init berlin2_avpll_channe
 			   u8 ch_flags, unsigned long flags)
 {
 	struct berlin2_avpll_channel *ch;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	ch = kzalloc(sizeof(*ch), GFP_KERNEL);
 	if (!ch)
--- 0001/drivers/clk/berlin/berlin2-pll.c
+++ work/drivers/clk/berlin/berlin2-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -89,7 +89,7 @@ berlin2_pll_register(const struct berlin
 		     void __iomem *base, const char *name,
 		     const char *parent_name, unsigned long flags)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct berlin2_pll *pll;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
--- 0001/drivers/clk/clk-axi-clkgen.c
+++ work/drivers/clk/clk-axi-clkgen.c	2015-09-15 19:03:12.050513000 +0900
@@ -484,7 +484,7 @@ static int axi_clkgen_probe(struct platf
 {
 	const struct of_device_id *id;
 	struct axi_clkgen *axi_clkgen;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *parent_name;
 	const char *clk_name;
 	struct resource *mem;
--- 0001/drivers/clk/clk-cdce925.c
+++ work/drivers/clk/clk-cdce925.c	2015-09-15 19:03:12.050513000 +0900
@@ -571,7 +571,7 @@ static int cdce925_probe(struct i2c_clie
 	struct device_node *node = client->dev.of_node;
 	const char *parent_name;
 	const char *pll_clk_name[NUMBER_OF_PLLS] = {NULL,};
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	u32 value;
 	int i;
--- 0001/drivers/clk/clk-composite.c
+++ work/drivers/clk/clk-composite.c	2015-09-15 19:03:12.050513000 +0900
@@ -194,7 +194,7 @@ struct clk *clk_register_composite(struc
 			unsigned long flags)
 {
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_composite *composite;
 	struct clk_ops *clk_composite_ops;
 
--- 0001/drivers/clk/clk-divider.c
+++ work/drivers/clk/clk-divider.c	2015-09-15 19:03:12.050513000 +0900
@@ -430,7 +430,7 @@ static struct clk *_register_divider(str
 {
 	struct clk_divider *div;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
 		if (width + shift > 16) {
--- 0001/drivers/clk/clk-fixed-factor.c
+++ work/drivers/clk/clk-fixed-factor.c	2015-09-15 19:03:12.050513000 +0900
@@ -75,7 +75,7 @@ struct clk *clk_register_fixed_factor(st
 		unsigned int mult, unsigned int div)
 {
 	struct clk_fixed_factor *fix;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	fix = kmalloc(sizeof(*fix), GFP_KERNEL);
--- 0001/drivers/clk/clk-fixed-rate.c
+++ work/drivers/clk/clk-fixed-rate.c	2015-09-15 19:03:12.050513000 +0900
@@ -62,7 +62,7 @@ struct clk *clk_register_fixed_rate_with
 {
 	struct clk_fixed_rate *fixed;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/* allocate fixed-rate clock */
 	fixed = kzalloc(sizeof(*fixed), GFP_KERNEL);
--- 0001/drivers/clk/clk-fractional-divider.c
+++ work/drivers/clk/clk-fractional-divider.c	2015-09-15 19:03:12.050513000 +0900
@@ -113,7 +113,7 @@ struct clk *clk_register_fractional_divi
 		u8 clk_divider_flags, spinlock_t *lock)
 {
 	struct clk_fractional_divider *fd;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
--- 0001/drivers/clk/clk-gate.c
+++ work/drivers/clk/clk-gate.c	2015-09-15 19:03:12.050513000 +0900
@@ -129,7 +129,7 @@ struct clk *clk_register_gate(struct dev
 {
 	struct clk_gate *gate;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (clk_gate_flags & CLK_GATE_HIWORD_MASK) {
 		if (bit_idx > 15) {
--- 0001/drivers/clk/clk-highbank.c
+++ work/drivers/clk/clk-highbank.c	2015-09-15 19:03:12.050513000 +0900
@@ -279,7 +279,7 @@ static __init struct clk *hb_clk_init(st
 	struct hb_clk *hb_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *srnp;
 	int rc;
 
--- 0001/drivers/clk/clk-ls1x.c
+++ work/drivers/clk/clk-ls1x.c	2015-09-15 19:03:12.050513000 +0900
@@ -55,7 +55,7 @@ static struct clk *__init clk_register_p
 {
 	struct clk_hw *hw;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/* allocate the divider */
 	hw = kzalloc(sizeof(struct clk_hw), GFP_KERNEL);
--- 0001/drivers/clk/clk-mb86s7x.c
+++ work/drivers/clk/clk-mb86s7x.c	2015-09-15 19:03:12.050513000 +0900
@@ -182,7 +182,7 @@ struct mb86s70_crg11 {
 static struct clk *crg11_get(struct of_phandle_args *clkspec, void *data)
 {
 	struct mb86s70_crg11 *crg11 = data;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	u32 cntrlr, domain, port;
 	struct crg_clk *crgclk;
 	struct clk *clk;
@@ -329,7 +329,7 @@ static struct clk_ops clk_clc_ops = {
 
 struct clk *mb86s7x_clclk_register(struct device *cpu_dev)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct cl_clk *clc;
 
 	clc = kzalloc(sizeof(*clc), GFP_KERNEL);
--- 0001/drivers/clk/clk-mux.c
+++ work/drivers/clk/clk-mux.c	2015-09-15 19:03:12.050513000 +0900
@@ -124,7 +124,7 @@ struct clk *clk_register_mux_table(struc
 {
 	struct clk_mux *mux;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	u8 width = 0;
 
 	if (clk_mux_flags & CLK_MUX_HIWORD_MASK) {
--- 0001/drivers/clk/clk-nomadik.c
+++ work/drivers/clk/clk-nomadik.c	2015-09-15 19:03:12.050513000 +0900
@@ -259,7 +259,7 @@ pll_clk_register(struct device *dev, con
 {
 	struct clk *clk;
 	struct clk_pll *pll;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (id != 1 && id != 2) {
 		pr_err("%s: the Nomadik has only PLL 1 & 2\n", __func__);
@@ -351,7 +351,7 @@ src_clk_register(struct device *dev, con
 {
 	struct clk *clk;
 	struct clk_src *sclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
 	if (!sclk) {
--- 0001/drivers/clk/clk-pwm.c
+++ work/drivers/clk/clk-pwm.c	2015-09-15 19:03:12.050513000 +0900
@@ -56,7 +56,7 @@ static const struct clk_ops clk_pwm_ops
 static int clk_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_pwm *clk_pwm;
 	struct pwm_device *pwm;
 	const char *clk_name;
--- 0001/drivers/clk/clk-qoriq.c
+++ work/drivers/clk/clk-qoriq.c	2015-09-15 19:03:12.050513000 +0900
@@ -67,7 +67,7 @@ static const struct clk_ops cmux_ops = {
 static void __init core_mux_init(struct device_node *np)
 {
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct cmux_clk *cmux_clk;
 	struct device_node *node;
 	int rc, count, i;
--- 0001/drivers/clk/clk-si5351.c
+++ work/drivers/clk/clk-si5351.c	2015-09-15 19:03:12.050513000 +0900
@@ -1310,7 +1310,7 @@ static int si5351_i2c_probe(struct i2c_c
 	enum si5351_variant variant = (enum si5351_variant)id->driver_data;
 	struct si5351_platform_data *pdata;
 	struct si5351_driver_data *drvdata;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	const char *parent_names[4];
 	u8 num_parents, num_clocks;
--- 0001/drivers/clk/clk-si570.c
+++ work/drivers/clk/clk-si570.c	2015-09-15 19:03:12.050513000 +0900
@@ -407,7 +407,7 @@ static int si570_probe(struct i2c_client
 		const struct i2c_device_id *id)
 {
 	struct clk_si570 *data;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	u32 initial_fout, factory_fout, stability;
 	int err;
--- 0001/drivers/clk/clk-stm32f4.c
+++ work/drivers/clk/clk-stm32f4.c	2015-09-15 19:03:12.050513000 +0900
@@ -207,7 +207,7 @@ static struct clk *clk_register_apb_mul(
 					unsigned long flags, u8 bit_idx)
 {
 	struct clk_apb_mul *am;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	am = kzalloc(sizeof(*am), GFP_KERNEL);
--- 0001/drivers/clk/clk-u300.c
+++ work/drivers/clk/clk-u300.c	2015-09-15 19:03:12.050513000 +0900
@@ -699,7 +699,7 @@ syscon_clk_register(struct device *dev,
 {
 	struct clk *clk;
 	struct clk_syscon *sclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	sclk = kzalloc(sizeof(struct clk_syscon), GFP_KERNEL);
 	if (!sclk) {
@@ -1117,7 +1117,7 @@ mclk_clk_register(struct device *dev, co
 {
 	struct clk *clk;
 	struct clk_mclk *mclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	mclk = kzalloc(sizeof(struct clk_mclk), GFP_KERNEL);
 	if (!mclk) {
--- 0001/drivers/clk/clk-vt8500.c
+++ work/drivers/clk/clk-vt8500.c	2015-09-15 19:03:12.050513000 +0900
@@ -236,7 +236,7 @@ static __init void vtwm_device_clk_init(
 	struct clk_device *dev_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 	int clk_init_flags = 0;
 
@@ -654,7 +654,7 @@ static __init void vtwm_pll_clk_init(str
 	struct clk_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 
 	if (!pmc_base)
--- 0001/drivers/clk/clk-xgene.c
+++ work/drivers/clk/clk-xgene.c	2015-09-15 19:03:12.050513000 +0900
@@ -130,7 +130,7 @@ static struct clk *xgene_register_clk_pl
 {
 	struct xgene_clk_pll *apmclk;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/* allocate the APM clock structure */
 	apmclk = kzalloc(sizeof(*apmclk), GFP_KERNEL);
@@ -402,7 +402,7 @@ static struct clk *xgene_register_clk(st
 {
 	struct xgene_clk *apmclk;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 
 	/* allocate the APM clock structure */
--- 0001/drivers/clk/h8300/clk-h8s2678.c
+++ work/drivers/clk/h8300/clk-h8s2678.c	2015-09-15 19:03:12.050513000 +0900
@@ -88,7 +88,7 @@ static void __init h8s2678_pll_clk_setup
 	const char *clk_name = node->name;
 	const char *parent_name;
 	struct pll_clock *pll_clock;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	num_parents = of_clk_get_parent_count(node);
 	if (num_parents < 1) {
--- 0001/drivers/clk/hisilicon/clk-hi3620.c
+++ work/drivers/clk/hisilicon/clk-hi3620.c	2015-09-15 19:03:12.050513000 +0900
@@ -427,7 +427,7 @@ static struct clk *hisi_register_clk_mmc
 {
 	struct clk_mmc *mclk;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	mclk = kzalloc(sizeof(*mclk), GFP_KERNEL);
 	if (!mclk) {
--- 0001/drivers/clk/hisilicon/clk-hi6220-stub.c
+++ work/drivers/clk/hisilicon/clk-hi6220-stub.c	2015-09-15 19:03:12.050513000 +0900
@@ -197,7 +197,7 @@ static const struct clk_ops hi6220_stub_
 static int hi6220_stub_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct hi6220_stub_clk *stub_clk;
 	struct clk *clk;
 	struct device_node *np = pdev->dev.of_node;
--- 0001/drivers/clk/hisilicon/clk-hix5hd2.c
+++ work/drivers/clk/hisilicon/clk-hix5hd2.c	2015-09-15 19:03:12.050513000 +0900
@@ -262,7 +262,7 @@ hix5hd2_clk_register_complex(struct hix5
 	for (i = 0; i < nums; i++) {
 		struct hix5hd2_clk_complex *p_clk;
 		struct clk *clk;
-		struct clk_init_data init;
+		struct clk_init_data init = {};
 
 		p_clk = kzalloc(sizeof(*p_clk), GFP_KERNEL);
 		if (!p_clk)
--- 0001/drivers/clk/hisilicon/clkdivider-hi6220.c
+++ work/drivers/clk/hisilicon/clkdivider-hi6220.c	2015-09-15 19:03:12.050513000 +0900
@@ -105,7 +105,7 @@ struct clk *hi6220_register_clkdiv(struc
 {
 	struct hi6220_clk_divider *div;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_div_table *table;
 	u32 max_div, min_div;
 	int i;
--- 0001/drivers/clk/hisilicon/clkgate-separated.c
+++ work/drivers/clk/hisilicon/clkgate-separated.c	2015-09-15 19:03:12.050513000 +0900
@@ -102,7 +102,7 @@ struct clk *hisi_register_clkgate_sep(st
 {
 	struct clkgate_separated *sclk;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	sclk = kzalloc(sizeof(*sclk), GFP_KERNEL);
 	if (!sclk) {
--- 0001/drivers/clk/imx/clk-busy.c
+++ work/drivers/clk/imx/clk-busy.c	2015-09-15 19:03:12.050513000 +0900
@@ -84,7 +84,7 @@ struct clk *imx_clk_busy_divider(const c
 {
 	struct clk_busy_divider *busy;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
 	if (!busy)
@@ -158,7 +158,7 @@ struct clk *imx_clk_busy_mux(const char
 {
 	struct clk_busy_mux *busy;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	busy = kzalloc(sizeof(*busy), GFP_KERNEL);
 	if (!busy)
--- 0001/drivers/clk/imx/clk-cpu.c
+++ work/drivers/clk/imx/clk-cpu.c	2015-09-15 19:03:12.050513000 +0900
@@ -81,7 +81,7 @@ struct clk *imx_clk_cpu(const char *name
 {
 	struct clk_cpu *cpu;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	cpu = kzalloc(sizeof(*cpu), GFP_KERNEL);
 	if (!cpu)
--- 0001/drivers/clk/imx/clk-fixup-div.c
+++ work/drivers/clk/imx/clk-fixup-div.c	2015-09-15 19:03:12.050513000 +0900
@@ -98,7 +98,7 @@ struct clk *imx_clk_fixup_divider(const
 {
 	struct clk_fixup_div *fixup_div;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!fixup)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/imx/clk-fixup-mux.c
+++ work/drivers/clk/imx/clk-fixup-mux.c	2015-09-15 19:03:12.050513000 +0900
@@ -77,7 +77,7 @@ struct clk *imx_clk_fixup_mux(const char
 {
 	struct clk_fixup_mux *fixup_mux;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (!fixup)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/imx/clk-gate-exclusive.c
+++ work/drivers/clk/imx/clk-gate-exclusive.c	2015-09-15 19:03:12.050513000 +0900
@@ -64,7 +64,7 @@ struct clk *imx_clk_gate_exclusive(const
 	struct clk_gate_exclusive *exgate;
 	struct clk_gate *gate;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (exclusive_mask = 0)
 		return ERR_PTR(-EINVAL);
--- 0001/drivers/clk/imx/clk-gate2.c
+++ work/drivers/clk/imx/clk-gate2.c	2015-09-15 19:03:12.050513000 +0900
@@ -131,7 +131,7 @@ struct clk *clk_register_gate2(struct de
 {
 	struct clk_gate2 *gate;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	gate = kzalloc(sizeof(struct clk_gate2), GFP_KERNEL);
 	if (!gate)
--- 0001/drivers/clk/imx/clk-pfd.c
+++ work/drivers/clk/imx/clk-pfd.c	2015-09-15 19:03:12.050513000 +0900
@@ -132,7 +132,7 @@ struct clk *imx_clk_pfd(const char *name
 {
 	struct clk_pfd *pfd;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pfd = kzalloc(sizeof(*pfd), GFP_KERNEL);
 	if (!pfd)
--- 0001/drivers/clk/imx/clk-pllv1.c
+++ work/drivers/clk/imx/clk-pllv1.c	2015-09-15 19:03:12.050513000 +0900
@@ -115,7 +115,7 @@ struct clk *imx_clk_pllv1(enum imx_pllv1
 {
 	struct clk_pllv1 *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll = kmalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
--- 0001/drivers/clk/imx/clk-pllv2.c
+++ work/drivers/clk/imx/clk-pllv2.c	2015-09-15 19:03:12.050513000 +0900
@@ -242,7 +242,7 @@ struct clk *imx_clk_pllv2(const char *na
 {
 	struct clk_pllv2 *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
--- 0001/drivers/clk/imx/clk-pllv3.c
+++ work/drivers/clk/imx/clk-pllv3.c	2015-09-15 19:03:12.050513000 +0900
@@ -289,7 +289,7 @@ struct clk *imx_clk_pllv3(enum imx_pllv3
 	struct clk_pllv3 *pll;
 	const struct clk_ops *ops;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
--- 0001/drivers/clk/ingenic/cgu.c
+++ work/drivers/clk/ingenic/cgu.c	2015-09-15 19:03:12.050513000 +0900
@@ -502,7 +502,7 @@ static const struct clk_ops ingenic_clk_
 static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 {
 	const struct ingenic_cgu_clk_info *clk_info = &cgu->clock_info[idx];
-	struct clk_init_data clk_init;
+	struct clk_init_data clk_init = {};
 	struct ingenic_clk *ingenic_clk = NULL;
 	struct clk *clk, *parent;
 	const char *parent_names[4];
--- 0001/drivers/clk/keystone/gate.c
+++ work/drivers/clk/keystone/gate.c	2015-09-15 19:03:12.050513000 +0900
@@ -168,7 +168,7 @@ static struct clk *clk_register_psc(stru
 			struct clk_psc_data *psc_data,
 			spinlock_t *lock)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_psc *psc;
 	struct clk *clk;
 
--- 0001/drivers/clk/keystone/pll.c
+++ work/drivers/clk/keystone/pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -126,7 +126,7 @@ static struct clk *clk_register_pll(stru
 			const char *parent_name,
 			struct clk_pll_data *pll_data)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_pll *pll;
 	struct clk *clk;
 
--- 0001/drivers/clk/meson/clk-cpu.c
+++ work/drivers/clk/meson/clk-cpu.c	2015-09-15 19:03:12.050513000 +0900
@@ -189,7 +189,7 @@ struct clk *meson_clk_register_cpu(const
 	struct clk *clk;
 	struct clk *pclk;
 	struct meson_clk_cpu *clk_cpu;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	clk_cpu = kzalloc(sizeof(*clk_cpu), GFP_KERNEL);
--- 0001/drivers/clk/meson/clk-pll.c
+++ work/drivers/clk/meson/clk-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -189,7 +189,7 @@ struct clk *meson_clk_register_pll(const
 {
 	struct clk *clk;
 	struct meson_clk_pll *clk_pll;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	clk_pll = kzalloc(sizeof(*clk_pll), GFP_KERNEL);
 	if (!clk_pll)
--- 0001/drivers/clk/mmp/clk-apbc.c
+++ work/drivers/clk/mmp/clk-apbc.c	2015-09-15 19:03:12.050513000 +0900
@@ -125,7 +125,7 @@ struct clk *mmp_clk_register_apbc(const
 {
 	struct clk_apbc *apbc;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	apbc = kzalloc(sizeof(*apbc), GFP_KERNEL);
 	if (!apbc)
--- 0001/drivers/clk/mmp/clk-apmu.c
+++ work/drivers/clk/mmp/clk-apmu.c	2015-09-15 19:03:12.050513000 +0900
@@ -70,7 +70,7 @@ struct clk *mmp_clk_register_apmu(const
 {
 	struct clk_apmu *apmu;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	apmu = kzalloc(sizeof(*apmu), GFP_KERNEL);
 	if (!apmu)
--- 0001/drivers/clk/mmp/clk-frac.c
+++ work/drivers/clk/mmp/clk-frac.c	2015-09-15 19:03:12.050513000 +0900
@@ -163,7 +163,7 @@ struct clk *mmp_clk_register_factor(cons
 		unsigned int ftbl_cnt, spinlock_t *lock)
 {
 	struct mmp_clk_factor *factor;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	if (!masks) {
--- 0001/drivers/clk/mmp/clk-gate.c
+++ work/drivers/clk/mmp/clk-gate.c	2015-09-15 19:03:12.050513000 +0900
@@ -99,7 +99,7 @@ struct clk *mmp_clk_register_gate(struct
 {
 	struct mmp_clk_gate *gate;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/* allocate the gate */
 	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
--- 0001/drivers/clk/mmp/clk-mix.c
+++ work/drivers/clk/mmp/clk-mix.c	2015-09-15 19:03:12.050513000 +0900
@@ -447,7 +447,7 @@ struct clk *mmp_clk_register_mix(struct
 {
 	struct mmp_clk_mix *mix;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	size_t table_bytes;
 
 	mix = kzalloc(sizeof(*mix), GFP_KERNEL);
--- 0001/drivers/clk/mvebu/clk-corediv.c
+++ work/drivers/clk/mvebu/clk-corediv.c	2015-09-15 19:03:12.050513000 +0900
@@ -236,7 +236,7 @@ static void __init
 mvebu_corediv_clk_init(struct device_node *node,
 		       const struct clk_corediv_soc_desc *soc_desc)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_corediv *corediv;
 	struct clk **clks;
 	void __iomem *base;
--- 0001/drivers/clk/mvebu/clk-cpu.c
+++ work/drivers/clk/mvebu/clk-cpu.c	2015-09-15 19:03:12.050513000 +0900
@@ -195,7 +195,7 @@ static void __init of_cpu_clk_setup(stru
 		goto clks_out;
 
 	for_each_node_by_type(dn, "cpu") {
-		struct clk_init_data init;
+		struct clk_init_data init = {};
 		struct clk *clk;
 		char *clk_name = kzalloc(5, GFP_KERNEL);
 		int cpu, err;
--- 0001/drivers/clk/mxs/clk-div.c
+++ work/drivers/clk/mxs/clk-div.c	2015-09-15 19:03:12.050513000 +0900
@@ -78,7 +78,7 @@ struct clk *mxs_clk_div(const char *name
 {
 	struct clk_div *div;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	div = kzalloc(sizeof(*div), GFP_KERNEL);
 	if (!div)
--- 0001/drivers/clk/mxs/clk-frac.c
+++ work/drivers/clk/mxs/clk-frac.c	2015-09-15 19:03:12.050513000 +0900
@@ -112,7 +112,7 @@ struct clk *mxs_clk_frac(const char *nam
 {
 	struct clk_frac *frac;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	frac = kzalloc(sizeof(*frac), GFP_KERNEL);
 	if (!frac)
--- 0001/drivers/clk/mxs/clk-pll.c
+++ work/drivers/clk/mxs/clk-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -90,7 +90,7 @@ struct clk *mxs_clk_pll(const char *name
 {
 	struct clk_pll *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
--- 0001/drivers/clk/mxs/clk-ref.c
+++ work/drivers/clk/mxs/clk-ref.c	2015-09-15 19:03:12.050513000 +0900
@@ -129,7 +129,7 @@ struct clk *mxs_clk_ref(const char *name
 {
 	struct clk_ref *ref;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	ref = kzalloc(sizeof(*ref), GFP_KERNEL);
 	if (!ref)
--- 0001/drivers/clk/pistachio/clk-pll.c
+++ work/drivers/clk/pistachio/clk-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -453,7 +453,7 @@ static struct clk *pll_register(const ch
 				unsigned int nr_rates)
 {
 	struct pistachio_clk_pll *pll;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
--- 0001/drivers/clk/rockchip/clk-cpu.c
+++ work/drivers/clk/rockchip/clk-cpu.c	2015-09-15 19:03:12.050513000 +0900
@@ -238,7 +238,7 @@ struct clk *rockchip_clk_register_cpuclk
 			int nrates, void __iomem *reg_base, spinlock_t *lock)
 {
 	struct rockchip_cpuclk *cpuclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk, *cclk;
 	int ret;
 
--- 0001/drivers/clk/rockchip/clk-inverter.c
+++ work/drivers/clk/rockchip/clk-inverter.c	2015-09-15 19:03:12.050513000 +0900
@@ -84,7 +84,7 @@ struct clk *rockchip_clk_register_invert
 				void __iomem *reg, int shift, int flags,
 				spinlock_t *lock)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct rockchip_inv_clock *inv_clock;
 	struct clk *clk;
 
--- 0001/drivers/clk/rockchip/clk-mmc-phase.c
+++ work/drivers/clk/rockchip/clk-mmc-phase.c	2015-09-15 19:03:12.050513000 +0900
@@ -126,7 +126,7 @@ struct clk *rockchip_clk_register_mmc(co
 				const char *const *parent_names, u8 num_parents,
 				void __iomem *reg, int shift)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct rockchip_mmc_clock *mmc_clock;
 	struct clk *clk;
 
--- 0001/drivers/clk/rockchip/clk-pll.c
+++ work/drivers/clk/rockchip/clk-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -335,7 +335,7 @@ struct clk *rockchip_clk_register_pll(en
 		u8 clk_pll_flags, spinlock_t *lock)
 {
 	const char *pll_parents[3];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct rockchip_clk_pll *pll;
 	struct clk_mux *pll_mux;
 	struct clk *pll_clk, *mux_clk;
--- 0001/drivers/clk/samsung/clk-cpu.c
+++ work/drivers/clk/samsung/clk-cpu.c	2015-09-15 19:03:12.050513000 +0900
@@ -281,7 +281,7 @@ int __init exynos_register_cpu_clock(str
 		unsigned long num_cfgs, unsigned long flags)
 {
 	struct exynos_cpuclk *cpuclk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 	int ret = 0;
 
--- 0001/drivers/clk/samsung/clk-pll.c
+++ work/drivers/clk/samsung/clk-pll.c	2015-09-15 19:03:12.050513000 +0900
@@ -929,7 +929,7 @@ struct clk * __init samsung_clk_register
 {
 	struct samsung_clk_pll2550x *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll) {
@@ -1163,7 +1163,7 @@ static void __init _samsung_clk_register
 {
 	struct samsung_clk_pll *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret, len;
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
--- 0001/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ work/drivers/clk/samsung/clk-s3c2410-dclk.c	2015-09-15 19:03:12.050513000 +0900
@@ -97,7 +97,7 @@ static struct clk *s3c24xx_register_clko
 {
 	struct s3c24xx_clkout *clkout;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/* allocate the clkout */
 	clkout = kzalloc(sizeof(*clkout), GFP_KERNEL);
--- 0001/drivers/clk/shmobile/clk-div6.c
+++ work/drivers/clk/shmobile/clk-div6.c	2015-09-15 19:03:12.050513000 +0900
@@ -176,7 +176,7 @@ static void __init cpg_div6_clock_init(s
 {
 	unsigned int num_parents, valid_parents;
 	const char **parent_names;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct div6_clock *clock;
 	const char *name;
 	struct clk *clk;
--- 0001/drivers/clk/shmobile/clk-mstp.c
+++ work/drivers/clk/shmobile/clk-mstp.c	2015-09-15 19:03:12.050513000 +0900
@@ -131,7 +131,7 @@ static struct clk * __init
 cpg_mstp_clock_register(const char *name, const char *parent_name,
 			unsigned int index, struct mstp_clock_group *group)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct mstp_clock *clock;
 	struct clk *clk;
 
--- 0001/drivers/clk/shmobile/clk-rcar-gen2.c
+++ work/drivers/clk/shmobile/clk-rcar-gen2.c	2015-09-15 19:03:12.050513000 +0900
@@ -138,7 +138,7 @@ static const struct clk_ops cpg_z_clk_op
 static struct clk * __init cpg_z_clk_register(struct rcar_gen2_cpg *cpg)
 {
 	static const char *parent_name = "pll0";
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct cpg_z_clk *zclk;
 	struct clk *clk;
 
--- 0001/drivers/clk/sirf/clk-atlas7.c
+++ work/drivers/clk/sirf/clk-atlas7.c	2015-09-15 19:03:12.060513000 +0900
@@ -1236,7 +1236,7 @@ atlas7_unit_clk_register(struct device *
 {
 	struct clk *clk;
 	struct clk_unit *unit;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	unit = kzalloc(sizeof(*unit), GFP_KERNEL);
 	if (!unit)
--- 0001/drivers/clk/socfpga/clk-gate-a10.c
+++ work/drivers/clk/socfpga/clk-gate-a10.c	2015-09-15 19:03:12.060513000 +0900
@@ -113,7 +113,7 @@ static void __init __socfpga_gate_init(s
 	struct socfpga_gate_clk *socfpga_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 	int i = 0;
 
--- 0001/drivers/clk/socfpga/clk-gate.c
+++ work/drivers/clk/socfpga/clk-gate.c	2015-09-15 19:03:12.060513000 +0900
@@ -187,7 +187,7 @@ static void __init __socfpga_gate_init(s
 	struct socfpga_gate_clk *socfpga_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 
 	socfpga_clk = kzalloc(sizeof(*socfpga_clk), GFP_KERNEL);
--- 0001/drivers/clk/socfpga/clk-periph-a10.c
+++ work/drivers/clk/socfpga/clk-periph-a10.c	2015-09-15 19:03:12.060513000 +0900
@@ -75,7 +75,7 @@ static __init void __socfpga_periph_init
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
 	const char *parent_name;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 	u32 fixed_div;
 	u32 div_reg[3];
--- 0001/drivers/clk/socfpga/clk-periph.c
+++ work/drivers/clk/socfpga/clk-periph.c	2015-09-15 19:03:12.060513000 +0900
@@ -65,7 +65,7 @@ static __init void __socfpga_periph_init
 	struct socfpga_periph_clk *periph_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int rc;
 	u32 fixed_div;
 	u32 div_reg[3];
--- 0001/drivers/clk/socfpga/clk-pll-a10.c
+++ work/drivers/clk/socfpga/clk-pll-a10.c	2015-09-15 19:03:12.060513000 +0900
@@ -82,7 +82,7 @@ static struct __init clk * __socfpga_pll
 	struct socfpga_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFGPA_MAX_PARENTS];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *clkmgr_np;
 	int rc;
 	int i = 0;
--- 0001/drivers/clk/socfpga/clk-pll.c
+++ work/drivers/clk/socfpga/clk-pll.c	2015-09-15 19:03:12.060513000 +0900
@@ -88,7 +88,7 @@ static __init struct clk *__socfpga_pll_
 	struct socfpga_pll *pll_clk;
 	const char *clk_name = node->name;
 	const char *parent_name[SOCFPGA_MAX_PARENTS];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *clkmgr_np;
 	int rc;
 
--- 0001/drivers/clk/spear/clk-aux-synth.c
+++ work/drivers/clk/spear/clk-aux-synth.c	2015-09-15 19:03:12.060513000 +0900
@@ -140,7 +140,7 @@ struct clk *clk_register_aux(const char
 		u8 rtbl_cnt, spinlock_t *lock, struct clk **gate_clk)
 {
 	struct clk_aux *aux;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	if (!aux_name || !parent_name || !reg || !rtbl || !rtbl_cnt) {
--- 0001/drivers/clk/spear/clk-frac-synth.c
+++ work/drivers/clk/spear/clk-frac-synth.c	2015-09-15 19:03:12.060513000 +0900
@@ -126,7 +126,7 @@ struct clk *clk_register_frac(const char
 		unsigned long flags, void __iomem *reg,
 		struct frac_rate_tbl *rtbl, u8 rtbl_cnt, spinlock_t *lock)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_frac *frac;
 	struct clk *clk;
 
--- 0001/drivers/clk/spear/clk-gpt-synth.c
+++ work/drivers/clk/spear/clk-gpt-synth.c	2015-09-15 19:03:12.060513000 +0900
@@ -115,7 +115,7 @@ struct clk *clk_register_gpt(const char
 		long flags, void __iomem *reg, struct gpt_rate_tbl *rtbl, u8
 		rtbl_cnt, spinlock_t *lock)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk_gpt *gpt;
 	struct clk *clk;
 
--- 0001/drivers/clk/spear/clk-vco-pll.c
+++ work/drivers/clk/spear/clk-vco-pll.c	2015-09-15 19:03:12.060513000 +0900
@@ -282,7 +282,8 @@ struct clk *clk_register_vco_pll(const c
 	struct clk_vco *vco;
 	struct clk_pll *pll;
 	struct clk *vco_clk, *tpll_clk, *tvco_gate_clk;
-	struct clk_init_data vco_init, pll_init;
+	struct clk_init_data vco_init = {};
+	struct clk_init_data pll_init = {};
 	const char **vco_parent_name;
 
 	if (!vco_name || !pll_name || !parent_name || !mode_reg || !cfg_reg ||
--- 0001/drivers/clk/st/clk-flexgen.c
+++ work/drivers/clk/st/clk-flexgen.c	2015-09-15 19:03:12.060513000 +0900
@@ -181,7 +181,7 @@ static struct clk *clk_register_flexgen(
 				unsigned long flexgen_flags) {
 	struct flexgen *fgxbar;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	u32  xbar_shift;
 	void __iomem *xbar_reg, *fdiv_reg;
 
--- 0001/drivers/clk/st/clkgen-fsyn.c
+++ work/drivers/clk/st/clkgen-fsyn.c	2015-09-15 19:03:12.060513000 +0900
@@ -622,7 +622,7 @@ static struct clk * __init st_clk_regist
 {
 	struct st_clk_quadfs_pll *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/*
 	 * Sanity check required pointers.
@@ -1026,7 +1026,7 @@ static struct clk * __init st_clk_regist
 {
 	struct st_clk_quadfs_fsynth *fs;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/*
 	 * Sanity check required pointers, note that nsdiv3 is optional.
--- 0001/drivers/clk/st/clkgen-mux.c
+++ work/drivers/clk/st/clkgen-mux.c	2015-09-15 19:03:12.060513000 +0900
@@ -226,7 +226,7 @@ static struct clk * __init clk_register_
 	const int divider_width = 5;
 	struct clkgena_divmux *genamux;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int i;
 
 	genamux = kzalloc(sizeof(*genamux), GFP_KERNEL);
--- 0001/drivers/clk/st/clkgen-pll.c
+++ work/drivers/clk/st/clkgen-pll.c	2015-09-15 19:03:12.060513000 +0900
@@ -398,7 +398,7 @@ static struct clk * __init clkgen_pll_re
 {
 	struct clkgen_pll *pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
--- 0001/drivers/clk/sunxi/clk-sun6i-ar100.c
+++ work/drivers/clk/sunxi/clk-sun6i-ar100.c	2015-09-15 19:03:12.060513000 +0900
@@ -177,7 +177,7 @@ static int sun6i_a31_ar100_clk_probe(str
 	const char *parents[SUN6I_AR100_MAX_PARENTS];
 	struct device_node *np = pdev->dev.of_node;
 	const char *clk_name = np->name;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct ar100_clk *ar100;
 	struct resource *r;
 	struct clk *clk;
--- 0001/drivers/clk/tegra/clk-audio-sync.c
+++ work/drivers/clk/tegra/clk-audio-sync.c	2015-09-15 19:03:12.060513000 +0900
@@ -58,7 +58,7 @@ struct clk *tegra_clk_register_sync_sour
 		unsigned long rate, unsigned long max_rate)
 {
 	struct tegra_clk_sync_source *sync;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct clk *clk;
 
 	sync = kzalloc(sizeof(*sync), GFP_KERNEL);
--- 0001/drivers/clk/tegra/clk-divider.c
+++ work/drivers/clk/tegra/clk-divider.c	2015-09-15 19:03:12.060513000 +0900
@@ -153,7 +153,7 @@ struct clk *tegra_clk_register_divider(c
 {
 	struct tegra_clk_frac_div *divider;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	divider = kzalloc(sizeof(*divider), GFP_KERNEL);
 	if (!divider) {
--- 0001/drivers/clk/tegra/clk-emc.c
+++ work/drivers/clk/tegra/clk-emc.c	2015-09-15 19:03:12.060513000 +0900
@@ -473,7 +473,7 @@ struct clk *tegra_clk_register_emc(void
 				   spinlock_t *lock)
 {
 	struct tegra_clk_emc *tegra;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct device_node *node;
 	u32 node_ram_code;
 	struct clk *clk;
--- 0001/drivers/clk/tegra/clk-periph-gate.c
+++ work/drivers/clk/tegra/clk-periph-gate.c	2015-09-15 19:03:12.060513000 +0900
@@ -133,7 +133,7 @@ struct clk *tegra_clk_register_periph_ga
 {
 	struct tegra_clk_periph_gate *gate;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct tegra_clk_periph_regs *pregs;
 
 	pregs = get_reg_bank(clk_num);
--- 0001/drivers/clk/tegra/clk-periph.c
+++ work/drivers/clk/tegra/clk-periph.c	2015-09-15 19:03:12.060513000 +0900
@@ -144,7 +144,7 @@ static struct clk *_tegra_clk_register_p
 			unsigned long flags)
 {
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct tegra_clk_periph_regs *bank;
 	bool div = !(periph->gate.flags & TEGRA_PERIPH_NO_DIV);
 
--- 0001/drivers/clk/tegra/clk-pll-out.c
+++ work/drivers/clk/tegra/clk-pll-out.c	2015-09-15 19:03:12.060513000 +0900
@@ -93,7 +93,7 @@ struct clk *tegra_clk_register_pll_out(c
 {
 	struct tegra_clk_pll_out *pll_out;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	pll_out = kzalloc(sizeof(*pll_out), GFP_KERNEL);
 	if (!pll_out)
--- 0001/drivers/clk/tegra/clk-pll.c
+++ work/drivers/clk/tegra/clk-pll.c	2015-09-15 19:03:12.060513000 +0900
@@ -1437,7 +1437,7 @@ static struct clk *_tegra_clk_register_p
 		const char *name, const char *parent_name, unsigned long flags,
 		const struct clk_ops *ops)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	init.name = name;
 	init.ops = ops;
--- 0001/drivers/clk/tegra/clk-super.c
+++ work/drivers/clk/tegra/clk-super.c	2015-09-15 19:03:12.060513000 +0900
@@ -133,7 +133,7 @@ struct clk *tegra_clk_register_super_mux
 {
 	struct tegra_clk_super_mux *super;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	super = kzalloc(sizeof(*super), GFP_KERNEL);
 	if (!super) {
--- 0001/drivers/clk/ti/clk-dra7-atl.c
+++ work/drivers/clk/ti/clk-dra7-atl.c	2015-09-15 19:03:12.060513000 +0900
@@ -168,7 +168,7 @@ static const struct clk_ops atl_clk_ops
 static void __init of_dra7_atl_clock_setup(struct device_node *node)
 {
 	struct dra7_atl_desc *clk_hw = NULL;
-	struct clk_init_data init = { NULL };
+	struct clk_init_data init = {};
 	const char **parent_names = NULL;
 	struct clk *clk;
 
--- 0001/drivers/clk/ti/divider.c
+++ work/drivers/clk/ti/divider.c	2015-09-15 19:03:12.060513000 +0900
@@ -261,7 +261,7 @@ static struct clk *_register_divider(str
 {
 	struct clk_divider *div;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
 		if (width + shift > 16) {
--- 0001/drivers/clk/ti/dpll.c
+++ work/drivers/clk/ti/dpll.c	2015-09-15 19:03:12.060513000 +0900
@@ -194,7 +194,7 @@ static void __iomem *_get_reg(u8 module,
 struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 {
 	struct clk_hw_omap *clk_hw;
-	struct clk_init_data init = { NULL };
+	struct clk_init_data init = {};
 	struct dpll_data *dd;
 	struct clk *clk;
 	struct ti_clk_dpll *dpll;
@@ -291,7 +291,7 @@ static void _register_dpll_x2(struct dev
 			      const struct clk_hw_omap_ops *hw_ops)
 {
 	struct clk *clk;
-	struct clk_init_data init = { NULL };
+	struct clk_init_data init = {};
 	struct clk_hw_omap *clk_hw;
 	const char *name = node->name;
 	const char *parent_name;
--- 0001/drivers/clk/ti/gate.c
+++ work/drivers/clk/ti/gate.c	2015-09-15 19:03:12.060513000 +0900
@@ -98,7 +98,7 @@ static struct clk *_register_gate(struct
 				  u8 clk_gate_flags, const struct clk_ops *ops,
 				  const struct clk_hw_omap_ops *hw_ops)
 {
-	struct clk_init_data init = { NULL };
+	struct clk_init_data init = {};
 	struct clk_hw_omap *clk_hw;
 	struct clk *clk;
 
--- 0001/drivers/clk/ti/interface.c
+++ work/drivers/clk/ti/interface.c	2015-09-15 19:03:12.060513000 +0900
@@ -37,7 +37,7 @@ static struct clk *_register_interface(s
 				       void __iomem *reg, u8 bit_idx,
 				       const struct clk_hw_omap_ops *ops)
 {
-	struct clk_init_data init = { NULL };
+	struct clk_init_data init = {};
 	struct clk_hw_omap *clk_hw;
 	struct clk *clk;
 
--- 0001/drivers/clk/ti/mux.c
+++ work/drivers/clk/ti/mux.c	2015-09-15 19:03:12.060513000 +0900
@@ -113,7 +113,7 @@ static struct clk *_register_mux(struct
 {
 	struct clk_mux *mux;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	/* allocate the mux */
 	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
--- 0001/drivers/clk/ux500/clk-prcc.c
+++ work/drivers/clk/ux500/clk-prcc.c	2015-09-15 19:03:12.060513000 +0900
@@ -99,7 +99,7 @@ static struct clk *clk_reg_prcc(const ch
 				struct clk_ops *clk_prcc_ops)
 {
 	struct clk_prcc *clk;
-	struct clk_init_data clk_prcc_init;
+	struct clk_init_data clk_prcc_init = {};
 	struct clk *clk_reg;
 
 	if (!name) {
--- 0001/drivers/clk/ux500/clk-prcmu.c
+++ work/drivers/clk/ux500/clk-prcmu.c	2015-09-15 19:03:12.060513000 +0900
@@ -250,7 +250,7 @@ static struct clk *clk_reg_prcmu(const c
 				 struct clk_ops *clk_prcmu_ops)
 {
 	struct clk_prcmu *clk;
-	struct clk_init_data clk_prcmu_init;
+	struct clk_init_data clk_prcmu_init = {};
 	struct clk *clk_reg;
 
 	if (!name) {
--- 0001/drivers/clk/ux500/clk-sysctrl.c
+++ work/drivers/clk/ux500/clk-sysctrl.c	2015-09-15 19:03:12.060513000 +0900
@@ -127,7 +127,7 @@ static struct clk *clk_reg_sysctrl(struc
 				struct clk_ops *clk_sysctrl_ops)
 {
 	struct clk_sysctrl *clk;
-	struct clk_init_data clk_sysctrl_init;
+	struct clk_init_data clk_sysctrl_init = {};
 	struct clk *clk_reg;
 	int i;
 
--- 0001/drivers/clk/versatile/clk-icst.c
+++ work/drivers/clk/versatile/clk-icst.c	2015-09-15 19:03:12.060513000 +0900
@@ -130,7 +130,7 @@ struct clk *icst_clk_register(struct dev
 {
 	struct clk *clk;
 	struct clk_icst *icst;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct icst_params *pclone;
 
 	icst = kzalloc(sizeof(struct clk_icst), GFP_KERNEL);
--- 0001/drivers/clk/versatile/clk-sp810.c
+++ work/drivers/clk/versatile/clk-sp810.c	2015-09-15 19:03:12.060513000 +0900
@@ -91,7 +91,7 @@ static void __init clk_sp810_of_setup(st
 	const char *parent_names[2];
 	int num = ARRAY_SIZE(parent_names);
 	char name[12];
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int i;
 	bool deprecated;
 
--- 0001/drivers/clk/versatile/clk-vexpress-osc.c
+++ work/drivers/clk/versatile/clk-vexpress-osc.c	2015-09-15 19:03:12.060513000 +0900
@@ -70,7 +70,7 @@ static struct clk_ops vexpress_osc_ops  
 static int vexpress_osc_probe(struct platform_device *pdev)
 {
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	struct vexpress_osc *osc;
 	struct clk *clk;
 	u32 range[2];
--- 0001/drivers/clk/zte/clk.c
+++ work/drivers/clk/zte/clk.c	2015-09-15 19:03:12.060513000 +0900
@@ -149,7 +149,7 @@ struct clk *clk_register_zx_pll(const ch
 {
 	struct clk_zx_pll *zx_pll;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	zx_pll = kzalloc(sizeof(*zx_pll), GFP_KERNEL);
 	if (!zx_pll)
@@ -286,7 +286,7 @@ struct clk *clk_register_zx_audio(const
 {
 	struct clk_zx_audio *zx_audio;
 	struct clk *clk;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 
 	zx_audio = kzalloc(sizeof(*zx_audio), GFP_KERNEL);
 	if (!zx_audio)
