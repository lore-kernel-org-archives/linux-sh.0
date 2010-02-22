From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 22 Feb 2010 09:20:39 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: ap4evb: Add LED support
Message-Id: <u8wal629z.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 41bc248..4714cad 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -197,6 +197,20 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
+	/* enable LED 1 - 4 */
+	gpio_request(GPIO_PORT185, NULL);
+	gpio_request(GPIO_PORT186, NULL);
+	gpio_request(GPIO_PORT187, NULL);
+	gpio_request(GPIO_PORT188, NULL);
+	gpio_direction_output(GPIO_PORT185, 1);
+	gpio_direction_output(GPIO_PORT186, 1);
+	gpio_direction_output(GPIO_PORT187, 1);
+	gpio_direction_output(GPIO_PORT188, 1);
+	gpio_export(GPIO_PORT185, 0);
+	gpio_export(GPIO_PORT186, 0);
+	gpio_export(GPIO_PORT187, 0);
+	gpio_export(GPIO_PORT188, 0);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.3.3

