From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 00:34:17 +0000
Subject: [PATCH 6/7] ARM: shmobile: porter: enable PCIe
Message-Id: <f9953c5e2a84ffc309ca5f6a281528907a3c8a39.1444868963.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444868963.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444868963.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable the PCIe controller and clock for the Porter board.

This patch is analogous to the commit 485f3ce67c11 ("ARM: shmobile:
henninger: Enable PCIe Controller & PCIe bus clock") as there are no
differences between the boards in this respect.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 4eebc67773d2..c46aad3954f4 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
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
-- 
2.1.4

