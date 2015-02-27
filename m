From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 27 Feb 2015 17:48:39 +0000
Subject: [PATCH 2/2] ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up source
Message-Id: <1425059319-13403-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425059319-13403-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425059319-13403-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 5baada97bc715838..81a38ceee098087e 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -110,6 +110,7 @@
 			gpios = <&pfc 324 GPIO_ACTIVE_LOW>;
 			linux,code = <KEY_0>;
 			label = "S16";
+			gpio-key,wakeup;
 		};
 
 		menu-key {
-- 
1.9.1

