From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 27 May 2011 23:19:27 +0000
Subject: [PATCH 5/5] ARM / shmobile: Support for power domain A4MP on SH7372
Message-Id: <201105280119.27410.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl> <201105160117.46927.rjw@sisk.pl> <201105280115.14556.rjw@sisk.pl>
In-Reply-To: <201105280115.14556.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Alan Stern <stern@rowland.harvard.edu>

From: Rafael J. Wysocki <rjw@sisk.pl>

Use the power domains support code added by the previous
patches to implement support for power domain A4MP on SH7372.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/board-mackerel.c      |    2 ++
 arch/arm/mach-shmobile/include/mach/sh7372.h |    3 +++
 arch/arm/mach-shmobile/pm-sh7372.c           |    7 +++++++
 3 files changed, 12 insertions(+)

Index: linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
=================================--- linux-2.6.orig/arch/arm/mach-shmobile/pm-sh7372.c
+++ linux-2.6/arch/arm/mach-shmobile/pm-sh7372.c
@@ -104,9 +104,16 @@ static struct sh7372_domain_data sh7372_
 
 struct generic_power_domain sh7372_a4lc_domain;
 
+static struct sh7372_domain_data sh7372_a4mp_domain_data = {
+	.bit_shift = 2,
+};
+
+struct generic_power_domain sh7372_a4mp_domain;
+
 static int __init sh7372_power_domains_init(void)
 {
 	sh7372_init_domain(&sh7372_a4lc_domain, &sh7372_a4lc_domain_data);
+	sh7372_init_domain(&sh7372_a4mp_domain, &sh7372_a4mp_domain_data);
 	return 0;
 }
 core_initcall(sh7372_power_domains_init);
Index: linux-2.6/arch/arm/mach-shmobile/include/mach/sh7372.h
=================================--- linux-2.6.orig/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ linux-2.6/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -476,11 +476,14 @@ struct platform_device;
 #ifdef CONFIG_PM
 extern struct generic_power_domain sh7372_a4lc_domain;
 #define SH7372_A4LC	(&sh7372_a4lc_domain)
+extern struct generic_power_domain sh7372_a4mp_domain;
+#define SH7372_A4MP	(&sh7372_a4mp_domain)
 
 extern void sh7372_add_device_to_domain(struct generic_power_domain *domain,
 					struct platform_device *pdev);
 #else
 #define SH7372_A4LC	NULL
+#define SH7372_A4PM	NULL
 
 static inline void sh7372_add_device_to_domain(struct generic_power_domain *dom,
 					       struct platform_device *pd) {}
Index: linux-2.6/arch/arm/mach-shmobile/board-mackerel.c
=================================--- linux-2.6.orig/arch/arm/mach-shmobile/board-mackerel.c
+++ linux-2.6/arch/arm/mach-shmobile/board-mackerel.c
@@ -1421,6 +1421,8 @@ static void __init mackerel_init(void)
 	sh7372_add_device_to_domain(SH7372_A4LC, &lcdc_device);
 	sh7372_add_device_to_domain(SH7372_A4LC, &hdmi_lcdc_device);
 
+	sh7372_add_device_to_domain(SH7372_A4MP, &fsi_device);
+
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
 }

