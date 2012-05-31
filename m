From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:21:58 +0000
Subject: [PATCH 0/9] ARM: mach-shmobile: r8a7740: add DMAEngine support
Message-Id: <87sjeh8ajm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael
Cc Magnus, Simon

These are r8a7740 DMAEngine support patch set.

Kuninori Morimoto (9):
      ARM: mach-shmobile: share DMAEngine definitions
      ARM: mach-shmobile: share TS_HI/LOW value for DMAEngine
      ARM: mach-shmobile: share USBTS_HI/LOW value for USB DMAEngine
      ARM: mach-shmobile: r8a7740: add FSI DMAEngine support
      ARM: mach-shmobile: r8a7740: add SDHI DMAEngine support
      ARM: mach-shmobile: r8a7740: add USB DMAEngine support
      ARM: mach-shmobile: armadillo800eva: add FSI DMAEngine support
      ARM: mach-shmobile: armadillo800eva: add SDHI DMAEngine support
      ARM: mach-shmobile: armadillo800eva: add USB DMAEngine support

These are depend on my
[ARM: mach-shmobile: armadillo: add FSI/HDMI/Camera support] patch set

compile/boot is OK, but these need ASoC v3.5-rcX merge for FSI sound.
Without this merge, 1) HDMI sound doesn't work, 2) sound is noisy.

fbe42f6		ASoC: fsi: bugfix: ensure dma is terminated
4a1b09b		ASoC: fsi: bugfix: correct dma area
e42bb9b		ASoC: fsi: bugfix: enable master clock control on DMA stream

Best regards
---
Kuninori Morimoto
