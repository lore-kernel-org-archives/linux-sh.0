From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Dec 2013 01:28:41 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7740: add FSI support via DTSI
Message-Id: <87y541z9o9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7740.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index b1c2ed9..52255bf 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -208,4 +208,13 @@
 		cap-sdio-irq;
 		status = "disabled";
 	};
+
+	sh_fsi2: sound@fe1f0000 {
+		#sound-dai-cells = <1>;
+		compatible = "renesas,sh_fsi2";
+		reg = <0xfe1f0000 0x400>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 9 0x4>;
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

