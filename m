From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 13 Jun 2014 09:37:22 +0000
Subject: [PATCH v3 8/8] ARM: shmobile: henninger: Enable PCIe Controller & PCIe bus clock
Message-Id: <1402652242-16604-9-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v3:
 - Add PCIe to the Henninger board

 arch/arm/boot/dts/r8a7791-henninger.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index cc6d992..86a48bc 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -217,3 +217,11 @@
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
2.0.0

