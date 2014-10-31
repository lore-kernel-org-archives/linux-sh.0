From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 00:25:17 +0000
Subject: [PATCH 02/12 v2] ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
Message-Id: <87tx2l2ihf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Instantiate the Audio DMAC peri peri controllers
in the r8a7790 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -v2

 - removed "0x" prefix

 arch/arm/boot/dts/r8a7790.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4246106..6fc6ca7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -369,6 +369,13 @@
 		dma-channels = <13>;
 	};
 
+	audmapp: audio-dma-pp@ec740000 {
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

