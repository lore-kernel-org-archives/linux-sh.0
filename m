From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 16 Sep 2009 11:34:34 +0000
Subject: [PATCH] sh: mach-ecovec24: Add user debug switch support
Message-Id: <ueiq7azsl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 7da274a..ac89f50 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -638,6 +638,16 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_KEYOUT0,     NULL);
 	gpio_request(GPIO_FN_KEYIN0,      NULL);
 
+	/* enable user debug switch */
+	gpio_request(GPIO_PTR0, NULL);
+	gpio_request(GPIO_PTR4, NULL);
+	gpio_request(GPIO_PTR5, NULL);
+	gpio_request(GPIO_PTR6, NULL);
+	gpio_direction_input(GPIO_PTR0);
+	gpio_direction_input(GPIO_PTR4);
+	gpio_direction_input(GPIO_PTR5);
+	gpio_direction_input(GPIO_PTR6);
+
 	/* enable I2C device */
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
-- 
1.6.0.4

