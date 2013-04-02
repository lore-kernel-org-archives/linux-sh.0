From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 02 Apr 2013 04:20:29 +0000
Subject: [PATCH 4/5 v3] ARM: shmobile: bockw: enable network settings on bootargs
Message-Id: <87mwth5zsm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjxvewko.wl%kuninori.morimoto.gx@renesas.com>
 <87fvzb56n3.wl%kuninori.morimoto.gx@renesas.com>
 <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sj395zvv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

"ip" and "root" settings are useful for development

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - dts only

 arch/arm/boot/dts/r8a7778-bockw.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 735c964..0076b1e 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -22,7 +22,7 @@
 	compatible = "renesas,bockw", "renesas,r8a7778";
 
 	chosen {
-		bootargs = "console=ttySC0,115200 ignore_loglevel";
+		bootargs = "console=ttySC0,115200 ignore_loglevel ip=dhcp root=/dev/nfs";
 	};
 
 	memory {
-- 
1.7.9.5

