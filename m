From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:03:10 +0000
Subject: [PATCH v2 71/77] sh-pfc: Add OF support
Message-Id: <1353974596-30033-72-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1353974596-30033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Phil Edworthy <phil.edworthy@renesas.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, devicetree-discuss@lists.ozlabs.org

Support device instantiation through the device tree. The compatible
property is used to select the SoC pinmux information.

Set the gpio_chip device field to the PFC device to enable automatic
GPIO OF support.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: devicetree-discuss@lists.ozlabs.org
---
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   43 ++++++++++++++
 drivers/pinctrl/sh-pfc/core.c                      |   62 +++++++++++++++++++-
 drivers/pinctrl/sh-pfc/gpio.c                      |    1 +
 3 files changed, 104 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt

Only GPIO DT bindings are currently implemented, pinmux bindings are still
work in progress and will be posted soon.

On the GPIO side, some DT bindings require aliases for the GPIO (and pinctrl)
nodes. What's the reason behind that ?

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
new file mode 100644
index 0000000..f08d8c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -0,0 +1,43 @@
+* Renesas GPIO and Pin Mux/Config controller
+
+Required Properties:
+- compatible: should be one of the following.
+  - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
+  - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
+  - "renesas,pfc-sh7372": for SH7372 (SH-Mobile AP4) compatible pin-controller.
+  - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
+
+- reg: Base address and length of each memory resource used by the pin
+  controller hardware module.
+
+- gpio-controller: Marks the device node as a gpio controller.
+
+- #gpio-cells: Should be 2. The first cell is the pin number and the second cell
+  is used to specify optional parameters (currently unused).
+
+  The syntax of the gpio specifier used by client nodes should be the following
+  with values derived from the SoC user manual.
+
+  <[phandle of the gpio controller node]
+   [pin number within the gpio controller]
+   [flags and pull up/down]>
+
+
+Example 1: SH73A0 (SH-Mobile AG5) pin controller node
+
+	gpio: pfc@e6050000 {
+		compatible = "renesas,pfc-sh73a0";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+Example 2: A GPIO LED node that references a GPIO
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&gpio 20 1>; /* Active low */
+		};
+	};
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 062308f..9cbe684 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
@@ -498,8 +499,55 @@ int sh_pfc_config_gpio(struct sh_pfc *pfc, unsigned gpio, int pinmux_type,
 	return -1;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id sh_pfc_of_table[] = {
+#ifdef CONFIG_PINCTRL_PFC_R8A7740
+	{
+		.compatible = "renesas,pfc-r8a7740",
+		.data = &r8a7740_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7779
+	{
+		.compatible = "renesas,pfc-r8a7779",
+		.data = &r8a7779_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7367
+	{
+		.compatible = "renesas,pfc-sh7367",
+		.data = &sh7367_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7372
+	{
+		.compatible = "renesas,pfc-sh7372",
+		.data = &sh7372_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH7377
+	{
+		.compatible = "renesas,pfc-sh7377",
+		.data = &sh7377_pinmux_info,
+	},
+#endif
+#ifdef CONFIG_PINCTRL_PFC_SH73A0
+	{
+		.compatible = "renesas,pfc-sh73a0",
+		.data = &sh73a0_pinmux_info,
+	},
+#endif
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sh_pfc_of_table);
+#endif
+
 static int sh_pfc_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *platid = platform_get_device_id(pdev);
+#ifdef CONFIG_OF
+	struct device_node *np = pdev->dev.of_node;
+#endif
 	struct sh_pfc_soc_info *info;
 	struct sh_pfc *pfc;
 	int ret;
@@ -509,8 +557,15 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	 */
 	BUILD_BUG_ON(PINMUX_FLAG_TYPE > ((1 << PINMUX_FLAG_DBIT_SHIFT) - 1));
 
-	info = pdev->id_entry->driver_data
-	      ? (void *)pdev->id_entry->driver_data : pdev->dev.platform_data;
+	if (platid)
+		info = (void *)platid->driver_data;
+#ifdef CONFIG_OF
+	else if (np)
+		info = (void *)of_match_device(sh_pfc_of_table, &pdev->dev)->data;
+#endif
+	else
+		info = pdev->dev.platform_data;
+
 	if (info = NULL)
 		return -ENODEV;
 
@@ -640,6 +695,9 @@ static struct platform_driver sh_pfc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_OF
+		.of_match_table = sh_pfc_of_table,
+#endif
 	},
 };
 
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 22df3fe..1431c5e 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -132,6 +132,7 @@ static void sh_pfc_gpio_setup(struct sh_pfc_chip *chip)
 	WARN_ON(pfc->info->first_gpio != 0); /* needs testing */
 
 	gc->label = pfc->info->name;
+	gc->dev = pfc->dev;
 	gc->owner = THIS_MODULE;
 	gc->base = pfc->info->first_gpio;
 	gc->ngpio = (pfc->info->last_gpio - pfc->info->first_gpio) + 1;
-- 
1.7.8.6

