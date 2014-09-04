From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 04 Sep 2014 01:12:24 +0000
Subject: [PATCH 1/5] ARM: shmobile: r8a7779 dtsi: Add SoC-specific thermal compatible property
Message-Id: <4d50e6dd7a019993504a419d0057051788e477f1.1409792871.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409792871.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409792871.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The thermal node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 0e64c76..b749101 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -256,7 +256,7 @@
 	};
 
 	thermal@ffc48000 {
-		compatible = "renesas,rcar-thermal";
+		compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
 		reg = <0xffc48000 0x38>;
 	};
 
-- 
2.0.1

