From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Apr 2013 07:40:10 +0000
Subject: [PATCH 0/4 v2] ARM: shmobile: r8a7790 clock update
Message-Id: <87wqs8nqnd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Magnus

These are v2 of r8a7790 clocks update patches.
v1 patch set had datasheet <--> real machine mismatch,
but this v2 solved that issue.

These are based on renesas-next-20130411v2 tags

Kuninori Morimoto (4):
      ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
      ARM: shmobile: r8a7790: add main clock
      ARM: shmobile: r8a7790: add div4 clocks
      ARM: shmobile: r8a7790: add div6 clocks

 arch/arm/mach-shmobile/clock-r8a7790.c      |  227 ++++++++++++++++++++++++++-
 arch/arm/mach-shmobile/include/mach/clock.h |    4 +-
 2 files changed, 224 insertions(+), 7 deletions(-)

