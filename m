From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:35:46 +0000
Subject: [PATCH 06/10] ARM: shmobile: r8a7778: add SDHI support on DTSI
Message-Id: <87d2nc1fi8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778.dtsi |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 0ff38e6..873eeb9 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -164,4 +164,34 @@
 		interrupts = <0 61 4>;
 		status = "disabled";
 	};
+
+	sdhi0: sdhi@ffe4c000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4c000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 87 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi@ffe4d000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4d000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 88 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
+
+	sdhi2: sdhi@ffe4f000 {
+		compatible = "renesas,sdhi-r8a7778";
+		reg = <0xffe4f000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 86 4>;
+		cap-sd-highspeed;
+		cap-sdio-irq;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

