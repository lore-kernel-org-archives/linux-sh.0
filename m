From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Nov 2015 19:19:38 +0000
Subject: [RFC v3 4/5] ARM: shmobile: r8a7790: let rst module allow watchdog resets if desired
Message-Id: <1446405579-5367-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Just for testing, not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 9eccde3c7b1371..cb55b627cd8a0c 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -28,7 +28,18 @@
 #include "common.h"
 #include "rcar-gen2.h"
 
-#define MODEMR 0xe6160060
+#define WDTRSTCR	0xe6160054
+#define MODEMR		0xe6160060
+
+void __init rcar_gen2_wdt_rst_init(void)
+{
+#if defined(CONFIG_WATCHDOG)
+	void __iomem *p = ioremap_nocache(WDTRSTCR, 4);
+	BUG_ON(!p);
+	iowrite32(0xa55a0000, p);
+	iounmap(p);
+#endif
+}
 
 u32 rcar_gen2_read_mode_pins(void)
 {
@@ -129,6 +140,9 @@ void __init rcar_gen2_timer_init(void)
 
 	rcar_gen2_clocks_init(mode);
 	clocksource_probe();
+
+	/* allow watchdog timers to trigger reset */
+	rcar_gen2_wdt_rst_init();
 }
 
 struct memory_reserve_config {
-- 
2.1.4

