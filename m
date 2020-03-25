From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 25 Mar 2020 10:03:57 +0000
Subject: [PATCH 2/2] gpiolib: Remove unused gpio_chip parameter from gpio_set_bias()
Message-Id: <20200325100357.13705-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200325100357.13705-1-geert+renesas@glider.be>
In-Reply-To: <20200325100357.13705-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ulrich Hecht <uli+renesas@fpond.eu>, Chris Brandt <chris.brandt@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, Geert Uytterhoeven <geert+renesas@glider.be>

gpio_set_bias() no longer uses the passed gpio_chip pointer parameter.
Remove it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpiolib.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8eeb29de12cb5811..7e3c19bd21cdf327 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3264,7 +3264,7 @@ static int gpio_set_config(struct gpio_desc *desc, enum pin_config_param mode)
 	return gpio_do_set_config(chip, gpio_chip_hwgpio(desc), config);
 }
 
-static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
+static int gpio_set_bias(struct gpio_desc *desc)
 {
 	int bias = 0;
 	int ret = 0;
@@ -3330,7 +3330,7 @@ int gpiod_direction_input(struct gpio_desc *desc)
 	}
 	if (ret = 0) {
 		clear_bit(FLAG_IS_OUT, &desc->flags);
-		ret = gpio_set_bias(chip, desc);
+		ret = gpio_set_bias(desc);
 	}
 
 	trace_gpio_direction(desc_to_gpio(desc), 1, ret);
@@ -3414,7 +3414,6 @@ EXPORT_SYMBOL_GPL(gpiod_direction_output_raw);
  */
 int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
-	struct gpio_chip *gc;
 	int ret;
 
 	VALIDATE_DESC(desc);
@@ -3432,7 +3431,6 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 		return -EIO;
 	}
 
-	gc = desc->gdev->chip;
 	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags)) {
 		/* First see if we can enable open drain in hardware */
 		ret = gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_DRAIN);
@@ -3458,7 +3456,7 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 	}
 
 set_output_value:
-	ret = gpio_set_bias(gc, desc);
+	ret = gpio_set_bias(desc);
 	if (ret)
 		return ret;
 	return gpiod_direction_output_raw_commit(desc, value);
-- 
2.17.1
