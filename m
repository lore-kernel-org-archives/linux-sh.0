From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 22 Jul 2014 21:26:32 +0000
Subject: [PATCH v3 2/3] ARM: shmobile: koelsch: enable USB PHY
Message-Id: <201407230126.33886.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407230122.49264.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407230122.49264.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable USB PHY device for the Koelsch board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- refreshed the patch.

Changes in version 2:
- fixed the wrong board name in the changelog;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++++
 1 file changed, 4 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ renesas/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -452,6 +452,10 @@
 	pinctrl-names = "default";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 &pcie_bus_clk {
 	status = "okay";
 };
