From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 09 Feb 2015 16:02:41 +0000
Subject: [PATCH v2 13/15] ARM: shmobile: r8a7778 dtsi: Add Bus State Controller node
Message-Id: <1423497763-3450-14-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a node for the Bus State Controller (BSC) on r8a7778, to which
multiple external devices can be connected.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 8700e2e..ecd1426 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -41,6 +41,13 @@
 		spi2 = &hspi2;
 	};
 
+	bsc: bus@1c000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x1c000000>;
+	};
+
 	ether: ethernet@fde00000 {
 		compatible = "renesas,ether-r8a7778";
 		reg = <0xfde00000 0x400>;
-- 
2.2.2

