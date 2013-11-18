From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Nov 2013 02:50:19 +0000
Subject: [PATCH 0/3] ARM: shmobile: bockw: DMAEngine support for sound
Message-Id: <87iovq77a0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add DMAEngine support for sound
These need...

 - linus/master branch merge (sound driver update)
 - HPB-DMAC fixup patches (remove noise issue)
 - my previous patch (DMAEngile stall issue)

I guess #1 patch needs Mark's Acked-by

Kuninori Morimoto (3):
      ARM: shmobile: bockw: remove unused RSND_SSI_CLK_FROM_ADG
      ARM: shmobile: r8a7778: add HPBIFx DMAEngine support
      ARM: shmobile: bockw: DMAEngine support for sound

 arch/arm/mach-shmobile/board-bockw.c          |   22 +++++++----
 arch/arm/mach-shmobile/include/mach/r8a7778.h |   18 +++++++++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   51 +++++++++++++++++++++++++
 include/sound/rcar_snd.h                      |    1 -
 4 files changed, 84 insertions(+), 8 deletions(-)


Best regards
---
Kuninori Morimoto
