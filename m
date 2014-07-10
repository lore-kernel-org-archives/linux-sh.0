From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Jul 2014 10:50:56 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: lager: use iic cores instead of i2c
Message-Id: <1404989456-2716-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

On Lager board, i2c and iic cores can be interchanged since they can be
muxed to the same wires. Commit e489c2a9bc82713167d9f721ca764f4b0d37e543
("ARM: shmobile: lager: enable i2c devices") activated the i2c cores,
yet the iic cores should be default since they have the more interesting
features for generic use cases, i.e. SMBUS_QUICK and DMA (yet to be
supported).

Reported-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

This applies on top of renesas-devel-v3.16-rc4-20140709 with "[PATCH v2] ARM:
shmobile: Lager: Correct I2C bus for VDD MPU regulator" applied. Both patches
should go into v3.16 IMO, otherwise the bus numbering change will be visible
for end users (i2c busses are 0-3, iic are 4-7 as mentioned in the hardware
manuals).

 arch/arm/boot/dts/r8a7790-lager.dts | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index ffe0523ff16f..856b4236b674 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -205,14 +205,14 @@
 		renesas,function = "msiof1";
 	};
 
-	i2c1_pins: i2c1 {
-		renesas,groups = "i2c1";
-		renesas,function = "i2c1";
+	iic1_pins: iic1 {
+		renesas,groups = "iic1";
+		renesas,function = "iic1";
 	};
 
-	i2c2_pins: i2c2 {
-		renesas,groups = "i2c2";
-		renesas,function = "i2c2";
+	iic2_pins: iic2 {
+		renesas,groups = "iic2";
+		renesas,function = "iic2";
 	};
 
 	iic3_pins: iic3 {
@@ -352,19 +352,19 @@
 	cpu0-supply = <&vdd_dvfs>;
 };
 
-&i2c0	{
+&iic0	{
 	status = "ok";
 };
 
-&i2c1	{
+&iic1	{
 	status = "ok";
-	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-0 = <&iic1_pins>;
 	pinctrl-names = "default";
 };
 
-&i2c2	{
+&iic2	{
 	status = "ok";
-	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-0 = <&iic2_pins>;
 	pinctrl-names = "default";
 };
 
-- 
2.0.0

