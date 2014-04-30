From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 30 Apr 2014 22:21:08 +0000
Subject: [PATCH 4/6] i2c: sh_mobile: add devicetree documentation
Message-Id: <1398896470-24663-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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

