From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 22 Apr 2012 21:59:04 +0000
Subject: ASoC: sh: fsi: Build proble in 3.4-rc4
Message-Id: <201204230001.41270.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Paul Mundt <lethal@linux-sh.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

Hi all,

There is a build problem in sound/soc/sh/fsi.c which seems to be fixed by
the following patch.  I'm unsure if that is the right fix, though.

Thanks,
Rafael


---
 sound/soc/sh/fsi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/sound/soc/sh/fsi.c
=================================--- linux.orig/sound/soc/sh/fsi.c
+++ linux/sound/soc/sh/fsi.c
@@ -1003,7 +1003,7 @@ static void fsi_dma_do_tasklet(unsigned
 
 	desc = chan->device->device_prep_slave_sg(chan, &sg, 1, dir,
 						  DMA_PREP_INTERRUPT |
-						  DMA_CTRL_ACK);
+						  DMA_CTRL_ACK, NULL);
 	if (!desc) {
 		dev_err(dai->dev, "device_prep_slave_sg() fail\n");
 		return;
