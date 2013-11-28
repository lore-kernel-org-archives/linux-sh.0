From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 15:44:52 +0000
Subject: [PATCH 1/2] regulator: gpio-regulator: Add required regulator-type property
Message-Id: <1385653493-9952-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The gpio-regulator driver requires the regulator-type property to be
present. Document it as required in the DT bindings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/regulator/gpio-regulator.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
index 63c6598..a560711 100644
--- a/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible		: Must be "regulator-gpio".
 - states		: Selection of available voltages and GPIO configs.
                           if there are no states, then use a fixed regulator
+- regulator-type	: Must be either "voltage" or "current".
 
 Optional properties:
 - enable-gpio		: GPIO to use to enable/disable the regulator.
@@ -22,6 +23,7 @@ Example:
 		regulator-name = "mmci-gpio-supply";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <2600000>;
+		regulator-type = "voltage";
 		regulator-boot-on;
 
 		enable-gpio = <&gpio0 23 0x4>;
-- 
1.8.3.2

