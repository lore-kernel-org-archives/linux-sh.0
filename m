From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:55:56 +0000
Subject: [PATCH 0/7] ARM: shmobile: swtich audio settings to new style, and remove compatibility code from dr
Message-Id: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, broonie@kernel.org
Cc: Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, alsa-devel@alsa-project.org


Hi Simon, Mark

Now, Linux v3.15-rc1 was released.
1) - 5) remove old style audio settings from platform, and
6) - 7) remove compatibility (= old style) code from driver.

These are based on v3.15-rc1
Simon, can you please create v3.15-rc1 base branch/tag for Mark ?

Kuninori Morimoto (7):
      1) ARM: shmobile: r8a7778: remove old style audio clock
      2) ARM: shmobile: r8a7790: remove old style audio clock
      3) ARM: shmobile: bockw: remove old style audio clock
      4) ARM: shmobile: bockw: switch to use dai info for R-Car sound
      5) ARM: shmobile: lager: switch to use dai info for R-Car sound
      6) ASoC: rsnd: remove old clock style support
      7) ASoC: rsnd: remove compatibility code

 arch/arm/mach-shmobile/board-bockw.c   |   63 +++++++++++++++++++----------
 arch/arm/mach-shmobile/board-lager.c   |   17 +++++---
 arch/arm/mach-shmobile/clock-r8a7778.c |   22 +++++-----
 arch/arm/mach-shmobile/clock-r8a7790.c |   24 +++++------
 include/sound/rcar_snd.h               |   22 ++--------
 sound/soc/sh/rcar/adg.c                |   39 ++----------------
 sound/soc/sh/rcar/core.c               |   54 +++++--------------------
 sound/soc/sh/rcar/rsnd.h               |    3 --
 sound/soc/sh/rcar/src.c                |   69 ++++++++++----------------------
 sound/soc/sh/rcar/ssi.c                |   51 +----------------------
 10 files changed, 111 insertions(+), 253 deletions(-)


Best regards
---
Kuninori Morimoto
