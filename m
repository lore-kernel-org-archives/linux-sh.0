From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:36:33 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7778: removed unnecessary mmc option
Message-Id: <874n4k7lwh.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<8761p07lx8.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8761p07lx8.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7778 specific MMC options are cared by driver.
This driver removes these from DTSI

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778.dtsi |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index ddb3bd7..c309430 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -178,8 +178,6 @@
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -188,8 +186,6 @@
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -198,8 +194,6 @@
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 86 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
-- 
1.7.9.5

