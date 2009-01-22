From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 22 Jan 2009 00:33:21 +0000
Subject: [PATCH 1/2] ap325 control camera power
Message-Id: <ufxjckvqa.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Signed-off-by: Magnus Damm <damm@igel.co.jp>
---
 arch/sh/boards/board-ap325rxa.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index caf4c33..72da416 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -216,6 +216,12 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static void camera_power(int val)
+{
+	gpio_set_value(GPIO_PTZ5, val); /* RST_CAM/RSTB */
+	mdelay(10);
+}
+
 #ifdef CONFIG_I2C
 static unsigned char camera_ncm03j_magic[]  {
@@ -245,9 +251,11 @@ static int camera_set_capture(struct soc_camera_platform_info *info,
 	int ret = 0;
 	int i;
 
+	camera_power(0);
 	if (!enable)
 		return 0; /* no disable for now */
 
+	camera_power(1);
 	for (i = 0; i < ARRAY_SIZE(camera_ncm03j_magic); i += 2) {
 		u_int8_t buf[8];
 
@@ -426,7 +434,7 @@ static int __init ap325rxa_devices_setup(void)
 	gpio_request(GPIO_PTZ6, NULL);
 	gpio_direction_output(GPIO_PTZ6, 0); /* STBY_CAM */
 	gpio_request(GPIO_PTZ5, NULL);
-	gpio_direction_output(GPIO_PTZ5, 1); /* RST_CAM */
+	gpio_direction_output(GPIO_PTZ5, 0); /* RST_CAM */
 	gpio_request(GPIO_PTZ4, NULL);
 	gpio_direction_output(GPIO_PTZ4, 0); /* SADDR */
 
-- 
1.5.6.3

