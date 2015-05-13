From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 13 May 2015 09:27:17 +0000
Subject: [PATCH 1/2] pwm: Add device tree binding document for R-Car PWM Timer
Message-Id: <1431509238-7648-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add binding document for Renesas PWM Timer on R-Car SoCs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/pwm/renesas,pwm-rcar.txt    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
new file mode 100644
index 0000000..38123f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -0,0 +1,21 @@
+* Renesas R-Car PWM Timer Controller
+
+Required Properties:
+- compatible: must contain "renesas,pwm-rcar"
+- reg: base address and length of the registers block for the PWM
+- #pwm-cells: should be 7. See pwm.txt in this directory for a description of
+  the cells format.
+- clocks: clock phandle and specifier pair.
+- pinctrl-0: phandle, referring to a default pin configuration node.
+- pinctrl-names: Set to "default"
+
+Example: R8A7790 (R-Car H2) PWM Timer node
+
+	pwm: pwm@e6e30000 {
+		compatible = "renesas,pwm-rcar";
+		reg = <0 0xe6e30000 0 0x7000>;
+		#pwm-cells = <7>;
+		clocks = <&mstp5_clks R8A7790_CLK_PWM>;
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "default";
+	};
-- 
1.9.1

