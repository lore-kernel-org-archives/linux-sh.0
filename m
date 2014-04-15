From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:11 +0000
Subject: [PATCH RFC v2 15/17] ARM: shmobile: r8a7778: Populate .init_machine for generic r8a7778
Message-Id: <1397565253-22741-16-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/setup-r8a7778.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 6d694526e4ca..6d5b5df0407f 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -614,6 +614,14 @@ void __init r8a7778_init_irq_dt(void)
 	iounmap(base);
 }
 
+void __init r8a7778_add_standard_devices_dt(void)
+{
+	sh_pm_runtime_init();
+	r8a7778_clock_init();
+	r8a7778_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *r8a7778_compat_dt[] __initdata = {
 	"renesas,r8a7778",
 	NULL,
@@ -622,6 +630,7 @@ static const char *r8a7778_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
+	.init_machine	= r8a7778_add_standard_devices_dt,
 	.dt_compat	= r8a7778_compat_dt,
 	.init_late      = r8a7778_init_late,
 MACHINE_END
-- 
1.7.9.5

