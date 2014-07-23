From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 Jul 2014 02:44:51 +0000
Subject: [PATCH 09/11][RFC] ARM: shmobile: lager: Sound DMA support via DVC on DTS
Message-Id: <87r41cu732.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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
index cce57c6..c96a572 100644
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
@@ -455,8 +458,8 @@
 
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

