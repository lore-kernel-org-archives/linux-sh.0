From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Feb 2013 13:49:47 +0000
Subject: [PATCH] ARM: shmobile: Make EMEV2 setup functions static
Message-Id: <20130213134947.12392.92386.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Adjust emev2_init_delay() and emev2_add_standard_devices_dt()
to become static. They are not used outside this file anyway.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-02-13 19:41:52.000000000 +0900
@@ -404,7 +404,7 @@ void __init emev2_add_standard_devices(v
 			     ARRAY_SIZE(emev2_late_devices));
 }
 
-void __init emev2_init_delay(void)
+static void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
 }
@@ -439,7 +439,7 @@ static const struct of_dev_auxdata emev2
 	{ }
 };
 
-void __init emev2_add_standard_devices_dt(void)
+static void __init emev2_add_standard_devices_dt(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     emev2_auxdata_lookup, NULL);
