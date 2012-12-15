From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:50:57 +0000
Subject: [PATCH v3 23/81] ARM: shmobile: r8a7740: Register PFC platform device
Message-Id: <1355611915-25060-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add arch code to register the PFC platform device instead of calling the
driver directly. Platform device registration in the sh-pfc driver will
be removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/pfc-r8a7740.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-r8a7740.c b/arch/arm/mach-shmobile/pfc-r8a7740.c
index 134d1b9..8a412b1 100644
--- a/arch/arm/mach-shmobile/pfc-r8a7740.c
+++ b/arch/arm/mach-shmobile/pfc-r8a7740.c
@@ -20,6 +20,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
 #include <mach/r8a7740.h>
 #include <mach/irqs.h>
@@ -2611,7 +2612,15 @@ static struct pinmux_info r8a7740_pinmux_info = {
 	.gpio_irq_size	= ARRAY_SIZE(pinmux_irqs),
 };
 
+static struct platform_device r8a7740_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+	.dev = {
+		.platform_data = &r8a7740_pinmux_info,
+	},
+};
+
 void r8a7740_pinmux_init(void)
 {
-	register_pinmux(&r8a7740_pinmux_info);
+	platform_device_register(&r8a7740_pfc_device);
 }
-- 
1.7.8.6

