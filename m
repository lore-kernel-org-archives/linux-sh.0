From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:36:41 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7779: removed unnecessary mmc option
Message-Id: <8738k47lw9.wl%kuninori.morimoto.gx@gmail.com>
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

r8a7779 specific MMC options are cared by driver.
This driver removes these from DTSI

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779.dtsi |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index d0561d4..2105059 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -220,8 +220,6 @@
 		reg = <0xffe4c000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -230,8 +228,6 @@
 		reg = <0xffe4d000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -240,8 +236,6 @@
 		reg = <0xffe4e000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
@@ -250,8 +244,6 @@
 		reg = <0xffe4f000 0x100>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
-		cap-sd-highspeed;
-		cap-sdio-irq;
 		status = "disabled";
 	};
 
-- 
1.7.9.5

