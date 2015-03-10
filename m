From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 10 Mar 2015 00:44:52 +0000
Subject: [PATCH 15/15] ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up source
Message-Id: <90ca409a1e6b9b72d1b6ae716cd7a63335fd0e87.1425947992.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 9734dd7..d1b6a07 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -130,6 +130,7 @@
 			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_0>;
 			label = "S16";
+			gpio-key,wakeup;
 		};
 
 		menu-key {
-- 
2.1.4

