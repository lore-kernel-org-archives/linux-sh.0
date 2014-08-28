From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 08:20:40 +0000
Subject: [PATCH resend 2/2] ARM: shmobile: r8a7779 dtsi: Add SoC-specific thermal compatible property
Message-Id: <1409214040-5937-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1409214040-5937-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409214040-5937-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The thermal node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Resend, doc update is in v3.17-rc1
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 559788b2ff77..ddc89000854c 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -256,7 +256,7 @@
 	};
 
 	thermal@ffc48000 {
-		compatible = "renesas,rcar-thermal";
+		compatible = "renesas,thermal-r8a7779", "renesas,rcar-thermal";
 		reg = <0xffc48000 0x38>;
 	};
 
-- 
1.9.1

