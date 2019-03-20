From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Mar 2019 10:21:33 +0000
Subject: [PATCH v3 02/10] pinctrl: sh-pfc: Introduce PINCTRL_SH_FUNC_GPIO helper symbol
Message-Id: <20190320102141.19316-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190320102141.19316-1-geert+renesas@glider.be>
In-Reply-To: <20190320102141.19316-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Pinctrl drivers for SuperH platforms use legacy function GPIOs.
Currently this support is compiled in based on the SUPERH platform
dependency, which hinders the introduction of compile-testing support
for the affected pinctrl drivers.

Introduce a new Kconfig symbol PINCTRL_SH_FUNC_GPIO, which is
auto-selected when needed.  This symbol in turn selects
PINCTRL_SH_PFC_GPIO, to reduce the number of per-driver selects.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - New.
---
 drivers/pinctrl/sh-pfc/Kconfig  | 30 ++++++++++++++++++------------
 drivers/pinctrl/sh-pfc/gpio.c   |  8 ++++----
 drivers/pinctrl/sh-pfc/sh_pfc.h |  2 +-
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index e941ba60d4b7c775..6a9e4334dbfa7ec0 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -20,6 +20,12 @@ config PINCTRL_SH_PFC_GPIO
 	help
 	  This enables pin control and GPIO drivers for SH/SH Mobile platforms
 
+config PINCTRL_SH_FUNC_GPIO
+	select PINCTRL_SH_PFC_GPIO
+	bool
+	help
+	  This enables legacy function GPIOs for SH platforms
+
 config PINCTRL_PFC_EMEV2
 	def_bool y
 	depends on ARCH_EMEV2
@@ -138,17 +144,17 @@ config PINCTRL_PFC_R8A77995
 config PINCTRL_PFC_SH7203
 	def_bool y
 	depends on CPU_SUBTYPE_SH7203
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7264
 	def_bool y
 	depends on CPU_SUBTYPE_SH7264
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7269
 	def_bool y
 	depends on CPU_SUBTYPE_SH7269
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH73A0
 	def_bool y
@@ -159,45 +165,45 @@ config PINCTRL_PFC_SH73A0
 config PINCTRL_PFC_SH7720
 	def_bool y
 	depends on CPU_SUBTYPE_SH7720
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7722
 	def_bool y
 	depends on CPU_SUBTYPE_SH7722
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7723
 	def_bool y
 	depends on CPU_SUBTYPE_SH7723
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7724
 	def_bool y
 	depends on CPU_SUBTYPE_SH7724
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7734
 	def_bool y
 	depends on CPU_SUBTYPE_SH7734
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7757
 	def_bool y
 	depends on CPU_SUBTYPE_SH7757
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7785
 	def_bool y
 	depends on CPU_SUBTYPE_SH7785
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SH7786
 	def_bool y
 	depends on CPU_SUBTYPE_SH7786
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 
 config PINCTRL_PFC_SHX3
 	def_bool y
 	depends on CPU_SUBTYPE_SHX3
-	select PINCTRL_SH_PFC_GPIO
+	select PINCTRL_SH_FUNC_GPIO
 endif
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 4f3a34ee1cd454b8..97c1332c1045739a 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -252,7 +252,7 @@ static int gpio_pin_setup(struct sh_pfc_chip *chip)
  * Function GPIOs
  */
 
-#ifdef CONFIG_SUPERH
+#ifdef CONFIG_PINCTRL_SH_FUNC_GPIO
 static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
 {
 	static bool __print_once;
@@ -292,7 +292,7 @@ static int gpio_function_setup(struct sh_pfc_chip *chip)
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_PINCTRL_SH_FUNC_GPIO */
 
 /* -----------------------------------------------------------------------------
  * Register/unregister
@@ -369,7 +369,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	if (IS_ENABLED(CONFIG_OF) && pfc->dev->of_node)
 		return 0;
 
-#ifdef CONFIG_SUPERH
+#ifdef CONFIG_PINCTRL_SH_FUNC_GPIO
 	/*
 	 * Register the GPIO to pin mappings. As pins with GPIO ports
 	 * must come first in the ranges, skip the pins without GPIO
@@ -397,7 +397,7 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	chip = sh_pfc_add_gpiochip(pfc, gpio_function_setup, NULL);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
-#endif /* CONFIG_SUPERH */
+#endif /* CONFIG_PINCTRL_SH_FUNC_GPIO */
 
 	return 0;
 }
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 56016cb76769c97b..754e325d0bdbb48d 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -261,7 +261,7 @@ struct sh_pfc_soc_info {
 	const struct sh_pfc_function *functions;
 	unsigned int nr_functions;
 
-#ifdef CONFIG_SUPERH
+#ifdef CONFIG_PINCTRL_SH_FUNC_GPIO
 	const struct pinmux_func *func_gpios;
 	unsigned int nr_func_gpios;
 #endif
-- 
2.17.1
