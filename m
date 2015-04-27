From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:49:09 +0000
Subject: [PATCH] ASoC: rsnd: Use generic names for device nodes
Message-Id: <1430138949-14563-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

rcar_sound -> sound

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index f316ce1f214a03e3..62ece4c59da759a4 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -47,7 +47,7 @@ DAI subnode properties:
 
 Example:
 
-rcar_sound: rcar_sound@ec500000 {
+rcar_sound: sound@ec500000 {
 	#sound-dai-cells = <1>;
 	compatible = "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2";
 	reg =	<0 0xec500000 0 0x1000>, /* SCU */
-- 
1.9.1

