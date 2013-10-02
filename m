From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 06:13:27 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7778: split r8a7778_init_irq_extpin() for DT
Message-Id: <87wqlwyzcr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7778 INTC needs IRL pin mode settings to determine
behavior of IRQ0 - IRQ3, and r8a7778_init_irq_extpin()
is controlling it via irlm parameter.
But this function registers renesas_intc_irqpin driver
if irlm was set, and this value depends on platform.
This is not good for DT.
This patch splits r8a7778_init_irq_extpin() function
into "mode settings" and "funtion register" parts.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |    6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 6d0abb7..441886c 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -38,6 +38,7 @@ extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
+extern void r8a7778_init_irq_extpin_dt(int irlm);
 extern void r8a7778_pinmux_init(void);
 
 extern int r8a7778_usb_phy_power(bool enable);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 460814e..03fcc59 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -428,7 +428,7 @@ static struct resource irqpin_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x3e)), /* IRQ3 */
 };
 
-void __init r8a7778_init_irq_extpin(int irlm)
+void __init r8a7778_init_irq_extpin_dt(int irlm)
 {
 	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
 	unsigned long tmp;
@@ -446,7 +446,11 @@ void __init r8a7778_init_irq_extpin(int irlm)
 	tmp |= (1 << 21); /* LVLMODE = 1 */
 	iowrite32(tmp, icr0);
 	iounmap(icr0);
+}
 
+void __init r8a7778_init_irq_extpin(int irlm)
+{
+	r8a7778_init_irq_extpin_dt(irlm);
 	if (irlm)
 		platform_device_register_resndata(
 			&platform_bus, "renesas_intc_irqpin", -1,
-- 
1.7.9.5

