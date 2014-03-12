From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 12 Mar 2014 06:47:36 +0000
Subject: [PATCH 0/2][RFC] ASoC: fsi/rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>


Hi Mark, Simon

These patches fixup Renesas fsi/rcar driver's
SND_SOC_DAIFMT_CBx_CFx flag settings.

I had misunderstand these settings...
But this is still [RFC], since it modifies DT side code too.

>> Mark

#1 patch depends on Jyri's
"Fix simple-card *-master DT parameter handling"
if it was accepted

>> Simon

Can you check #1 patch which modifys SH-ARM platform ?

Kuninori Morimoto (2):
      1) ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags
      2) ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    3 ++-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    2 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +---
 arch/arm/mach-shmobile/board-kzm9g.c               |    4 +---
 arch/arm/mach-shmobile/board-mackerel.c            |    6 ++----
 arch/sh/boards/mach-ecovec24/setup.c               |    4 +---
 arch/sh/boards/mach-se/7724/setup.c                |    4 +---
 sound/soc/sh/fsi.c                                 |    2 +-
 sound/soc/sh/rcar/core.c                           |    4 ++--
 9 files changed, 13 insertions(+), 20 deletions(-)


Best regards
---
Kuninori Morimoto
