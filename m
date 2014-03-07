From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 07 Mar 2014 13:01:36 +0000
Subject: [PATCH 2/5] ARM: lager: add vin1 node
Message-Id: <1394197299-17528-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Add device-tree for vin1 (composite video in) on the
lager board.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a087421..7528cfc 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -158,6 +158,11 @@
 		renesas,groups = "i2c2";
 		renesas,function = "i2c2";
 	};
+
+	vin1_pins: vin {
+		renesas,groups = "vin1_data8", "vin1_clk";
+		renesas,function = "vin1";
+	};
 };
 
 &mmcif1 {
@@ -239,8 +244,41 @@
 	status = "ok";
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";
+
+	adv7180: adv7180@0x20 {
+		compatible = "adi,adv7180";
+		reg = <0x20>;
+		remote = <&vin1>;
+
+		port {
+			adv7180_1: endpoint {
+				bus-width = <8>;
+				remote-endpoint = <&vin1ep0>;
+			};
+		};
+	};
+
 };
 
 &i2c3	{
 	status = "ok";
 };
+
+/* composite video input */
+&vin1 {
+	pinctrl-0 = <&vin1_pins>;
+	pinctrl-names = "default";
+
+	status = "ok";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		vin1ep0: endpoint {
+			remote-endpoint = <&adv7180_1>;
+			bus-width = <8>;
+		};
+	};
+};
+
-- 
1.9.0

