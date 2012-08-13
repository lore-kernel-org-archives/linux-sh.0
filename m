From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 22:42:21 +0000
Subject: [Demo/RFC][PATCH 2/2] ARM: shmobile: A3SM PM domain object for cpuidle connection testing
Message-Id: <201208140042.21309.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Add a PM domain object for the A3SM domain on SH7372 (normally, that
is not necessary, because A3SM only contains the CPU core) and add
the "fake" device introduced by the previous patch to that domain,
so that it can be turned "off" and "on" on demand from user space.
Additionally, attach state 3 from the SH7372 cpuidle driver to
that domain for handling through the mechanism introduced by commit
cbc9ef0 (PM / Domains: Add preliminary support for cpuidle, v2).

With this patch it can be demonstrated that if the "fake" device is
turned "on", the A3SM domain will be turned "on" and cpuidle state 3
will not be used any more until the "fake" device is turned "off",
which causes the A3SM to be turned "off" and allow cpuidle to use
its state 3 again.

Proof of concept patch, no sign-off.
---
 arch/arm/mach-shmobile/board-mackerel.c |    9 ++++++++-
 arch/arm/mach-shmobile/pm-sh7372.c      |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -110,6 +110,12 @@ static int sh7372_a3sp_pd_suspend(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
+static int sh7372_a3sm_pd_suspend(void)
+{
+	pr_warning("%s: This code shouldn't be running!\n", __func__);
+	return -EBUSY;
+}
+
 static struct rmobile_pm_domain sh7372_pm_domains[] = {
 	{
 		.genpd.name = "A4LC",
@@ -174,6 +180,12 @@ static struct rmobile_pm_domain sh7372_p
 		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 13,
 	},
+	{
+		.genpd.name = "A3SM",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.suspend = sh7372_a3sm_pd_suspend,
+	},
 };
 
 void __init sh7372_init_pm_domains(void)
@@ -183,6 +195,7 @@ void __init sh7372_init_pm_domains(void)
 	pm_genpd_add_subdomain_names("A4R", "A4LC");
 	pm_genpd_add_subdomain_names("A4S", "A3SG");
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	pm_genpd_add_subdomain_names("A4S", "A3SM");
 }
 
 #endif /* CONFIG_PM */
@@ -409,6 +422,7 @@ static struct cpuidle_driver sh7372_cpui
 		.target_residency = 30 + 120,
 		.flags = CPUIDLE_FLAG_TIME_VALID,
 		.enter = sh7372_enter_a3sm_pll_off,
+		.disabled = true,
 	},
 };
 
Index: linux/arch/arm/mach-shmobile/board-mackerel.c
=================================--- linux.orig/arch/arm/mach-shmobile/board-mackerel.c
+++ linux/arch/arm/mach-shmobile/board-mackerel.c
@@ -1433,6 +1433,7 @@ static void __init mackerel_init(void)
 #endif
 		{ "A3SP", &sdhi2_device, },
 		{ "A4R", &ceu_device, },
+		{ "A3SM", &fake_device, },
 	};
 	u32 srcr4;
 	struct clk *clk;
@@ -1657,12 +1658,18 @@ static void __init mackerel_init(void)
 	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
 }
 
+static void mackerel_init_late(void)
+{
+	shmobile_init_late();
+	pm_genpd_name_attach_cpuidle("A3SM", 3);
+}
+
 MACHINE_START(MACKEREL, "mackerel")
 	.map_io		= sh7372_map_io,
 	.init_early	= sh7372_add_early_devices,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
 	.init_machine	= mackerel_init,
-	.init_late	= shmobile_init_late,
+	.init_late	= mackerel_init_late,
 	.timer		= &shmobile_timer,
 MACHINE_END

