From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Jul 2013 02:27:12 +0000
Subject: [PATCH 0/4 v2] ARM: shmobile: r8a7778: add USB Func support
Message-Id: <87wqozup37.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 patches for adding USB Func support on r8a7778/BockW.
These are based on renesas-next-20130704v2 tag

# Sorry I still couldn't get renesas-next-20130710 tag now
# it seems need more synchronize time on server

Kuninori Morimoto (4):
      ARM: shmobile: r8a7778: add usb phy power control function
      ARM: shmobile: r8a7778: add r8a7778_add_usb_host_device()
      RM: shmobile: r8a7778: add r8a7778_add_usb_func_device()
      ARM: shmobile: bockw: add USB Function support

 arch/arm/mach-shmobile/board-bockw.c          |   50 +++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7778.c        |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    5 +-
 arch/arm/mach-shmobile/setup-r8a7778.c        |   89 ++++++++++++++++++++-----
 4 files changed, 124 insertions(+), 21 deletions(-)
