From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 29 Nov 2013 20:14:57 +0000
Subject: [PATCH] gpio: rcar: Add r8a7791 support to the DT bindings
Message-Id: <1385756097-6627-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

The r8a7791 (R-Car M2) has a GPIO controller with additional features
compared to the generic renesas,gpio-rcar compatible devices. Add a
model-specific string to let the driver enable these features.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 8655df9..f61cef7 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -2,10 +2,11 @@
 
 Required Properties:
 
-  - compatible: should be one of the following.
+  - compatible: should contain one of the following.
     - "renesas,gpio-r8a7778": for R8A7778 (R-Mobile M1) compatible GPIO controller.
     - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
     - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
+    - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2) compatible GPIO controller.
     - "renesas,gpio-rcar": for generic R-Car GPIO controller.
 
   - reg: Base address and length of each memory resource used by the GPIO
-- 
1.8.3.2

