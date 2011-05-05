From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 16:30:17 +0000
Subject: [PATCH] ARM: mach-shmobile: add definitions for 3 more power domains
Message-Id: <Pine.LNX.4.64.1105051826080.29735@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Rafael, a modest contribution to your power-domains branch;) I've also had 
to add devices to these domains in my tests, but we have to be careful 
with those additions. Not all, what's logical, works... E.g., to test PM 
with some devices / drivers, certain other devices had to be disabled, 
which is, certainly, not suitable for the mainline. We'll have to think 
about what and how exactly to mainline a bit more.

 arch/arm/mach-shmobile/include/mach/sh7372.h |    9 +++++++++
 arch/arm/mach-shmobile/pm-sh7372.c           |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 8372c8f..6a290b7 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -474,12 +474,21 @@ struct platform_device;
 
 #ifdef CONFIG_PM
 extern struct generic_power_domain sh7372_a4lc_domain;
+extern struct generic_power_domain sh7372_a4mp_domain;
+extern struct generic_power_domain sh7372_a4r_domain;
+extern struct generic_power_domain sh7372_a3sp_domain;
 #define SH7372_A4LC	(&sh7372_a4lc_domain)
+#define SH7372_A4MP	(&sh7372_a4mp_domain)
+#define SH7372_A4R	(&sh7372_a4r_domain)
+#define SH7372_A3SP	(&sh7372_a3sp_domain)
 
 extern void sh7372_add_device_to_domain(struct generic_power_domain *domain,
 					struct platform_device *pdev);
 #else
 #define SH7372_A4LC	NULL
+#define SH7372_A4MP	NULL
+#define SH7372_A4R	NULL
+#define SH7372_A3SP	NULL
 
 static inline void sh7372_add_device_to_domain(struct generic_power_domain *dom,
 					       struct platform_device *pd) {}
diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
index 589bb0d..1bf3351 100644
--- a/arch/arm/mach-shmobile/pm-sh7372.c
+++ b/arch/arm/mach-shmobile/pm-sh7372.c
@@ -88,11 +88,29 @@ static struct sh7372_domain_data sh7372_a4lc_domain_data = {
 	.bit_shift = 1,
 };
 
+static struct sh7372_domain_data sh7372_a4mp_domain_data = {
+	.bit_shift = 2,
+};
+
+static struct sh7372_domain_data sh7372_a4r_domain_data = {
+	.bit_shift = 5,
+};
+
+static struct sh7372_domain_data sh7372_a3sp_domain_data = {
+	.bit_shift = 11,
+};
+
 struct generic_power_domain sh7372_a4lc_domain;
+struct generic_power_domain sh7372_a4mp_domain;
+struct generic_power_domain sh7372_a4r_domain;
+struct generic_power_domain sh7372_a3sp_domain;
 
 static int __init sh7372_power_domains_init(void)
 {
 	sh7372_init_domain(&sh7372_a4lc_domain, &sh7372_a4lc_domain_data);
+	sh7372_init_domain(&sh7372_a4lc_domain, &sh7372_a4mp_domain_data);
+	sh7372_init_domain(&sh7372_a4r_domain, &sh7372_a4r_domain_data);
+	sh7372_init_domain(&sh7372_a3sp_domain, &sh7372_a3sp_domain_data);
 	return 0;
 }
 core_initcall(sh7372_power_domains_init);
-- 
1.7.2.5

