From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 07 Aug 2012 22:27:10 +0000
Subject: [PATCH 1/4] PM / shmobile: Set PM domain on/off latencies directly
Message-Id: <201208080027.10394.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207212349.18294.rjw@sisk.pl> <201208080026.01738.rjw@sisk.pl>
In-Reply-To: <201208080026.01738.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


The results of adaptive latency computations in __pm_genpd_poweron()
and pm_genpd_poweroff() show that the power on/power off latencies
of all power domains in SH7372 are a little below 250 us.  Therefore,
if 250 us is used as the common initial value of the latency fields
in struct generic_pm_domain for all domains, the latency values
will never have to change at run time and there won't be any overhead
related to re-computation of the corresponding PM QoS data.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/pm-sh7372.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Index: linux/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux/arch/arm/mach-shmobile/pm-sh7372.c
@@ -71,6 +71,8 @@
 
 #ifdef CONFIG_PM
 
+#define PM_DOMAIN_ON_OFF_LATENCY_NS	250000
+
 static int sh7372_a4r_pd_suspend(void)
 {
 	sh7372_intcs_suspend();
@@ -110,32 +112,46 @@ static int sh7372_a3sp_pd_suspend(void)
 static struct rmobile_pm_domain sh7372_pm_domains[] = {
 	{
 		.genpd.name = "A4LC",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 1,
 	},
 	{
 		.genpd.name = "A4MP",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 2,
 	},
 	{
 		.genpd.name = "D4",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 3,
 	},
 	{
 		.genpd.name = "A4R",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 5,
 		.suspend = sh7372_a4r_pd_suspend,
 		.resume = sh7372_intcs_resume,
 	},
 	{
 		.genpd.name = "A3RV",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 6,
 	},
 	{
 		.genpd.name = "A3RI",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 8,
 	},
 	{
 		.genpd.name = "A4S",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 10,
 		.gov = &pm_domain_always_on_gov,
 		.no_debug = true,
@@ -144,6 +160,8 @@ static struct rmobile_pm_domain sh7372_p
 	},
 	{
 		.genpd.name = "A3SP",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 11,
 		.gov = &pm_domain_always_on_gov,
 		.no_debug = true,
@@ -151,6 +169,8 @@ static struct rmobile_pm_domain sh7372_p
 	},
 	{
 		.genpd.name = "A3SG",
+		.genpd.power_on_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
+		.genpd.power_off_latency_ns = PM_DOMAIN_ON_OFF_LATENCY_NS,
 		.bit_shift = 13,
 	},
 };

