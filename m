From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 14 Apr 2014 21:35:07 +0000
Subject: [PATCH v2 4/9] ARM: shmobile: r8a7790: Add DMA for MMCIF1
Message-Id: <1397511312-4845-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>

Updated dtsi file with DMA info for MMCIF1

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e85e354..8b66de8 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -316,6 +316,9 @@
 		reg = <0 0xee220000 0 0x80>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
+		dmas =  <&dma0 R8A7790_DMA_MMCIF1_RX CHCR_RX_32BIT>,
+			<&dma0 R8A7790_DMA_MMCIF1_TX CHCR_TX_32BIT>;
+		dma-names = "rx", "tx";
 		reg-io-width = <4>;
 		status = "disabled";
 	};
-- 
1.9.1

