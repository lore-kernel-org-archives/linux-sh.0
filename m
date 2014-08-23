From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:44:01 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Cleanup Updates for v3.18
Message-Id: <cover.1408670789.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216284.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216284.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC cleanup updates for v3.18.

This pull request is based on
"Renesas ARM Based SoC DT Timers Updates for v3.18",
tagged as dt-timers-for-v3.18,
which I have already sent a pull-request for.

This is a rebase of changes that didn't quite make it into v3.17.
These cleanups depend on changes in dt-timers-for-v3.18 and rebasing
to remove that dependency is not entirely trivial.


The following changes since commit 9dddfcfacaadb5491b62233b893b510fa00da4e0:

  ARM: shmobile: genmai-reference: Enable MTU2 in device tree (2014-08-17 09:02:54 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cleanup-for-v3.18

for you to fetch changes up to ad8c3af8b75ff26c5c887f2101da653bdcd53a38:

  ARM: shmobile: r7s72100: Remove legacy board support (2014-08-17 09:57:08 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Cleanup Updates for v3.18

* Remove Genmai board code

----------------------------------------------------------------
Laurent Pinchart (3):
      ARM: shmobile: r7s72100: genmai: Remove reference board file
      ARM: shmobile: r7s72100: genmai: Remove legacy board file
      ARM: shmobile: r7s72100: Remove legacy board support

 arch/arm/mach-shmobile/Kconfig                  |  17 --
 arch/arm/mach-shmobile/Makefile                 |   3 -
 arch/arm/mach-shmobile/Makefile.boot            |   1 -
 arch/arm/mach-shmobile/board-genmai-reference.c |  35 ----
 arch/arm/mach-shmobile/board-genmai.c           | 173 ------------------
 arch/arm/mach-shmobile/clock-r7s72100.c         | 231 ------------------------
 arch/arm/mach-shmobile/r7s72100.h               |   6 -
 arch/arm/mach-shmobile/setup-r7s72100.c         |   2 -
 8 files changed, 468 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-genmai-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-genmai.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r7s72100.c
 delete mode 100644 arch/arm/mach-shmobile/r7s72100.h
