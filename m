From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 15 Mar 2009 22:05:40 +0000
Subject: [PATCH] snd: aica - fix annoying compiler warning
Message-Id: <1237154740.6636.4.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

Cast pointer to data member of struct firmware as a void to end an
annoying compiler warning.

fix annoying compiler warning

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 7c920f3..822b119 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -567,7 +567,7 @@ static int load_aica_firmware(void)
 		return err;
 	/* write firware into memory */
 	spu_disable();
-	spu_memload(0, fw_entry->data, fw_entry->size);
+	spu_memload(0, (void *)fw_entry->data, fw_entry->size);
 	spu_enable();
 	release_firmware(fw_entry);
 	return err;

