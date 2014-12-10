From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 10 Dec 2014 14:45:25 +0000
Subject: [PATCH v7 4/6] ARM: shmobile: kzm9g-reference: Common clock framework DT description
Message-Id: <1418222727-19888-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

KZM9G-specific clock overrides.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
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
1.8.4.5

