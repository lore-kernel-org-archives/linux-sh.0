From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 13:10:15 +0000
Subject: [PATCH] ARM: shmobile: ape6evm: Remove duplicate CPUFreq bits
Message-Id: <20140820131015.373.91949.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The CPUFreq platform device is already registered by
shmobile_init_late(), so get rid of ape6evm specific bits.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built of top of renesas-devel-20140820-v3.17-rc1

 arch/arm/mach-shmobile/board-ape6evm-reference.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ work/arch/arm/mach-shmobile/board-ape6evm-reference.c	2014-08-20 19:34:53.000000000 +0900
@@ -50,7 +50,6 @@ static void __init ape6evm_add_standard_
 
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
