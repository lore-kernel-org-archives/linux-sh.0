From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Oct 2013 07:20:32 +0000
Subject: [PATCH v3 3/3] ARM: shmobile: lager: add CPUFreq support
Message-Id: <1380871232-31896-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a cpufreq-cpu0 platform device on Lager to instantiate the cpufreq-cpu0
CPUFreq driver for the CA15 boot-mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v3: board part of former patch 5/5

 arch/arm/mach-shmobile/board-lager-reference.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1a1a4a8..2bc8bae 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -20,6 +20,7 @@
 
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
@@ -29,7 +30,8 @@ static void __init lager_add_standard_devices(void)
 	r8a7790_clock_init();
 
 	r8a7790_add_dt_devices();
-        of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.7.2.5

