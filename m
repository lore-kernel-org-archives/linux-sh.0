From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:28 +0000
Subject: [PATCH 04/10] ARM: shmobile: r8a7790 dtsi: Use generic names for device nodes
Message-Id: <1430139334-15272-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

rcar_sound -> sound

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f3b8430070b6e4b9..943d2e29bc57133f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1442,7 +1442,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound@ec500000 {
+	rcar_sound: sound@ec500000 {
 		/*
 		 * #sound-dai-cells is required
 		 *
-- 
1.9.1

