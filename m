From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 29 Oct 2015 19:59:55 +0000
Subject: [PATCH] ASoC: rsrc-card: Clarify compatible value
Message-Id: <1446148795-20629-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>

The compatible value can be board-specific, not SoC-specific.
Add curly braces to indicate that the board type is optional.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
index 962748a8d9194dee..2b2caa281ce38abc 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
@@ -4,8 +4,8 @@ Renesas Sampling Rate Convert Sound Card specifies audio DAI connections of SoC
 
 Required properties:
 
-- compatible				: "renesas,rsrc-card,<board>"
-					  Examples with soctypes are:
+- compatible				: "renesas,rsrc-card{,<board>}"
+					  Examples with boards are:
 					    - "renesas,rsrc-card"
 					    - "renesas,rsrc-card,lager"
 					    - "renesas,rsrc-card,koelsch"
-- 
1.9.1

