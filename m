From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Jan 2010 08:08:52 +0000
Subject: [PATCH 0/4] ALSA: SH: add ASoC driver for SIU audio engine, an audio
Message-Id: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>

Hi

This patch series adds support for the Sound Interface Unit (SIU), found 
on several SuperH SoCs, including sh7722, sh7343, sh7354, sh7367. The 
driver supports playback and capture at various bitrates, mono and stereo, 
so far only tested with an I2S codec, support for the PCM 
(SND_SOC_DAIFMT_LEFT_J) is also included. The hardware also supports 
S/PDIF, but including support for it would require more work and testing 
on a suitable hardware platform.

The SIU engine includes a DSP, that has to be programmed separately. The 
driver uses the standard request_firmware() API to load the program and 
data.

This patch series also requires the earlier

[PATCH] sh: support SIU sourcing from external clock on sh7722
(http://www.spinics.net/lists/linux-sh/msg04075.html)

patch for proper functionality.

Comments welcome.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
