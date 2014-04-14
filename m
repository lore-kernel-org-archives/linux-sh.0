From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 18:33:12 +0000
Subject: [PATCH v2 1/6] gpio: rcar: Add optional functional clock to bindings
Message-Id: <1397500397-12607-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1397500397-12607-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
v2:
  - Functional clock is mandatory depending on hardware (thanks, Laurent)
---
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index f61cef74a212..941a26aa4322 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -21,6 +21,12 @@ Required Properties:
     GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
   - gpio-ranges: Range of pins managed by the GPIO controller.
 
+Optional properties:
+
+  - clocks: Must contain a reference to the functional clock.  The property is
+    mandatory if the hardware implements a controllable functional clock for
+    the GPIO instance.
+
 Please refer to gpio.txt in this directory for details of gpio-ranges property
 and the common GPIO bindings used by client devices.
 
-- 
1.7.9.5

