From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 27 Mar 2013 07:54:33 +0000
Subject: [PATCH 0/8] ARM: shmobile: tidyup clocks
Message-Id: <877gkti8g9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These patches tidyup current mach-shmobile clocks.
And, last patch adds MD pin check support on R-Car H1.

1), 2) removed DIV4_ZT* clocks which are not used from Linux/Software.
3)     adds new macro for fixed ratio clock
6)     tidyup r8a7740 clock mismatch implementation
4), 5), 7) switch over to use 3)'s fixed ratio macro
8)     add MD pin check support on R-Car H1, and used 3)'s fixed ratio macro

These patches are tesed on mackerel/kzm9g/armadillo800eva/marzen board.
And these are based on simon's sh-arm/next branch
(442d651d3764ba4203c6b766a1ddd3ac24a40410)

These are preparation on R-Car series clock support
(R-Car H1 was included as 8)

Kuninori Morimoto (8):
      1) ARM: shmobile: sh73a0: remove DIV4_ZT* clocks
      2) ARM: shmobile: sh7372: remove DIV4_ZT* clocks
      3) ARM: shmobile: add struct clk_ratio and fixed ratio clock macro
      4) ARM: shmobile: sh7372: use fixed ratio clock
      5) ARM: shmobile: sh73a0: use fixed ratio clock
      6) ARM: shmobile: r8a7740: tidyup comment/implementation mismatch
      7) ARM: shmobile: r8a7740: use fixed ratio clock
      8) ARM: shmobile: r8a7779: remove DIV4 clocks and use fixed ratio clock

 arch/arm/mach-shmobile/clock-r8a7740.c      |  114 ++++++----------
 arch/arm/mach-shmobile/clock-r8a7779.c      |  196 +++++++++++++++------------
 arch/arm/mach-shmobile/clock-sh7372.c       |   50 ++-----
 arch/arm/mach-shmobile/clock-sh73a0.c       |   76 ++---------
 arch/arm/mach-shmobile/clock.c              |   13 ++
 arch/arm/mach-shmobile/include/mach/clock.h |   39 ++++++
 6 files changed, 222 insertions(+), 266 deletions(-)



Best regards
---
Kuninori Morimoto
