From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 12:48:24 +0000
Subject: [PATCH] ASoC: Allow SND_SOC_WM8978 to be selected manually
Message-Id: <1409230104-22750-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When using a DT-based multi-platform kernel, there's not always Kconfig
logic that selects the right codec driver.
Allow the user to manually select WM8978.

This is needed for Armadillo 800 EVA using a generic r8a7740 multi-platform
kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7678122f8fe0..8ab154756934 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -731,7 +731,8 @@ config SND_SOC_WM8974
 	tristate
 
 config SND_SOC_WM8978
-	tristate
+	tristate "Wolfson Microelectronics WM8978 codec"
+	depends on I2C
 
 config SND_SOC_WM8983
 	tristate
-- 
1.9.1

