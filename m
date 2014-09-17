From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 17 Sep 2014 00:48:12 +0000
Subject: [PATCH v2 1/5] ARM: shmobile: kzm9d: Remove spurious regulator base addresses
Message-Id: <1410914896-14395-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1410914896-14395-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As there is no reg property the regulator nodes should
not include @...

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 50ccd15..f27fcf0 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -27,7 +27,7 @@
 		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
 	};
 
-	reg_1p8v: regulator@0 {
+	reg_1p8v: regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -36,7 +36,7 @@
 		regulator-boot-on;
 	};
 
-	reg_3p3v: regulator@1 {
+	reg_3p3v: regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
 		regulator-min-microvolt = <3300000>;
-- 
2.0.1

