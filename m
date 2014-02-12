From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 12 Feb 2014 17:59:23 +0000
Subject: [PATCH 4/5] ARM: shmobile: r8a7790: Add DMA for MMCIF1
Message-Id: <1392227964-7088-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Updated dtsi file with DMA info for MMCIF1

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ae65270..e45e795 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -340,6 +340,8 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+		dmas = <&dma0 0xe2>, <&dma0 0xe1>;
+		dma-names = "rx", "tx";
 		reg-io-width = <4>;
 		status = "disabled";
 	};
-- 
1.8.5.3

