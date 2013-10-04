From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 06:44:44 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7779: tidyup I2C driver name on DTSI
Message-Id: <87fvshzg9z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

10e8d4f6dddb0f9dc408c2f2bde8399b243a42ca
(ARM: mach-shmobile: r8a7779: Minimal setup using DT)
added I2C driver, but it was SH-Mobile I2C.
R-Car H1 needs R-Car I2C driver.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 19faeac..da61d27 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -153,7 +153,7 @@
 	i2c0: i2c@ffc70000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc70000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 79 0x4>;
@@ -163,7 +163,7 @@
 	i2c1: i2c@ffc71000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc71000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 82 0x4>;
@@ -173,7 +173,7 @@
 	i2c2: i2c@ffc72000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc72000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 80 0x4>;
@@ -183,7 +183,7 @@
 	i2c3: i2c@ffc73000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "renesas,rmobile-iic";
+		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc73000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
-- 
1.7.9.5

