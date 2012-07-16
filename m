From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 16 Jul 2012 21:27:43 +0000
Subject: [RFC][PATCH 10/14] ARM: shmobile: Move r8a7740's PM domain objects to a table
Message-Id: <201207162327.44312.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207032302.17805.rjw@sisk.pl> <201207052217.48086.rjw@sisk.pl> <201207162315.49073.rjw@sisk.pl>
In-Reply-To: <201207162315.49073.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Linux-sh list <linux-sh@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Instead of giving a name to every r8a7740's PM domain object, put
them all into a table and use rmobile_init_domains(), introduced by a
previous patch, for initializing them all altogether.  Also, use
pm_genpd_add_subdomain_names() for adding A3SP as a subdomain of A4S.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    6 +--
 arch/arm/mach-shmobile/pm-r8a7740.c           |   42 ++++++++++++++------------
 arch/arm/mach-shmobile/setup-r8a7740.c        |    7 ----
 3 files changed, 28 insertions(+), 27 deletions(-)

Index: linux/arch/arm/mach-shmobile/pm-r8a7740.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-r8a7740.c
+++ linux/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -21,14 +21,6 @@ static int r8a7740_pd_a4s_suspend(void)
 	return -EBUSY;
 }
 
-struct rmobile_pm_domain r8a7740_pd_a4s = {
-	.genpd.name	= "A4S",
-	.bit_shift	= 10,
-	.gov		= &pm_domain_always_on_gov,
-	.no_debug	= true,
-	.suspend	= r8a7740_pd_a4s_suspend,
-};
-
 static int r8a7740_pd_a3sp_suspend(void)
 {
 	/*
@@ -38,17 +30,31 @@ static int r8a7740_pd_a3sp_suspend(void)
 	return console_suspend_enabled ? 0 : -EBUSY;
 }
 
-struct rmobile_pm_domain r8a7740_pd_a3sp = {
-	.genpd.name	= "A3SP",
-	.bit_shift	= 11,
-	.gov		= &pm_domain_always_on_gov,
-	.no_debug	= true,
-	.suspend	= r8a7740_pd_a3sp_suspend,
+static struct rmobile_pm_domain r8a7740_pm_domains[] = {
+	{
+		.genpd.name	= "A4S",
+		.bit_shift	= 10,
+		.gov		= &pm_domain_always_on_gov,
+		.no_debug	= true,
+		.suspend	= r8a7740_pd_a4s_suspend,
+	},
+	{
+		.genpd.name	= "A3SP",
+		.bit_shift	= 11,
+		.gov		= &pm_domain_always_on_gov,
+		.no_debug	= true,
+		.suspend	= r8a7740_pd_a3sp_suspend,
+	},
+	{
+		.genpd.name	= "A4LC",
+		.bit_shift	= 1,
+	},
 };
 
-struct rmobile_pm_domain r8a7740_pd_a4lc = {
-	.genpd.name	= "A4LC",
-	.bit_shift	= 1,
-};
+void __init r8a7740_init_pm_domains(void)
+{
+	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
+	pm_genpd_add_subdomain_names("A4S", "A3SP");
+}
 
 #endif /* CONFIG_PM */
Index: linux/arch/arm/mach-shmobile/setup-r8a7740.c
=================================--- linux.orig/arch/arm/mach-shmobile/setup-r8a7740.c
+++ linux/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -673,12 +673,7 @@ void __init r8a7740_add_standard_devices
 	r8a7740_i2c_workaround(&i2c0_device);
 	r8a7740_i2c_workaround(&i2c1_device);
 
-	/* PM domain */
-	rmobile_init_pm_domain(&r8a7740_pd_a4s);
-	rmobile_init_pm_domain(&r8a7740_pd_a3sp);
-	rmobile_init_pm_domain(&r8a7740_pd_a4lc);
-
-	pm_genpd_add_subdomain_names("A4S", "A3SP");
+	r8a7740_init_pm_domains();
 
 	/* add devices */
 	platform_add_devices(r8a7740_early_devices,
Index: linux/arch/arm/mach-shmobile/include/mach/r8a7740.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ linux/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -607,9 +607,9 @@ enum {
 };
 
 #ifdef CONFIG_PM
-extern struct rmobile_pm_domain r8a7740_pd_a4s;
-extern struct rmobile_pm_domain r8a7740_pd_a3sp;
-extern struct rmobile_pm_domain r8a7740_pd_a4lc;
+extern void __init r8a7740_init_pm_domains(void);
+#else
+static inline void r8a7740_init_pm_domains(void) {}
 #endif /* CONFIG_PM */
 
 #endif /* __ASM_R8A7740_H__ */

