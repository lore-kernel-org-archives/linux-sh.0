From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Nov 2014 00:54:30 +0000
Subject: [PATCH 04/29] ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
Message-Id: <e416b66a6c62cd935c6959448aba46ae8fd25625.1416476366.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Instantiate the Audio DMAC peri peri controllers
in the r8a7790 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2e01d49..146f918 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -369,6 +369,13 @@
 		dma-channels = <13>;
 	};
 
+	audmapp: dma-controller@ec740000 {
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
2.1.1

