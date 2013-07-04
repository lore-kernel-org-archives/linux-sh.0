From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 04 Jul 2013 17:44:39 +0000
Subject: [PATCH] gpio-rcar: Add interrupt controller support to the DT bindings
Message-Id: <1372959879-24033-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-gpio@vger.kernel.org
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>

Update the DT bindings documentation with the interrupt-controller
and #interrupt-cells properties.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index cb3dc7b..8655df9 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -23,6 +23,10 @@ Required Properties:
 Please refer to gpio.txt in this directory for details of gpio-ranges property
 and the common GPIO bindings used by client devices.
 
+The GPIO controller also acts as an interrupt controller. It uses the default
+two cells specifier as described in Documentation/devicetree/bindings/
+interrupt-controller/interrupts.txt.
+
 Example: R8A7779 (R-Car H1) GPIO controller nodes
 
 	gpio0: gpio@ffc40000 {
@@ -33,6 +37,8 @@ Example: R8A7779 (R-Car H1) GPIO controller nodes
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 	};
 	...
 	gpio6: gpio@ffc46000 {
@@ -43,4 +49,6 @@ Example: R8A7779 (R-Car H1) GPIO controller nodes
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 192 9>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
 	};
-- 
Regards,

Laurent Pinchart

