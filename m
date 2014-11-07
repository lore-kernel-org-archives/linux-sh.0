From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 10:11:43 +0000
Subject: [PATCH 4/5] ARM: shmobile: r8a7790: add DMA nodes for IIC
Message-Id: <1415355104-2031-5-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
2.1.1

