From: Lucas Stach <l.stach@pengutronix.de>
Date: Fri, 28 Feb 2014 17:28:40 +0000
Subject: [PATCH 4/7] ARM: dts: exynos5440: fix PCIe interrupt mapping
Message-Id: <1393608523-17509-5-git-send-email-l.stach@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
In-Reply-To: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

So it actually works.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/exynos5440.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 02a0a1226cef..65d425d9ec27 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -274,7 +274,7 @@
 			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0x0 0 &gic 53>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <4>;
 		status = "disabled";
 	};
@@ -295,7 +295,7 @@
 			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0x0 0 &gic 56>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		num-lanes = <4>;
 		status = "disabled";
 	};
-- 
1.8.5.3

