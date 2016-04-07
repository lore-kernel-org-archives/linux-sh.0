From: Rich Felker <dalias@libc.org>
Date: Thu, 07 Apr 2016 15:01:53 +0000
Subject: [PATCH 7/7] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <3784a31c12dc9c23c5c497786f503e1acafe64dd.1461880061.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/boot/dts/j2_mimas_v2.dts | 98 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts

diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
new file mode 100755
index 0000000..0d509f9
--- /dev/null
+++ b/arch/sh/boot/dts/j2_mimas_v2.dts
@@ -0,0 +1,98 @@
+/dts-v1/;
+
+/ {
+	compatible = "jcore,j2-soc";
+	model = "J2 FPGA SoC on Mimas v2 board";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	interrupt-parent = <&aic>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			compatible = "jcore,j2";
+			reg = < 0 >;
+			clock-frequency = < 50000000 >;
+		};
+	};
+
+	memory@10000000 {
+		device_type = "memory";
+		reg = < 0x10000000 0x4000000 >;
+	};
+
+	chosen {
+		stdout-path = "/soc@abcd0000/serial@100";
+	};
+
+	soc@abcd0000 {
+		compatible = "simple-bus";
+		ranges = <0 0xabcd0000 0x100000>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		aic: interrupt-controller {
+			compatible = "jcore,aic1";
+			reg = < 0x200 0x10 >;
+			cpu-offset = < 0x300 >;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		cache-controller {
+			compatible = "jcore,cache";
+			reg = < 0xc0 4 >;
+			cpu-offset = < 4 >;
+		};
+
+		timer {
+			compatible = "jcore,pit";
+			reg = < 0x200 0x30 >;
+			cpu-offset = < 0x300 >;
+			interrupts = < 0x48 >;
+		};
+
+		ethernet {
+			compatible = "jcore,emac";
+			reg = < 0x10000 0x2000 >;
+			//interrupts = < 0x60 >;
+			interrupts = < 0x11 >;
+		};
+
+		spi {
+			compatible = "jcore,spi2";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			spi-max-frequency = <12500000>;
+
+			reg = < 0x40 0x8 >;
+
+			sdcard@1 {
+				compatible = "mmc-spi-slot";
+				reg = <0>;
+				spi-max-frequency = <12500000>;
+				voltage-ranges = <3200 3400>;
+				mode = <0>;
+			};
+		};
+
+		serial@100 {
+			clock-frequency = <125000000>;
+			compatible = "jcore,uartlite", "xlnx,xps-uartlite-1.00.a";
+			current-speed = <115200>;
+			device_type = "serial";
+			//interrupts = < 0x5d >;
+			interrupts = < 0x12 >;
+			port-number = <0>;
+			reg = < 0x100 0x10 >;
+		};
+	};
+};
-- 
2.8.1

