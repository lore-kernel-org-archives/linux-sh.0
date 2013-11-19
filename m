From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Nov 2013 09:03:31 +0000
Subject: [PATCH 0/6] ARM: shmobile: clock fixup
Message-Id: <87a9h0epb4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are fixup patches for clocks

#1 - #2 are r8a7790 clock bug fix patches.
#3 - #6 are tidyup/cleanup patches

Kuninori Morimoto (6):
      1) ARM: shmobile: r8a7790: care EXTAL divider settings
      2) ARM: shmobile: r8a7790: fixup I2C clock source
      3) ARM: shmobile: sh73a0: tidyup clock table order
      4) ARM: shmobile: r7s72100: tidyup clock table order
      5) ARM: shmobile: r8a7790: tidyup clock table order
      6) ARM: shmobile: sh7372: tidyup clock table order

 arch/arm/mach-shmobile/clock-r7s72100.c |    4 +++-
 arch/arm/mach-shmobile/clock-r8a7790.c  |   25 ++++++++++++++-----------
 arch/arm/mach-shmobile/clock-sh7372.c   |    9 +++++----
 arch/arm/mach-shmobile/clock-sh73a0.c   |   14 ++++++++------
 4 files changed, 30 insertions(+), 22 deletions(-)
