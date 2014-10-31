From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 31 Oct 2014 10:51:17 +0000
Subject: [RFC 2/3] ARM: shmobile: r8a7790: add DMA nodes for IIC
Message-Id: <1414752678-26078-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1414752678-26078-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 69b7cd0e7fb3..7e836cc86098 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -359,6 +359,8 @@
 		reg = <0 0xe6500000 0 0x425>;
 		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -369,6 +371,8 @@
 		reg = <0 0xe6510000 0 0x425>;
 		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
+		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -379,6 +383,8 @@
 		reg = <0 0xe6520000 0 0x425>;
 		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
+		dmas = <&dmac0 0x69>, <&dmac0 0x6a>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
@@ -389,6 +395,8 @@
 		reg = <0 0xe60b0000 0 0x425>;
 		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
+		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
+		dma-names = "tx", "rx";
 		status = "disabled";
 	};
 
-- 
2.0.0

