From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 08 Apr 2013 09:36:22 +0000
Subject: [PATCH 10/10] ARM: shmobile: lager: Initialize pinmux
Message-Id: <1365413782-17036-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Initialize r8a7790 pinmuxing and register mappings for the two debug
serial ports.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f587187..c863bc7 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -21,15 +21,30 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static const struct pinctrl_map lager_pinctrl_map[] = {
+	/* SCIF0 (CN19: DEBUG SERIAL0) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
+				  "scif0_data", "scif0"),
+	/* SCIF1 (CN20: DEBUG SERIAL1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
+				  "scif1_data", "scif1"),
+};
+
 static void __init lager_add_standard_devices(void)
 {
 	r8a7790_clock_init();
+
+	pinctrl_register_mappings(lager_pinctrl_map,
+				  ARRAY_SIZE(lager_pinctrl_map));
+	r8a7790_pinmux_init();
+
 	r8a7790_add_standard_devices();
 }
 
-- 
1.8.1.5

