From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:46:57 +0000
Subject: [PATCH 4/6] ARM: shmobile: kzm9g-reference: Common clock framework DT description
Message-Id: <1a9a658113c33235ca12e622d91331dd91c61035.1419809955.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419809955.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419809955.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

KZM9G-specific clock overrides.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 939be12..3d912ea 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -182,6 +182,10 @@
 	status = "ok";
 };
 
+&extal2_clk {
+	clock-frequency = <48000000>;
+};
+
 &i2c0 {
 	status = "okay";
 	as3711@40 {
-- 
2.1.3

