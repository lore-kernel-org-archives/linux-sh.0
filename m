From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 18 Jun 2014 09:15:17 +0000
Subject: [PROTOTYPE 09/10] ARM: shmobile: lager: Sound DMA support via DVC on DTS
Message-Id: <87wqcewpcp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer uses DVC

     DMA               DMApp
[MEM] -> [SRC] -> [DVC] -> [SSIU] -> [SSI]

     DMA               DMApp
[MEM] <- [DVC] <- [SRC] <- [SSIU] <- [SSI]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index fe89366..621c9ba 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -19,6 +19,9 @@
  * this command is required when playback.
  *
  * # amixer set "LINEOUT Mixer DACL" on
+ * # amixer set "Playback" 100
+ *
+ * # amixer set "Capture" 100
  */
 
 /dts-v1/;
@@ -421,8 +424,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0 &src2>;
-			capture  = <&ssi1 &src3>;
+			playback = <&ssi0 &src2 &dvc0>;
+			capture  = <&ssi1 &src3 &dvc1>;
 		};
 	};
 };
-- 
1.7.9.5

