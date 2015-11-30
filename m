From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 30 Nov 2015 06:02:52 +0000
Subject: [PATCH] ASoC: rsnd:  Add device tree support for r8a77{79,93,94}
Message-Id: <1448863372-14788-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Simply document new compat strings.
There appears to be no need for a driver updates.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
The r8a7792 is omitted from this change as according to the documentation
the hardware does not appear to be present on that SoC.
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index bbcb3272977d..59cebfbd7b6a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -7,8 +7,11 @@ Required properties:
 				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
+				    - "renesas,rcar_sound-r8a7779" (R-Car H1)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
 				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
+				    - "renesas,rcar_sound-r8a7793" (R-Car M2-N)
+				    - "renesas,rcar_sound-r8a7794" (R-Car E2)
 				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
 - reg				: Should contain the register physical address.
 				  required register is
-- 
2.1.4

