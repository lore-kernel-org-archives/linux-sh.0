From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 06:43:15 +0000
Subject: [PATCH 0/4] ARM: shmobile: r8a7778/r8a7779: add I2C support on DT
Message-Id: <87k3htzgcf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add I2C support on r8a7778,
and tidyup missing I2C on r8a7779
These are based on
 1) my previous DT patches.
 2) git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git :: for-next branch

These is no compile error without 2)..

Kuninori Morimoto (4):
      ARM: shmobile: r8a7778: add I2C clock for DT
      ARM: shmobile: r8a7778: add I2C support on DTSI
      ARM: shmobile: r8a7779: tidyup I2C driver name on DTSI
      ARM: shmobile: r8a7779: add I2C clock for DT

 arch/arm/boot/dts/r8a7778.dtsi         |   40 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7779.dtsi         |    8 +++----
 arch/arm/mach-shmobile/clock-r8a7778.c |    4 ++++
 arch/arm/mach-shmobile/clock-r8a7779.c |    4 ++++
 4 files changed, 52 insertions(+), 4 deletions(-)

Best regards
---
Kuninori Morimoto
