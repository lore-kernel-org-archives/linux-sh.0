From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 25 Jul 2014 14:40:46 +0000
Subject: [PATCH 2/6] gpio: rcar: Add r8a7794 support
Message-Id: <1406299250-23975-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406299250-23975-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1406299250-23975-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-gpio@vger.kernel.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: added bindings documentation]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-gpio@vger.kernel.org
---
 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
 drivers/gpio/gpio-rcar.c                                     | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 941a26a..a58b31b 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -7,6 +7,7 @@ Required Properties:
     - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
     - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
     - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2) compatible GPIO controller.
+    - "renesas,gpio-r8a7794": for R8A7794 (R-Car E2) compatible GPIO controller.
     - "renesas,gpio-rcar": for generic R-Car GPIO controller.
 
   - reg: Base address and length of each memory resource used by the GPIO
diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 0c9f803..d0a2316 100644
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
@@ -302,6 +303,11 @@ static const struct of_device_id gpio_rcar_of_table[] = {
 			.has_both_edge_trigger = true,
 		},
 	}, {
+		.compatible = "renesas,gpio-r8a7794",
+		.data = (void *)&(const struct gpio_rcar_info) {
+			.has_both_edge_trigger = true,
+		},
+	}, {
 		.compatible = "renesas,gpio-rcar",
 		.data = (void *)&(const struct gpio_rcar_info) {
 			.has_both_edge_trigger = false,
-- 
1.8.4.5

