From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:36:19 +0000
Subject: [PATCH 0/6] ARM: shmobile: enable DMAEngine on armadillo800eva
Message-Id: <87395jlluo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael, Magnus
Cc Simon

These patch set enable DMAEngine on armadillo800eva.
This patch set depends on my
[PATCH 0/2] ARM: shmobile: enable FSI-codec on armadillo800eva

Kuninori Morimoto (6):
      ARM: shmobile: r8a7740: add DMAEngine support for FSI
      ARM: shmobile: r8a7740: add DMAEngine support for SDHI
      ARM: shmobile: r8a7740: add DMAEngine support for USB
      ARM: shmobile: armadillo800eva: enable DMAEngine on FSI
      ARM: shmobile: armadillo800eva: enable DMAEngine on SDHI
      ARM: shmobile: armadillo800eva: enable DMAEngine on USB
