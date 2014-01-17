From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 17 Jan 2014 18:11:36 +0000
Subject: [PATCH 2/4] ARM: lager: add i2c1, i2c2 pins
Message-Id: <1389982298-23143-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add pinctrl definitions for i2c1 and i2c2 busses on the Lager board
to ensure these are setup correctly at initialisation time. The i2c0
and i2c3 busses are connected to single function pins.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index b66d3de..d680ab7 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -80,6 +80,16 @@
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
 	};
+
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
+	};
+
+	i2c2_pins: i2c2 {
+		renesas,groups = "i2c2";
+		renesas,function = "i2c2";
+	};
 };
 
 &mmcif1 {
@@ -98,10 +108,14 @@
 
 &i2c1	{
 	status = "ok";
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c2	{
 	status = "ok";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
 };
 
 &i2c3	{
-- 
1.8.5.2

