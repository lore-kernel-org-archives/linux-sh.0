From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:16:01 +0000
Subject: [PATCH 07/08] ARM: shmobile: Hook up r8a7790 PM code for Multiplatform
Message-Id: <20140605051601.18075.60382.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the r8a7790 multiplatform code to call
r8a7790_pm_init() at ->init_machine() timing
to allow setup of APMU Suspend-to-RAM in the
case when SMP is disabled.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2014-06-05 12:53:53.000000000 +0900
@@ -281,6 +281,7 @@ static struct resource cmt0_resources[]
 
 void __init r8a7790_add_dt_devices(void)
 {
+	r8a7790_pm_init();
 	r8a7790_register_cmt(0);
 }
 
@@ -308,6 +309,11 @@ void __init r8a7790_add_standard_devices
 }
 
 #ifdef CONFIG_USE_OF
+static void __init r8a7790_init_machine(void)
+{
+	r8a7790_pm_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
 
 static const char * const r8a7790_boards_compat_dt[] __initconst = {
 	"renesas,r8a7790",
@@ -318,6 +324,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
+	.init_machine	= r8a7790_init_machine,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
