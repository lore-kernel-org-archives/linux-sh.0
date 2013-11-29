From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 29 Nov 2013 03:00:55 +0000
Subject: [PATCH 0/4] ARM: shmobile: R-Car H2 sound support prepare
Message-Id: <87pppj52u4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Laurent

These are prepare patches for R-Car H2 sound support.
H2 sound support itself needs ALSA ASoC update,
so, I can't send lager board sound support patches at this point.
But, these doesn't have relationship to ALSA.

#1 #2 are PFC patches
#3    is  I2C patch
#4    is  clock patch

Kuninori Morimoto (4):
      sh-pfc: r8a7790: Add SSI pin support
      sh-pfc: r8a7790: Add Audio pin support
      ARM: shmobile: r8a7790: add I2C support
      ARM: shmobile: r8a7790: add sound clock support

 arch/arm/mach-shmobile/clock-r8a7790.c |   45 +++++
 arch/arm/mach-shmobile/setup-r8a7790.c |   25 +++
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c   |  309 ++++++++++++++++++++++++++++++++
 3 files changed, 379 insertions(+)
