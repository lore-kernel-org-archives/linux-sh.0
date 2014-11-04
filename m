From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:33 +0000
Subject: [PATCH 03/34] ARM: shmobile: lager: enable USB PHY
Message-Id: <6742cafb6fe84f00f096b206372b48f14eb56946.1415059587.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable USB PHY device for the Lager board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index acab2e1..cd530de 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -472,6 +472,10 @@
 	pinctrl-names = "default";
 };
 
+&usbphy {
+	status = "okay";
+};
+
 /* composite video input */
 &vin1 {
 	pinctrl-0 = <&vin1_pins>;
-- 
2.1.1

