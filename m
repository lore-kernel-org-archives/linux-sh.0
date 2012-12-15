From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 15 Dec 2012 22:50:59 +0000
Subject: [PATCH v3 25/81] ARM: shmobile: sh7372: Register PFC platform device
Message-Id: <1355611915-25060-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/pfc-sh7372.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7372.c b/arch/arm/mach-shmobile/pfc-sh7372.c
index 7a1525f..dd5e145 100644
--- a/arch/arm/mach-shmobile/pfc-sh7372.c
+++ b/arch/arm/mach-shmobile/pfc-sh7372.c
@@ -22,6 +22,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
 #include <mach/irqs.h>
 #include <mach/sh7372.h>
@@ -1657,7 +1658,15 @@ static struct pinmux_info sh7372_pinmux_info = {
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
+static struct platform_device sh7372_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+	.dev = {
+		.platform_data = &sh7372_pinmux_info,
+	},
+};
+
 void sh7372_pinmux_init(void)
 {
-	register_pinmux(&sh7372_pinmux_info);
+	platform_device_register(&sh7372_pfc_device);
 }
-- 
1.7.8.6

