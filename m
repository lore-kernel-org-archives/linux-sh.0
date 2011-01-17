From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 17 Jan 2011 08:02:53 +0000
Subject: [PATCH] sh: fix MSIOF0 SPI on ecovec: it conflicts with VOU
Message-Id: <Pine.LNX.4.64.1101170901520.11874@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

MSIOF0 and VOU share pins on sh7724, make MSIOF0 available again, as long as
VOU is not configured.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Should be good for 2.6.37

 arch/sh/boards/mach-ecovec24/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 33b6629..701667a 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1294,6 +1294,7 @@ static int __init arch_setup(void)
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
 
+#if defined(CONFIG_VIDEO_SH_VOU) || defined(CONFIG_VIDEO_SH_VOU_MODULE)
 	/* VOU */
 	gpio_request(GPIO_FN_DV_D15, NULL);
 	gpio_request(GPIO_FN_DV_D14, NULL);
@@ -1325,6 +1326,7 @@ static int __init arch_setup(void)
 
 	/* Remove reset */
 	gpio_set_value(GPIO_PTG4, 1);
+#endif
 
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
-- 
1.7.2.3

