From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Apr 2013 06:26:16 +0000
Subject: [PATCH 7/6] DMA: shdma: add DT binding documentation
Message-Id: <Pine.LNX.4.64.1304260823050.30844@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org

SHDMA uses only standard DMA Device Tree bindings. This patch adds
documentation, exactly describing the use of the bindings and providing
examples.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This patch adds the missing documentation to the patch series "DMA: shdma: 
add Device Tree support"
http://thread.gmane.org/gmane.linux.ports.sh.devel/21972
Arnd, Vinod, I hope, now this series can be applied :)

 Documentation/devicetree/bindings/dma/shdma.txt |   61 +++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/shdma.txt

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
new file mode 100644
index 0000000..f99618e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -0,0 +1,61 @@
+* SHDMA Device Tree bindings
+
+Only generic DMA controller bindings are used for SHDMA DT nodes.
+
+* DMA controller
+
+Required properties:
+- compatible:	should be "renesas,shdma"
+- #dma-cells:	should be <1>, see "dmas" property below
+
+Optional properties (currently unused):
+- dma-channels:	number of DMA channels
+- dma-requests:	number of DMA request signals
+
+Example:
+	dma0: shdma@fe000020 {
+		compatible = "renesas,shdma";
+		reg = <0xfe000020 0x89e0>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 129 4
+				0 109 4
+				0 110 4
+				0 111 4
+				0 112 4
+				0 113 4
+				0 114 4
+				0 115 4
+				0 116 4
+				0 117 4
+				0 118 4
+				0 119 4
+				0 120 4
+				0 121 4
+				0 122 4
+				0 123 4
+				0 124 4
+				0 125 4
+				0 126 4
+				0 127 4
+				0 128 4>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14", "ch15",
+				"ch16", "ch17", "ch18", "ch19";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+	};
+
+* DMA client
+
+Required properties:
+- dmas:		a list of <[DMA controller phandle] [MID/RID value]> pairs
+- dma-names:	a list of DMA channel names, one per "dmas" entry
+
+Example:
+	dmas = <&dma0 0xd1
+		&dma0 0xd2>;
+	dma-names = "tx", "rx";
-- 
1.7.2.5

