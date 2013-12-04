From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Dec 2013 01:27:57 +0000
Subject: [PATCH 0/3] ARM: shmobile: add FSI sound support for DT
Message-Id: <871u1t1k2x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

ALSA SoC supports simple-audio-card via DT now

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: topic/dt

These pathes adds FSI-WM8978 sound support for armadillo.

Kuninori Morimoto (3):
      ARM: shmobile: r8a7740: add FSI clock support for DT
      ARM: shmobile: r8a7740: add FSI support via DTSI
      ARM: shmobile: armadillo: add FSI support for DTS

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   37 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740.dtsi                     |    9 +++++
 arch/arm/mach-shmobile/clock-r8a7740.c             |    1 +
 3 files changed, 47 insertions(+)

Best regards
---
Kuninori Morimoto
