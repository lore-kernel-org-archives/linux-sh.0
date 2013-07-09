From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Jul 2013 05:51:51 +0000
Subject: [PATCH 0/4] ARM: shmobile: r8a7778: add USB Func support
Message-Id: <87fvvoth57.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add USB Func support on r8a7778/BockW.
These are based on renesas-next-20130704v2 tag

Kuninori Morimoto (4):
      ARM: shmobile: r8a7778: add usb phy power control function
      ARM: shmobile: r8a7778: add r8a7778_add_usb_host_device()
      ARM: shmobile: r8a7778: add r8a7778_add_usb_func_device()
      ARM: shmobile: bockw: add USB Function support

 arch/arm/mach-shmobile/board-bockw.c          |   56 ++++++++++++++--
 arch/arm/mach-shmobile/clock-r8a7778.c        |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    5 +-
 arch/arm/mach-shmobile/setup-r8a7778.c        |   86 +++++++++++++++++++------
 4 files changed, 125 insertions(+), 23 deletions(-)



Best regards
---
Kuninori Morimoto
