From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:19:54 +0000
Subject: [PATCH 01/16] gpio: rcar: use postcore_init()
Message-Id: <87iovvz3nd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87k3gbz3pe.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k3gbz3pe.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Renesas GPIO is being interlocked with PFC, and GPIO is
very basic system for R-Car.
GPIO should be initialised in same timing as PFC.
The GPIO based system doesn't work correctly without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/gpio/gpio-rcar.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 6038966..0a10325 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -454,7 +454,17 @@ static struct platform_driver gpio_rcar_device_driver = {
 	}
 };
 
-module_platform_driver(gpio_rcar_device_driver);
+static int __init gpio_rcar_init(void)
+{
+	return platform_driver_register(&gpio_rcar_device_driver);
+}
+postcore_initcall(gpio_rcar_init);
+
+static void __exit gpio_rcar_exit(void)
+{
+	platform_driver_unregister(&gpio_rcar_device_driver);
+}
+module_exit(gpio_rcar_exit);
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("Renesas R-Car GPIO Driver");
-- 
1.7.9.5

