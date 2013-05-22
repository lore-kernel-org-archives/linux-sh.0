From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 May 2013 06:04:14 +0000
Subject: [PATCH] ARM: shmobile: Always use shmobile_setup_delay() on sh73a0
Message-Id: <20130522060414.905.98035.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Break out the function sh73a0_init_delay() that now
gets called both for the C version of the code and
the DT -reference boards. This way we handle both
cases in the same way.

Allows us to boot with TWD only in the kernel configuration
for C board code. TWD is not yet enabled in the case of
DT -reference - this due to a dependency on CCF.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Developed and tested against v3.10-rc2.

 arch/arm/mach-shmobile/setup-sh73a0.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- 0002/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-05-20 17:20:48.000000000 +0900
@@ -916,11 +916,17 @@ void __init sh73a0_add_standard_devices(
 			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
+void __init sh73a0_init_delay(void)
+{
+	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+}
+
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak sh73a0_register_twd(void) { }
 
 void __init sh73a0_earlytimer_init(void)
 {
+	sh73a0_init_delay();
 	sh73a0_clock_init();
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
@@ -939,11 +945,6 @@ void __init sh73a0_add_early_devices(voi
 
 #ifdef CONFIG_USE_OF
 
-void __init sh73a0_init_delay(void)
-{
-	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
-}
-
 static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
 	{},
 };
