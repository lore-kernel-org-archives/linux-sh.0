From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:09:37 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7778 dtsi: Remove unnecessary MMC options
Message-Id: <1414591779-22954-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

As of commit b3a5d4ce65162d27 ("mmc: sdhi: update sh_mobile_sdhi_of_data
for r8a7778), the driver takes care of r8a7778 specific MMC options.
Hence they can be removed from the dtsi.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: Rebased, reworded, added reference]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 96297f67fda8e632..ef8533910029620e 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -251,8 +251,6 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4c000 0x100>;
 		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -260,8 +258,6 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4d000 0x100>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -269,8 +265,6 @@
 		compatible = "renesas,sdhi-r8a7778";
 		reg = <0xffe4f000 0x100>;
 		interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
-- 
1.9.1

