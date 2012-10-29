From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Oct 2012 08:13:37 +0000
Subject: [PATCH 0/7] ARM: shmobile: r8a7779/marzen: usb support
Message-Id: <87liep4rwy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon
Cc: Felipe

These are USB support patches for r8a7779/marzen board.
To use USB, it needs USB-phy driver
which is still not applied on USB maintainer's branch yet.
But I know there is ARM-platform patch time-limit soon.
So, I send these patches now.

>> Felipe

I resent "usb: phy: add R-Car USB phy driver" today.
please re-check it.

Kuninori Morimoto (7):
      ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
      ARM: shmobile: r8a7740: add USB24 clock explain
      ARM: shmobile: r8a7779: add USB EHCI clock support
      ARM: shmobile: r8a7779: add USB OHCI clock support
      ARM: shmobile: marzen: add USB phy support
      ARM: shmobile: marzen: add USB EHCI driver support
      ARM: shmobile: marzen: add USB OHCI driver support

 arch/arm/configs/marzen_defconfig             |   14 +-
 arch/arm/mach-shmobile/Kconfig                |    2 +
 arch/arm/mach-shmobile/board-marzen.c         |  186 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/clock-r8a7740.c        |   16 +++
 arch/arm/mach-shmobile/clock-r8a7779.c        |    7 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c          |   16 +--
 7 files changed, 230 insertions(+), 13 deletions(-)


Best regards
---
Kuninori Morimoto
