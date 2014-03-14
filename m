From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 14 Mar 2014 00:54:55 +0000
Subject: Re: [PATCH 0/2 v2] ASoC: fsi/rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
Cc: Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


Hi Mark, Simon

These are v2 of Renesas fsi/rcar driver's
SND_SOC_DAIFMT_CBx_CFx flag fixup patches.

Kuninori Morimoto (2):
      ASoC: fsi: fixup SND_SOC_DAIFMT_CBx_CFx flags
      ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags

 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 +---
 arch/arm/mach-shmobile/board-kzm9g.c           |    4 +---
 arch/arm/mach-shmobile/board-mackerel.c        |    6 ++----
 arch/sh/boards/mach-ecovec24/setup.c           |    4 +---
 arch/sh/boards/mach-se/7724/setup.c            |    4 +---
 sound/soc/sh/fsi.c                             |    2 +-
 sound/soc/sh/rcar/core.c                       |    4 ++--
 7 files changed, 9 insertions(+), 19 deletions(-)

