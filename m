From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:28:37 +0000
Subject: [PATCH 28/29] ARM: shmobile: henninger: Enable PCIe Controller & PCIe bus clock
Message-Id: <485f3ce67c11ce086c322b2622db01d7e7c59a84.1403487225.git.horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/r8a7791-henninger.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index c0c58ce..bc48bcc 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -230,3 +230,11 @@
 		spi-cpha;
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
2.0.0.rc2

