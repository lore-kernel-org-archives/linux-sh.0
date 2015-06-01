From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 01 Jun 2015 10:44:15 +0000
Subject: [PATCH] ASoC: rsnd: Document r8a7778-specific binding
Message-Id: <1433155455-28827-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Add the missing r8a7778-specific compatible value, which is already in
use since v4.1-rc1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 62ece4c59da759a4..b6b3a786855f275b 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -5,6 +5,7 @@ Required properties:
 				  "renesas,rcar_sound-gen1" if generation1, and
 				  "renesas,rcar_sound-gen2" if generation2
 				  Examples with soctypes are:
+				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
 				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
 				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
 - reg				: Should contain the register physical address.
-- 
1.9.1

