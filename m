From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Nov 2014 00:54:31 +0000
Subject: [PATCH 05/29] ARM: shmobile: r8a7791: Add Audio DMAC peri peri devices to DT
Message-Id: <40c6d9f0e7745012c9e19c955e22d4809104359c.1416476366.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Instantiate the Audio DMAC peri peri controllers
in the r8a7791 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b54af74..379e1a5 100644
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
2.1.1

