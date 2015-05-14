From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 14 May 2015 01:07:00 +0000
Subject: [PATCH 31/31] ARM: shmobile: r8a7791: Enable DMA for HSUSB
Message-Id: <7706993e2deb75022dbcfc3043890aa1a0020189.1431565427.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1431565427.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1431565427.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch adds DMA properties to the HSUSB node.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 754c3f20f224..7613abea13d7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -723,6 +723,9 @@
 		renesas,buswait = <4>;
 		phys = <&usb0 1>;
 		phy-names = "usb";
+		dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+		       <&usb_dmac1 0>, <&usb_dmac1 1>;
+		dma-names = "ch0", "ch1", "ch2", "ch3";
 		status = "disabled";
 	};
 
-- 
2.1.4

