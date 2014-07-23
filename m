From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 Jul 2014 02:43:36 +0000
Subject: [PATCH 02/11][RFC] ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
Message-Id: <871ttcvlpl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Instantiate the Audio DMAC peri peri controllers
in the r8a7790 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9f4fb9c..853a5d1 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -333,6 +333,13 @@
 		dma-channels = <13>;
 	};
 
+	audmapp: audio-dma-pp@0xec740000 {
+		compatible = "renesas,rcar-audmapp";
+		#dma-cells = <1>;
+
+		reg = <0 0xec740000 0 0x200>;
+	};
+
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.9.5

