From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 09 Oct 2015 21:41:26 +0000
Subject: [PATCH] ARM: shmobile: porter: enable PCIe
Message-Id: <13633423.im5T5IW5o3@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable the PCIe controller and clock for the Porter board.

This patch is analogous to the commit 485f3ce67c11 ("ARM: shmobile:
henninger: Enable PCIe Controller & PCIe bus clock") as there are no
differences between the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against 'renesas-devel-20151008-v4.3-rc4' tag  of Simon Horman's
'renesas.git' repo plus the Porter I2C2, VIN0/ADV7180, and QSPI patches posted
earlier.

 arch/arm/boot/dts/r8a7791-porter.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
+++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
@@ -244,3 +244,11 @@
 		};
 	};
 };
+
+&pcie_bus_clk {
+	status = "okay";
+};
+
+&pciec {
+	status = "okay";
+};

