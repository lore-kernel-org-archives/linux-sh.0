From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Fri, 07 Nov 2014 09:23:39 +0000
Subject: [PATCH] gpio: rcar: Add r8a7793 and r8a7794 support
Message-Id: <1415352219-26644-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

The device tree probing for R-Car M2-N (r8a7793) and R-Car E2 (r8a7794)
is added.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on for-next branch of Linus Walleij's gpio tree.

 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt |  4 +++-
 drivers/gpio/gpio-rcar.c                                     | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 941a26a..38fb86f 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -6,7 +6,9 @@ Required Properties:
     - "renesas,gpio-r8a7778": for R8A7778 (R-Mobile M1) compatible GPIO controller.
     - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
     - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
-    - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2) compatible GPIO controller.
+    - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2-W) compatible GPIO controller.
+    - "renesas,gpio-r8a7793": for R8A7793 (R-Car M2-N) compatible GPIO controller.
+    - "renesas,gpio-r8a7794": for R8A7794 (R-Car E2) compatible GPIO controller.
     - "renesas,gpio-rcar": for generic R-Car GPIO controller.
 
   - reg: Base address and length of each memory resource used by the GPIO
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index ef71ca8..947654e 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -1,6 +1,7 @@
 /*
  * Renesas R-Car GPIO Support
  *
+ *  Copyright (C) 2014 Renesas Electronics Corporation
  *  Copyright (C) 2013 Magnus Damm
  *
  * This program is free software; you can redistribute it and/or modify
@@ -327,6 +328,16 @@ static const struct of_device_id gpio_rcar_of_table[] = {
 			.has_both_edge_trigger = true,
 		},
 	}, {
+		.compatible = "renesas,gpio-r8a7793",
+		.data = (void *)&(const struct gpio_rcar_info) {
+			.has_both_edge_trigger = true,
+		},
+	}, {
+		.compatible = "renesas,gpio-r8a7794",
+		.data = (void *)&(const struct gpio_rcar_info) {
+			.has_both_edge_trigger = true,
+		},
+	}, {
 		.compatible = "renesas,gpio-rcar",
 		.data = (void *)&(const struct gpio_rcar_info) {
 			.has_both_edge_trigger = false,
-- 
1.9.1

