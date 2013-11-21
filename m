From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Nov 2013 07:19:51 +0000
Subject: [PATCH 0/2] ARM: shmobile: lager: add regulator support
Message-Id: <87iovmxlv1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These were part of SDHI support patch-set,
but I separat it.
These have no relationship to other branch.
I will re-send SDHI support main patch
if the relationship was solved.

Kuninori Morimoto (2):
      ARM: shmobile: lager: add gpio/fixed regulator for SDHI
      ARM: shmobile: lager: add gpio regulator support on defconfig

 arch/arm/configs/lager_defconfig     |    1 +
 arch/arm/mach-shmobile/board-lager.c |   83 +++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

