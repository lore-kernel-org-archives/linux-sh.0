From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 16 Jun 2013 23:41:52 +0000
Subject: [PATCH] gpio-rcar: Use OUTDT when reading GPIOs configured as output
Message-Id: <20130616234152.23721.85467.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Testing on r8a7790 shows that INDT does not indicate the correct
pin state when reading a GPIO configured as output, so update
the gpio_rcar_get() function to handle this case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/gpio/gpio-rcar.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- 0001/drivers/gpio/gpio-rcar.c
+++ work/drivers/gpio/gpio-rcar.c	2013-06-12 09:23:53.000000000 +0900
@@ -230,7 +230,14 @@ static int gpio_rcar_direction_input(str
 
 static int gpio_rcar_get(struct gpio_chip *chip, unsigned offset)
 {
-	return (int)(gpio_rcar_read(gpio_to_priv(chip), INDT) & BIT(offset));
+	u32 bit = BIT(offset);
+
+	/* testing on r8a7790 shows that INDT does not show correct pin state
+	 * when configured as output, so use OUTDT in case of output pins */
+	if (gpio_rcar_read(gpio_to_priv(chip), INOUTSEL) & bit)
+		return (int)(gpio_rcar_read(gpio_to_priv(chip), OUTDT) & bit);
+	else
+		return (int)(gpio_rcar_read(gpio_to_priv(chip), INDT) & bit);
 }
 
 static void gpio_rcar_set(struct gpio_chip *chip, unsigned offset, int value)
