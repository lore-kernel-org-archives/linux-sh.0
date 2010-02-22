From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 22 Feb 2010 09:30:12 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: ap4evb: Add S6 debug switch support
Message-Id: <u7hq5629w.wl%morimoto.kuninori@renesas.com>
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
index 4714cad..d9a46d0 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -211,6 +211,20 @@ static void __init ap4evb_init(void)
 	gpio_export(GPIO_PORT187, 0);
 	gpio_export(GPIO_PORT188, 0);
 
+	/* enable Debug switch (S6) */
+	gpio_request(GPIO_PORT32, NULL);
+	gpio_request(GPIO_PORT33, NULL);
+	gpio_request(GPIO_PORT34, NULL);
+	gpio_request(GPIO_PORT35, NULL);
+	gpio_direction_input(GPIO_PORT32);
+	gpio_direction_input(GPIO_PORT33);
+	gpio_direction_input(GPIO_PORT34);
+	gpio_direction_input(GPIO_PORT35);
+	gpio_export(GPIO_PORT32, 0);
+	gpio_export(GPIO_PORT33, 0);
+	gpio_export(GPIO_PORT34, 0);
+	gpio_export(GPIO_PORT35, 0);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.3.3

