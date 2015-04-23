From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 23 Apr 2015 08:18:31 +0000
Subject: [PATCH 7/7 v4] ARM: shmobile: r8a7791: add MMCIF parent clock range
Message-Id: <871tjbgsxa.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87d22vgt8u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d22vgt8u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Simon <horms@verge.net.au>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
v3 -> v4

 - new patch

 arch/arm/boot/dts/r8a7791.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3e9f824..47eb36a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -471,6 +471,7 @@
 		dma-names = "tx", "rx";
 		reg-io-width = <4>;
 		status = "disabled";
+		clk-range = <12187500 97500000>;
 	};
 
 	sdhi0: sd@ee100000 {
-- 
1.9.1

