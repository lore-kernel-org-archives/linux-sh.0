From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:23:27 +0000
Subject: Re: [PATCH 0/12 v2] ARM: shmobile: r8a7740: add basic pm domain support
Message-Id: <8762a2r4zo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael
Cc Magnus, Simon, Paul


These are v2 patch set for ARM-shmobile PM domain.

>> Rafael

> Then, #2/#3/#4/#6/#7 will be updated.
> but #1/#5 have no update.
> Should I re-send these too on v2?
> Or can you consider these 2 independently ?

Sorry for my confusion mail, but this patch set include original #1/#5 patches.
So, please ignore above question.


This PM support needs mmc branch merge for correct behavior.
Without mmc branch merge, compile/boot are OK,
but "echo mem > /sys/power/state" will be failed on sh_mmc.

These v2 patches try...
 - add common API
 - switch to new API on each board.
 - remove old API
I believe this patch style is good match for backport/rafael.

The patch set order and -stat will be appeared below

** CAUTION **
9 ARM: shmobile: sh7372: add pm-rmobile domain support
and Magunus's
[PATCH] ARM: shmobile: Use INTCA with sh7372 A3SM power domain
will be get 1 line conflict, but it is easy to fixup

These patch set include below 5 features

 1) add R-Mobile common PM domain API

       1 ARM: shmobile: soc-core: add R-mobile PM domain common APIs

 2) armadillo USB use external IRQ mode

       2 ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
       6 ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode

 3) PM support for r8a7740/armadillo

       depends on above 1)/2)
       3 ARM: shmobile: r8a7740: add A4S pm domain support
       4 ARM: shmobile: r8a7740: add A3SP pm domain support
       5 ARM: shmobile: r8a7740: add A4LC pm domain support
       6 ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
       7 ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
       8 ARM: shmobile: armadillo800eva: A3SP domain includes USB

 4) switch to R-Mobile PM base on sh7372

       depends on above 1)
       9 ARM: shmobile: sh7372: add pm-rmobile domain support
      10 ARM: shmobile: mackerel: switch to using pm-rmobile API
      11 ARM: shmobile: ap4evb: switch to using pm-rmobile API

 5) remove un-used original sh7372 PM

       depends on above 4)
      12 ARM: shmobile: sh7372: completely switch over to using pm-rmobile API
 

Kuninori Morimoto (12):
       1 ARM: shmobile: add R-mobile PM domain common APIs
       2 ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
       3 ARM: shmobile: r8a7740: add A4S pm domain support
       4 ARM: shmobile: r8a7740: add A3SP pm domain support
       5 ARM: shmobile: r8a7740: add A4LC pm domain support
       6 ARM: shmobile: armadillo800eva: USB Func enables external IRQ mode
       7 ARM: shmobile: armadillo800eva: A4LC domain includes LCDC
       8 ARM: shmobile: armadillo800eva: A3SP domain includes USB
       9 ARM: shmobile: sh7372: add pm-rmobile domain support
      10 ARM: shmobile: mackerel: switch to using pm-rmobile API
      11 ARM: shmobile: ap4evb: switch to using pm-rmobile API
      12 ARM: shmobile: sh7372: completely switch over to using pm-rmobile API

 arch/arm/mach-shmobile/Makefile                  |    2 +
 arch/arm/mach-shmobile/board-ap4evb.c            |   16 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c   |   54 +++++-
 arch/arm/mach-shmobile/board-mackerel.c          |   24 ++--
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |   44 +++++
 arch/arm/mach-shmobile/include/mach/r8a7740.h    |    8 +
 arch/arm/mach-shmobile/include/mach/sh7372.h     |   45 +----
 arch/arm/mach-shmobile/pfc-r8a7740.c             |    4 +-
 arch/arm/mach-shmobile/pm-r8a7740.c              |   59 +++++++
 arch/arm/mach-shmobile/pm-rmobile.c              |  167 +++++++++++++++++++
 arch/arm/mach-shmobile/pm-sh7372.c               |  191 +++-------------------
 arch/arm/mach-shmobile/setup-r8a7740.c           |   22 +++
 arch/arm/mach-shmobile/setup-sh7372.c            |   78 +++++-----
 13 files changed, 444 insertions(+), 270 deletions(-)


Best regards
---
Kuninori Morimoto
