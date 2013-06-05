From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:24:53 +0000
Subject: [PATCH 002/130] gpio-rcar: Make the platform data gpio_base field signed
Message-Id: <1370420821-28420-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The gpio_base field is used to specify the desired GPIO base for the
GPIO controller. The GPIO core can automatically allocate a GPIO number
range when the base is set to -1. To make this possible, make the field
signed.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/platform_data/gpio-rcar.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_data/gpio-rcar.h b/include/linux/platform_data/gpio-rcar.h
index b253f77..aba7079 100644
--- a/include/linux/platform_data/gpio-rcar.h
+++ b/include/linux/platform_data/gpio-rcar.h
@@ -17,7 +17,7 @@
 #define __GPIO_RCAR_H__
 
 struct gpio_rcar_config {
-	unsigned int gpio_base;
+	int gpio_base;
 	unsigned int irq_base;
 	unsigned int number_of_pins;
 	const char *pctl_name;
-- 
1.8.2.1

