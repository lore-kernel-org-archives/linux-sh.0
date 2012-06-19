From: kuninori.morimoto.gx@renesas.com
Date: Tue, 19 Jun 2012 02:22:57 +0000
Subject: [PATCH 0/4] ARM: shmobile: kzm9g: enable USB/SD/MMC-DMAEngine
Message-Id: <87d34wt4zq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael
Cc Magnus Simon

These patch set enable USB/SD and MMC-DMAEngine for kzm9g board.
These depend on my previous
[PATCH 0/27] ARM: shmobile: resend patch set

Kuninori Morimoto (4):
      ARM: shmobile: sh73a0: add USB clock support
      ARM: shmobile: kzm9g: enable DMAEngine of MMCIF
      ARM: shmobile: kzm9g: enable USB func
      ARM: shmobile: kzm9g: enable MicroSD

#4 patch require Laurent's patch.
      mmc: tmio: Don't access hardware registers after stopping clocks
With out this patch, MicroSD will dead when boot.

