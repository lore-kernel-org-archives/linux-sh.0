From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:36:22 +0000
Subject: [PATCH 09/10] ARM: shmobile: r8a7779: add SDHI support on DTSI
Message-Id: <878uy01fh9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index da61d27..be737ef 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -206,4 +206,44 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 100 0x4>;
 	};
+
+	sdhi0: sdhi@ffe4c000 {
+		compatible = "renesas,sdhi-r8a7779";
+		reg = <0xffe4c000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 104 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi@ffe4d000 {
+		compatible = "renesas,sdhi-r8a7779";
+		reg = <0xffe4d000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 105 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi@ffe4e000 {
+		compatible = "renesas,sdhi-r8a7779";
+		reg = <0xffe4e000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 107 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi3: sdhi@ffe4f000 {
+		compatible = "renesas,sdhi-r8a7779";
+		reg = <0xffe4f000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 106 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

