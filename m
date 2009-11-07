From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 07 Nov 2009 22:13:39 +0000
Subject: [PATCH 75/75] snd-aica: declare MODULE_FIRMWARE
Message-Id: <1257632019.15927.512.camel@localhost>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/sh/aica.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 583a369..a0df401 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -49,6 +49,7 @@ MODULE_AUTHOR("Adrian McMenamin <adrian@mcmen.demon.co.uk>");
 MODULE_DESCRIPTION("Dreamcast AICA sound (pcm) driver");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Yamaha/SEGA, AICA}}");
+MODULE_FIRMWARE("aica_firmware.bin");
 
 /* module parameters */
 #define CARD_NAME "AICA"
-- 
1.6.5.2


