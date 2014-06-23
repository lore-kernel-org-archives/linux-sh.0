From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:28:36 +0000
Subject: [PATCH 27/29] ARM: shmobile: koelsch: Enable PCIe Controller & PCIe bus clock
Message-Id: <998d7d64e1aeede4e03b6c67adb78fe55a278db7.1403487225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index b0cfbd4..5dac673 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -426,6 +426,14 @@
 	};
 };
 
+&pcie_bus_clk {
+	status = "okay";
+};
+
+&pciec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu0-supply = <&vdd_dvfs>;
 };
-- 
2.0.0.rc2

