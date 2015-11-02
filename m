From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 02 Nov 2015 17:31:39 +0000
Subject: [PATCH 3/3] arm64: dts: r8a7795: enable PCIe on Salvator-X
Message-Id: <1446485499-26733-4-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 86b70ce..d45218d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -216,3 +216,15 @@
 		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
+
+&pcie_bus_clk {
+	status = "okay";
+};
+
+&pciec0 {
+	status = "okay";
+};
+
+&pciec1 {
+	status = "okay";
+};
-- 
1.9.1

