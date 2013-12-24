From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 24 Dec 2013 04:43:39 +0000
Subject: [PATCH 0/3][resend] ARM: shmobile: bockw: add DMAEngine support
Message-Id: <8761qeg8p3.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

HPB-DMAC fixup patches are applied to linus/master branch.
(renesas-devel-v3.13-rc5-20131223 have these too)
These are re-send of DMAEngine support for BockW

Kuninori Morimoto (3):
      ARM: shmobile: bockw: use SSI DMAEngine for sound
      ARM: shmobile: bockw: use HPBIF DMAEngine for sound
      ARM: shmobile: bockw: add USB Func DMAEngine support

 arch/arm/mach-shmobile/board-bockw.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

Best regards
---
Kuninori Morimoto
