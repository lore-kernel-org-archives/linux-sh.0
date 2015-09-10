From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:12:43 +0000
Subject: [PATCH 1/9][RFC] ASoC: rsnd: Add Gen3 initial support
Message-Id: <87r3m6n43v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas sound Gen3 is updated version of Gen2. We need to update
driver for it, but basically it should works as Gen2 compatible.
This is initial support for Gen3. Gen3 specific feature will be
incrementally added

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 2 ++
 sound/soc/sh/rcar/core.c                                 | 1 +
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 776cf6a..bf6fd1a 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -4,10 +4,12 @@ Required properties:
 - compatible			: "renesas,rcar_sound-<soctype>", fallbacks
 				  "renesas,rcar_sound-gen1" if generation1, and
 				  "renesas,rcar_sound-gen2" if generation2
+				  "renesas,rcar_sound-gen3" if generation3
 				  Examples with soctypes are:
 				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
 				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
+				    - "renesas,rcar_sound-r8a7795" (R-Car H3)
 - reg				: Should contain the register physical address.
 				  required register is
 				   SRU/ADG/SSI      if generation1
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f3feed5..870f944 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -110,6 +110,7 @@ static const struct rsnd_of_data rsnd_of_data_gen2 = {
 static const struct of_device_id rsnd_of_match[] = {
 	{ .compatible = "renesas,rcar_sound-gen1", .data = &rsnd_of_data_gen1 },
 	{ .compatible = "renesas,rcar_sound-gen2", .data = &rsnd_of_data_gen2 },
+	{ .compatible = "renesas,rcar_sound-gen3", .data = &rsnd_of_data_gen2 }, /* gen2 compatible */
 	{},
 };
 MODULE_DEVICE_TABLE(of, rsnd_of_match);
-- 
1.9.1

