From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Jul 2013 15:51:32 +0000
Subject: [PATCH/RFC 2/2] ARM: shmobile: kzm9g: support DDR50 mode with 1.8V VccQ on MMCIF
Message-Id: <Pine.LNX.4.64.1307261748260.22137@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>

MMCIF on sh73a0 supports the UHS DDR50 mode and on the kzm9g board it can
be used with MMC VccQ = 1.8V. This patch enables them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

This patch is correct AFAICS, but pointless on kzm9g, because (at least on 
my board) th eMMC chip, installed on the board and connected to MMCIF 
doesn't support DDR, so, it cannot be enabled. This patch is therefore 
more of an example how these flags shall be used, than a real use case. If 
it is decided to apply it, it can be applied even before patch 1/2, it 
just won't have any effect at all.

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    1 +
 arch/arm/boot/dts/sh73a0.dtsi                |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index b99e890..d90de01 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -191,6 +191,7 @@
 
 	bus-width = <8>;
 	vmmc-supply = <&reg_1p8v>;
+	ddr-1v8;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 86e79fe..1146be8 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -186,6 +186,7 @@
 		interrupts = <0 140 0x4
 			      0 141 0x4>;
 		reg-io-width = <4>;
+		uhs-ddr50;
 		status = "disabled";
 	};
 
-- 
1.7.2.5

