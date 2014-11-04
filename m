From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Nov 2014 01:46:28 +0000
Subject: [PATCH 04/23 v3] ARM: shmobile: r8a7791: Add Audio DMAC peri peri devices to DT
Message-Id: <87tx2f91qa.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Instantiate the Audio DMAC peri peri controllers
in the r8a7791 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - audio-dma-pp -> dma-controller

 arch/arm/boot/dts/r8a7791.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index c10ce1d..b2b47bd 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -357,6 +357,13 @@
 		dma-channels = <13>;
 	};
 
+	audmapp: dma-controller@ec740000 {
+		compatible = "renesas,rcar-audmapp";
+		#dma-cells = <1>;
+
+		reg = <0 0xec740000 0 0x200>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
-- 
1.7.9.5

