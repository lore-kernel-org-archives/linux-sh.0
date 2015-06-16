From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 16 Jun 2015 12:36:48 +0000
Subject: [PATCH] [RFC] gpio: Retry deferred GPIO hogging on pin range change
Message-Id: <1434458208-30600-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Benoit Parrot <bparrot@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If a GPIO driver uses gpiochip_add_pin_range() (which is usually the
case for GPIO/PFC combos), the GPIO hogging mechanism configured from DT
doesn't work:

    requesting hog GPIO lcd0 (chip r8a7740_pfc, offset 176) failed

The actual error code is -517 = -EPROBE_DEFER.

The problem is that PFC+GPIO registration is handled in multiple steps:
  1. pinctrl_register(),
  2. gpiochip_add(),
  3. gpiochip_add_pin_range().

Configuration of the hogs is handled in gpiochip_add():

    gpiochip_add
        of_gpiochip_add
            of_gpiochip_scan_hogs
                gpiod_hog
                    gpiochip_request_own_desc
                        __gpiod_request
                            chip->request
                                pinctrl_request_gpio
                                    pinctrl_get_device_gpio_range

However, at this point the GPIO controller hasn't been added to
pinctrldev_list yet, so the range can't be found, and the operation fails
with -EPROBE_DEFER.

  - Exchanging the order of the calls to gpiochip_add() and
    gpiochip_add_pin_range() is not an option, as the latter depends on
    initialization done by the former.
  - Just moving the call of of_gpiochip_scan_hogs() from gpiochip_add()
    to gpiochip_add_pin_range() is also not an option, as the latter is
    optional, and thus not used by all drivers.

Hence if of_gpiochip_scan_hogs() fails with -EPROBE_DEFER, call it
again every time the pin range is changed, until it succeeded.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Questions:
  - Is there a better solution to handle this?

  - Should the pin ranges be configured by passing an array of data to
    gpiochip_add() instead of having calls to gpiochip_add_pin_range()?
    That would require changing all drivers.

  - What happens if you have multiple hogs in multiple ranges?
    The first hog(s) may be configured multiple times.  Is that a problem?

  - In one of the threads that discussed the GPIO hogging mechanism, Maxime
    Ripard said: "Our pinctrl driver is also our GPIO driver, so they both
    share the same node."
    Maxime: Did you try GPIO hogging? Did it work?
    If yes, which driver are you using? What's different compared to sh-pfc?
    If no, did you get it to work?

Thanks!
---
 drivers/gpio/gpiolib-of.c   | 21 +++++++++++++++++----
 drivers/gpio/gpiolib.c      |  1 +
 include/linux/gpio/driver.h |  1 +
 include/linux/of_gpio.h     |  2 ++
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 9a0ec48a47375d18..90dd02b19f75c27c 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -205,13 +205,14 @@ static struct gpio_desc *of_get_gpio_hog(struct device_node *np,
  * This is only used by of_gpiochip_add to request/set GPIO initial
  * configuration.
  */
-static void of_gpiochip_scan_hogs(struct gpio_chip *chip)
+static int of_gpiochip_scan_hogs(struct gpio_chip *chip)
 {
 	struct gpio_desc *desc = NULL;
 	struct device_node *np;
 	const char *name;
 	enum gpio_lookup_flags lflags;
 	enum gpiod_flags dflags;
+	int error;
 
 	for_each_child_of_node(chip->of_node, np) {
 		if (!of_property_read_bool(np, "gpio-hog"))
@@ -221,9 +222,12 @@ static void of_gpiochip_scan_hogs(struct gpio_chip *chip)
 		if (IS_ERR(desc))
 			continue;
 
-		if (gpiod_hog(desc, name, lflags, dflags))
-			continue;
+		error = gpiod_hog(desc, name, lflags, dflags);
+		if (error = -EPROBE_DEFER)
+			return error;
 	}
+
+	return 0;
 }
 
 /**
@@ -416,8 +420,17 @@ static void of_gpiochip_add_pin_range(struct gpio_chip *chip)
 	}
 }
 
+void of_gpiochip_pin_range_changed(struct gpio_chip *chip)
+{
+	if (chip->hog_error) {
+		/* Retry */
+		chip->hog_error = of_gpiochip_scan_hogs(chip);
+	}
+}
+
 #else
 static void of_gpiochip_add_pin_range(struct gpio_chip *chip) {}
+void of_gpiochip_pin_range_changed(struct gpio_chip *chip) {}
 #endif
 
 void of_gpiochip_add(struct gpio_chip *chip)
@@ -436,7 +449,7 @@ void of_gpiochip_add(struct gpio_chip *chip)
 	of_gpiochip_add_pin_range(chip);
 	of_node_get(chip->of_node);
 
-	of_gpiochip_scan_hogs(chip);
+	chip->hog_error = of_gpiochip_scan_hogs(chip);
 }
 
 void of_gpiochip_remove(struct gpio_chip *chip)
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 957ede5664cfe168..b0fe7a459d8835bb 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -759,6 +759,7 @@ int gpiochip_add_pin_range(struct gpio_chip *chip, const char *pinctl_name,
 
 	list_add_tail(&pin_range->node, &chip->pin_ranges);
 
+	of_gpiochip_pin_range_changed(chip);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_add_pin_range);
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c8393cd4d44f2d87..9396b68dced2c5b1 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -146,6 +146,7 @@ struct gpio_chip {
 	 * corresponding pins for gpio usage.
 	 */
 	struct list_head pin_ranges;
+	int hog_error;
 #endif
 };
 
diff --git a/include/linux/of_gpio.h b/include/linux/of_gpio.h
index 69dbe312b11b23f6..34421f17f4712d0b 100644
--- a/include/linux/of_gpio.h
+++ b/include/linux/of_gpio.h
@@ -54,6 +54,7 @@ extern int of_mm_gpiochip_add(struct device_node *np,
 			      struct of_mm_gpio_chip *mm_gc);
 extern void of_mm_gpiochip_remove(struct of_mm_gpio_chip *mm_gc);
 
+extern void of_gpiochip_pin_range_changed(struct gpio_chip *chip);
 extern void of_gpiochip_add(struct gpio_chip *gc);
 extern void of_gpiochip_remove(struct gpio_chip *gc);
 extern int of_gpio_simple_xlate(struct gpio_chip *gc,
@@ -76,6 +77,7 @@ static inline int of_gpio_simple_xlate(struct gpio_chip *gc,
 	return -ENOSYS;
 }
 
+static inline void of_gpiochip_pin_range_changed(struct gpio_chip *chip) { }
 static inline void of_gpiochip_add(struct gpio_chip *gc) { }
 static inline void of_gpiochip_remove(struct gpio_chip *gc) { }
 
-- 
1.9.1

