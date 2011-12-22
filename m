From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Dec 2011 08:12:04 +0000
Subject: [PATCH] ARM: mach-shmobile: r8a7779 power domain support
Message-Id: <20111222081204.12120.92511.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add power domain control support for the r8a7779 SoC.

This adds support for 4 power domains for I/O Devices
together with code that can be used for CPU cores as well.

The only out of the ordinary experience is the need for
ioremap() of SYSC registers. Because of that we need to
execute some init function before setting up the domains.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Built on top of linux-3.2-rc + r8a7779 patches for now.
 Needs to be reworked to fit on top of the linux-pm tree.

 arch/arm/mach-shmobile/Makefile               |    1 
 arch/arm/mach-shmobile/include/mach/common.h  |    1 
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   35 +++
 arch/arm/mach-shmobile/pm-r8a7779.c           |  235 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7779.c        |    8 
 5 files changed, 280 insertions(+)

--- 0015/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-12-22 16:21:03.000000000 +0900
@@ -37,6 +37,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= entry-gic.
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
+obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
--- 0015/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-12-22 16:21:03.000000000 +0900
@@ -58,5 +58,6 @@ extern void r8a7779_add_early_devices(vo
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
+extern void r8a7779_pm_init(void);
 
 #endif /* __ARCH_MACH_COMMON_H */
--- 0016/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7779.h	2011-12-22 16:22:01.000000000 +0900
@@ -1,6 +1,9 @@
 #ifndef __ASM_R8A7779_H__
 #define __ASM_R8A7779_H__
 
+#include <linux/sh_clk.h>
+#include <linux/pm_domain.h>
+
 /* Pin Function Controller:
  * GPIO_FN_xx - GPIO used to select pin function
  * GPIO_GP_x_x - GPIO mapped to real I/O pin on CPU
@@ -322,4 +325,36 @@ enum {
 	GPIO_FN_GPS_MAG, GPIO_FN_FCE, GPIO_FN_SCK4_B,
 };
 
+struct platform_device;
+
+struct r8a7779_pm_ch {
+	unsigned long chan_offs;
+	unsigned int chan_bit;
+	unsigned int isr_bit;
+};
+
+struct r8a7779_pm_domain {
+	struct generic_pm_domain genpd;
+	struct r8a7779_pm_ch ch;
+};
+
+static inline struct r8a7779_pm_ch *to_r8a7779_ch(struct generic_pm_domain *d)
+{
+	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
+}
+
+#ifdef CONFIG_PM
+extern struct r8a7779_pm_domain r8a7779_sh4a;
+extern struct r8a7779_pm_domain r8a7779_sgx;
+extern struct r8a7779_pm_domain r8a7779_vdp1;
+extern struct r8a7779_pm_domain r8a7779_impx3;
+
+extern void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd);
+extern void r8a7779_add_device_to_domain(struct r8a7779_pm_domain *r8a7779_pd,
+					struct platform_device *pdev);
+#else
+#define r8a7779_init_pm_domain(pd) do { } while (0)
+#define r8a7779_add_device_to_domain(pd, pdev) do { } while (0)
+#endif /* CONFIG_PM */
+
 #endif /* __ASM_R8A7779_H__ */
--- /dev/null
+++ work/arch/arm/mach-shmobile/pm-r8a7779.c	2011-12-22 16:21:44.000000000 +0900
@@ -0,0 +1,235 @@
+/*
+ * r8a7779 Power management support
+ *
+ * Copyright (C) 2011  Renesas Solutions Corp.
+ * Copyright (C) 2011  Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/err.h>
+#include <linux/pm_clock.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/console.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <mach/common.h>
+#include <mach/r8a7779.h>
+
+static void __iomem *r8a7779_sysc_base;
+
+/* SYSC */
+#define SYSCSR 0x00
+#define SYSCISR 0x04
+#define SYSCISCR 0x08
+#define SYSCIER 0x0c
+#define SYSCIMR 0x10
+#define PWRSR0 0x40
+#define PWRSR1 0x80
+#define PWRSR2 0xc0
+#define PWRSR3 0x100
+#define PWRSR4 0x140
+
+#define PWRSR_OFFS 0x00
+#define PWROFFCR_OFFS 0x04
+#define PWRONCR_OFFS 0x0c
+#define PWRER_OFFS 0x14
+
+#define SYSCSR_RETRIES 100
+#define SYSCSR_DELAY_US 1
+
+#define SYSCISR_RETRIES 1000
+#define SYSCISR_DELAY_US 1
+
+#ifdef CONFIG_PM
+
+static int r8a7779_sysc_pwr_on_off(struct r8a7779_pm_ch *r8a7779_ch,
+				   int sr_bit, int reg_offs)
+{
+	int k;
+
+	for (k = 0; k < SYSCSR_RETRIES; k++) {
+		if (ioread32(r8a7779_sysc_base + SYSCSR) & (1 << sr_bit))
+			break;
+		udelay(SYSCSR_DELAY_US);
+	}
+
+	if (k = SYSCSR_RETRIES)
+		return -EAGAIN;
+
+	iowrite32(1 << r8a7779_ch->chan_bit,
+		  r8a7779_sysc_base + r8a7779_ch->chan_offs + reg_offs);
+
+	return 0;
+}
+
+static int r8a7779_sysc_pwr_off(struct r8a7779_pm_ch *r8a7779_ch)
+{
+	return r8a7779_sysc_pwr_on_off(r8a7779_ch, 0, PWROFFCR_OFFS);
+}
+
+static int r8a7779_sysc_pwr_on(struct r8a7779_pm_ch *r8a7779_ch)
+{
+	return r8a7779_sysc_pwr_on_off(r8a7779_ch, 1, PWRONCR_OFFS);
+}
+
+static int r8a7779_sysc_update(struct r8a7779_pm_ch *r8a7779_ch,
+			       int (*on_off_fn)(struct r8a7779_pm_ch *))
+{
+	unsigned int isr_mask = 1 << r8a7779_ch->isr_bit;
+	unsigned int chan_mask = 1 << r8a7779_ch->chan_bit;
+	unsigned int status;
+	int ret = 0;
+	int k;
+
+	iowrite32(isr_mask, r8a7779_sysc_base + SYSCISCR);
+
+	do {
+		ret = on_off_fn(r8a7779_ch);
+		if (ret)
+			goto out;
+
+		status = ioread32(r8a7779_sysc_base +
+				  r8a7779_ch->chan_offs + PWRER_OFFS);
+	} while (status & chan_mask);
+
+	for (k = 0; k < SYSCISR_RETRIES; k++) {
+		if (ioread32(r8a7779_sysc_base + SYSCISR) & isr_mask)
+			break;
+		udelay(SYSCISR_DELAY_US);
+	}
+
+	if (k = SYSCISR_RETRIES)
+		ret = -EIO;
+
+	iowrite32(isr_mask, r8a7779_sysc_base + SYSCISCR);
+
+ out:
+	pr_debug("r8a7779 power domain %d: %02x %02x %02x %02x %02x -> %d\n",
+		 r8a7779_ch->isr_bit, ioread32(r8a7779_sysc_base + PWRSR0),
+		 ioread32(r8a7779_sysc_base + PWRSR1),
+		 ioread32(r8a7779_sysc_base + PWRSR2),
+		 ioread32(r8a7779_sysc_base + PWRSR3),
+		 ioread32(r8a7779_sysc_base + PWRSR4), ret);
+	return ret;
+}
+
+static int r8a7779_sysc_power_down(struct r8a7779_pm_ch *r8a7779_ch)
+{
+	return r8a7779_sysc_update(r8a7779_ch, r8a7779_sysc_pwr_off);
+}
+
+static int r8a7779_sysc_power_up(struct r8a7779_pm_ch *r8a7779_ch)
+{
+	return r8a7779_sysc_update(r8a7779_ch, r8a7779_sysc_pwr_on);
+}
+
+static void __init r8a7779_sysc_init(void)
+{
+	r8a7779_sysc_base = ioremap_nocache(0xffd85000, PAGE_SIZE);
+	if (!r8a7779_sysc_base)
+		panic("unable to ioremap r8a7779 SYSC hardware block\n");
+
+	/* enable all interrupt sources, but do not use interrupt handler */
+	iowrite32(0x0131000e, r8a7779_sysc_base + SYSCIER);
+	iowrite32(0, r8a7779_sysc_base + SYSCIMR);
+}
+
+static int pd_power_down(struct generic_pm_domain *genpd)
+{
+	return r8a7779_sysc_power_down(to_r8a7779_ch(genpd));
+}
+
+static int pd_power_up(struct generic_pm_domain *genpd)
+{
+	return r8a7779_sysc_power_up(to_r8a7779_ch(genpd));
+}
+
+static bool pd_is_off(struct generic_pm_domain *genpd)
+{
+	struct r8a7779_pm_ch *r8a7779_ch = to_r8a7779_ch(genpd);
+	unsigned int st;
+
+	st = ioread32(r8a7779_sysc_base + r8a7779_ch->chan_offs + PWRSR_OFFS);
+	if (st & (1 << r8a7779_ch->chan_bit))
+		return true;
+
+	return false;
+}
+
+static bool pd_active_wakeup(struct device *dev)
+{
+	return true;
+}
+
+void r8a7779_init_pm_domain(struct r8a7779_pm_domain *r8a7779_pd)
+{
+	struct generic_pm_domain *genpd = &r8a7779_pd->genpd;
+
+	pm_genpd_init(genpd, NULL, false);
+	genpd->stop_device = pm_clk_suspend;
+	genpd->start_device = pm_clk_resume;
+	genpd->dev_irq_safe = true;
+	genpd->active_wakeup = pd_active_wakeup;
+	genpd->power_off = pd_power_down;
+	genpd->power_on = pd_power_up;
+
+	if (pd_is_off(&r8a7779_pd->genpd))
+		pd_power_up(&r8a7779_pd->genpd);
+}
+
+void r8a7779_add_device_to_domain(struct r8a7779_pm_domain *r8a7779_pd,
+				 struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	pm_genpd_add_device(&r8a7779_pd->genpd, dev);
+	if (pm_clk_no_clocks(dev))
+		pm_clk_add(dev, NULL);
+}
+
+struct r8a7779_pm_domain r8a7779_sh4a = {
+	.ch = {
+		.chan_offs = 0x80, /* PWRSR1 .. PWRER1 */
+		.isr_bit = 16, /* SH4A */
+	}
+};
+
+struct r8a7779_pm_domain r8a7779_sgx = {
+	.ch = {
+		.chan_offs = 0xc0, /* PWRSR2 .. PWRER2 */
+		.isr_bit = 20, /* SGX */
+	}
+};
+
+struct r8a7779_pm_domain r8a7779_vdp1 = {
+	.ch = {
+		.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
+		.isr_bit = 21, /* VDP */
+	}
+};
+
+struct r8a7779_pm_domain r8a7779_impx3 = {
+	.ch = {
+		.chan_offs = 0x140, /* PWRSR4 .. PWRER4 */
+		.isr_bit = 24, /* IMP */
+	}
+};
+
+#else /* CONFIG_PM */
+
+static inline void r8a7779_sysc_init(void) {}
+
+#endif /* CONFIG_PM */
+
+void __init r8a7779_pm_init(void)
+{
+	r8a7779_sysc_init();
+}
--- 0021/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2011-12-22 16:21:03.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
+#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -218,6 +219,13 @@ static struct platform_device *r8a7779_l
 
 void __init r8a7779_add_standard_devices(void)
 {
+	r8a7779_pm_init();
+
+	r8a7779_init_pm_domain(&r8a7779_sh4a);
+	r8a7779_init_pm_domain(&r8a7779_sgx);
+	r8a7779_init_pm_domain(&r8a7779_vdp1);
+	r8a7779_init_pm_domain(&r8a7779_impx3);
+
 	platform_add_devices(r8a7779_early_devices,
 			    ARRAY_SIZE(r8a7779_early_devices));
 	platform_add_devices(r8a7779_late_devices,
