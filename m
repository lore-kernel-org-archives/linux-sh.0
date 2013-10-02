From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 06:19:35 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7779: split r8a7779_init_irq_extpin() for DT
Message-Id: <87r4c4yz2k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7779 INTC needs IRL pin mode settings to determine
behavior of IRQ0 - IRQ3, and r8a7779_init_irq_extpin()
is controlling it via irlm parameter.
But this function registers renesas_intc_irqpin driver
if irlm was set, and this value depends on platform.
This is not good for DT.
This patch splits r8a7779_init_irq_extpin() function
into "mode settings" and "funtion register" parts,
and add status = "disabled" on r8a7779.dtsi as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi                |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c        |    6 +++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 912b3a0..19faeac 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -135,6 +135,7 @@
 	irqpin0: irqpin@fe780010 {
 		compatible = "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
+		status = "disabled";
 		interrupt-controller;
 		reg = <0xfe78001c 4>,
 			<0xfe780010 4>,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 31e87b9..17af34e 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -33,6 +33,7 @@ static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 
 extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq_extpin(int irlm);
+extern void r8a7779_init_irq_extpin_dt(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index eacb2f7..13049e9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -98,7 +98,7 @@ static struct resource irqpin0_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ3 */
 };
 
-void __init r8a7779_init_irq_extpin(int irlm)
+void __init r8a7779_init_irq_extpin_dt(int irlm)
 {
 	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
 	u32 tmp;
@@ -116,7 +116,11 @@ void __init r8a7779_init_irq_extpin(int irlm)
 	tmp |= (1 << 21); /* LVLMODE = 1 */
 	iowrite32(tmp, icr0);
 	iounmap(icr0);
+}
 
+void __init r8a7779_init_irq_extpin(int irlm)
+{
+	r8a7779_init_irq_extpin_dt(irlm);
 	if (irlm)
 		platform_device_register_resndata(
 			&platform_bus, "renesas_intc_irqpin", -1,
-- 
1.7.9.5

