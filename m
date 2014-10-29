From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:30:53 +0000
Subject: [PATCH 3/3] ARM: shmobile: kzm9g-reference dts: Drop bogus 0x unit-address prefix
Message-Id: <1414593053-25627-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414593053-25627-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414593053-25627-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0dac0e66ccad8f74..8c913d9b18241a16 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -251,7 +251,7 @@
 		};
 	};
 
-	ak4648: ak4648@0x12 {
+	ak4648: ak4648@12 {
 		#sound-dai-cells = <0>;
 		compatible = "asahi-kasei,ak4648";
 		reg = <0x12>;
-- 
1.9.1

