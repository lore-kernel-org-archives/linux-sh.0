From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:30:50 +0000
Subject: [PATCH 16/69] ARM: shmobile: r8a7779: add SDHI support on DTSI
Message-Id: <c4866e70a92d8d5fd8ea7ad2c64ddf0efa7a0700.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
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
1.8.4

