From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Mar 2015 01:05:02 +0000
Subject: [PATCH 0/3] ARM: shmobile: armadillo: fixup CPU settings
Message-Id: <87fv8v4353.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


Hi Mark, Lars
Cc Simon

These patches had been posted in ALSA/SH-ARM ML in
http://thread.gmane.org/gmane.linux.ports.sh.devel/43079
by Lars. But, he doesn't have armadillo board, and I commented
about FSI driver, and no one update these, these patches were
marooned.

Original 2/3 patch changed behavior for clock inversion on FSI driver.
FSI + wm8978 on armadillo800eva worked without any issues,
but, I don't know how much effect it has for other board (many board are using FSI).
We used this inversion flags on each board for historical reasons,
but, almost all these were not needed (except some picky board) on FSI.
Maybe Lars's 2/3 patch is correct, but, it is difficult to check/confirm for all boards.
And unfortunately, Renesas don't use FSI anymore.
So, I think keeping current FSI driver as-is is more safety for old boards.
I tested these patches on latest Mark's branch 

Lars-Peter Clausen (3):
      ARM: shmobile: armadillo800eva: Properly specify HDMI audio link format
      ARM: shmobile: armadillo800eva: fix clock inversion
      ASoC: simple-card: Remove support for setting differing DAI formats

 arch/arm/mach-shmobile/board-armadillo800eva.c |  3 +--
 include/sound/simple_card.h                    |  1 -
 sound/soc/generic/simple-card.c                | 30 ++++++++----------------------
 3 files changed, 9 insertions(+), 25 deletions(-)

