From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:02:14 +0000
Subject: [PATCH v2 15/77] ARM: shmobile: sh73a0: Register PFC platform device
Message-Id: <1353974596-30033-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/pfc-sh73a0.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh73a0.c b/arch/arm/mach-shmobile/pfc-sh73a0.c
index b442f9d..c83c582 100644
--- a/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ b/arch/arm/mach-shmobile/pfc-sh73a0.c
@@ -20,6 +20,7 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
 #include <linux/sh_pfc.h>
 #include <mach/sh73a0.h>
 #include <mach/irqs.h>
@@ -2797,7 +2798,15 @@ static struct pinmux_info sh73a0_pinmux_info = {
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
+static struct platform_device sh73a0_pfc_device = {
+	.name		= "sh-pfc",
+	.id		= -1,
+	.dev = {
+		.platform_data = &sh73a0_pinmux_info,
+	},
+};
+
 void sh73a0_pinmux_init(void)
 {
-	register_pinmux(&sh73a0_pinmux_info);
+	platform_device_register(&sh73a0_pfc_device);
 }
-- 
1.7.8.6

