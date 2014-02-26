From: Benoit Cousson <bcousson@baylibre.com>
Date: Wed, 26 Feb 2014 23:09:49 +0000
Subject: [RFC 3/4] ARM: shmobile: lager-reference: Add cpufreq-cpu0 device for CPUFreq support
Message-Id: <1393456190-7870-4-git-send-email-bcousson@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Statically create a cpufreq-cpu0 device during machine init to allow
the cpufreq-cpu0 driver to be bound to this device.

Since this device is a fake one, it cannot be created by devicetree
devices population.

Signed-off-by: Benoit Cousson <bcousson+renesas@baylibre.com>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 440aac3..bedc5c3 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -27,6 +27,7 @@
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/rcar-gen2.h>
+#include <linux/platform_device.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
@@ -130,6 +131,8 @@ static void __init lager_add_standard_devices(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
+
+	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.8.3.2

