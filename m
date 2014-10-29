From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:59:25 +0000
Subject: [PATCH 19/19] ARM: shmobile: kzm9d dts: Add chosen/stdout-path
Message-Id: <120f038cf04b95dc895cba503a7516ff75561438.1414556944.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a stdout-path property so that automatic console selection works
in the absence of a "console=" parameter on the kernel command line.

Note that we have to keep the "console=ttyS1,115200n81" parameter in
chosen/bootargs, else the console will use the default setting of 9600
baud.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index a1794cb..667d323 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -25,6 +25,7 @@
 
 	chosen {
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
+		stdout-path = &uart1;
 	};
 
 	gpio_keys {
-- 
2.1.1

