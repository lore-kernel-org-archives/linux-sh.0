From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 18 Nov 2014 00:51:13 +0000
Subject: [PATCH 2/4] ARM: shmobile: lager: Use keyboard as gpio-keys node name
Message-Id: <54caf6810327451ea814fd728c45c99755252237.1416271777.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416271777.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416271777.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This appears to be the best match for ePAPR.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 854c13e..7012354 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -43,7 +43,7 @@
 		#size-cells = <1>;
 	};
 
-	gpio_keys {
+	keyboard {
 		compatible = "gpio-keys";
 
 		button@1 {
-- 
2.1.1

