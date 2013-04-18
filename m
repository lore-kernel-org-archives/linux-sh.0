From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Apr 2013 06:40:07 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7778: add GPIO support
Message-Id: <87fvyos5ob.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These patches add GPIO support for R8A7778
I tested these patches on Bock-W board.

When I tested GPIO-IRQ, I used SMSC (by local-hack, I don't send it to ML).
Current SMSC is using IRQ0 (= Function1 of GPIO(1, 12) pin) interrupt now,
then, I put this pin as "GPIO" and "interrupt mode".
It works well for me

Kuninori Morimoto (3):
      gpio-rcar: R-Car GPIO IRQ share interrupt
      ARM: shmobile: add GPIO IRQ macro
      ARM: shmobile: r8a7778: add GPIO support

 arch/arm/mach-shmobile/include/mach/irqs.h |    5 ++++
 arch/arm/mach-shmobile/setup-r8a7778.c     |   36 +++++++++++++++++++++++++++-
 drivers/gpio/gpio-rcar.c                   |    2 +-
 3 files changed, 41 insertions(+), 2 deletions(-)
