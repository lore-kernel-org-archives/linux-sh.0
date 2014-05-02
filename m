From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 02 May 2014 19:15:10 +0000
Subject: [PATCH v2 04/10] i2c: sh_mobile: add devicetree documentation
Message-Id: <1399058116-7721-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1399058116-7721-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, devicetree@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/i2c/i2c-sh_mobile.txt      | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
new file mode 100644
index 000000000000..d2153ce36fa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
@@ -0,0 +1,26 @@
+Device tree configuration for Renesas IIC (sh_mobile) driver
+
+Required properties:
+- compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as fallback
+- reg             : address start and address range size of device
+- interrupts      : interrupt of device
+- clocks          : clock for device
+- #address-cells  : should be <1>
+- #size-cells     : should be <0>
+
+Optional properties:
+- clock-frequency : frequency of bus clock in Hz. Default 100kHz if unset.
+
+Pinctrl properties might be needed, too. See there.
+
+Example:
+
+	iic0: i2c@e6500000 {
+		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x425>;
+		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		clock-frequency = <400000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
1.9.2

