From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 02:53:04 +0000
Subject: [PATCH v2 12/12] sh: add device tree source for J2 FPGA on Mimas v2  board
Message-Id: <9960d6526523727d1bee3d11c6704e09e600c6fe.1463708766.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
In-Reply-To: <cover.1463708766.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>

Signed-off-by: Rich Felker <dalias@libc.org>
---
 arch/sh/boot/dts/j2_mimas_v2.dts | 87 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts

diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
new file mode 100755
index 0000000..f47fb2f
--- /dev/null
+++ b/arch/sh/boot/dts/j2_mimas_v2.dts
@@ -0,0 +1,87 @@
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
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		cache-controller {
+			compatible = "jcore,cache";
+			reg = < 0xc0 4 >;
+		};
+
+		timer {
+			compatible = "jcore,pit";
+			reg = < 0x200 0x30 >;
+			interrupts = < 0x48 >;
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
+			compatible = "xlnx,xps-uartlite-1.00.a";
+			current-speed = <19200>;
+			device_type = "serial";
+			interrupts = < 0x12 >;
+			port-number = <0>;
+			reg = < 0x100 0x10 >;
+		};
+	};
+};
-- 
2.8.1

