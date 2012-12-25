From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Dec 2012 04:03:10 +0000
Subject: [PATCH 0/4] ARM/sh: add sample amixer settings for FSI-codec
Message-Id: <87r4me7p8k.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Paul

These patches add sample amixer settings for sound on comment area.
Sound doesn't work without these puzzling settings

Kuninori Morimoto (4):
      ARM: shmobile: fix sample amixer settings for mackerel
      ARM: shmobile: add sample amixer settings for ap4evb
      ARM: shmobile: add sample amixer settings for armadillo800eva
      sh: ecovec: add sample amixer settings

 arch/arm/mach-shmobile/board-ap4evb.c          |    4 ++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++++
 arch/arm/mach-shmobile/board-mackerel.c        |    4 +---
 arch/sh/boards/mach-ecovec24/setup.c           |   10 ++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)
