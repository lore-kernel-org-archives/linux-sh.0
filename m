From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 00:35:18 +0000
Subject: [PATCH 00/05] ARM: mach-shmobile: sh7372 power domain update
Message-Id: <20110628003518.11399.93646.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: sh7372 power domain update

[PATCH 01/05] ARM: mach-shmobile: sh7372 A4LC cleanups
[PATCH 02/05] ARM: mach-shmobile: sh7372 A4LC support for AP4EVB
[PATCH 03/05] ARM: mach-shmobile: sh7372 A3RV support
[PATCH 04/05] ARM: mach-shmobile: sh7372 A3RI support
[PATCH 05/05] ARM: mach-shmobile: sh7372 A3SG support

These patches add partial hardware power domain support for the
sh7372 SoC. Trivial power domains such as A3RV, A3RI, and A3SG
are added. A4LC power domain support is updated.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the suspend-2.6 git pm-domains branch, locally updated
 with the reworked sh7372 patch from Rafael:
  "ARM / shmobile: Support for I/O power domains for SH7372 (v9)"

 arch/arm/mach-shmobile/board-ap4evb.c        |    3 +++
 arch/arm/mach-shmobile/board-mackerel.c      |    7 +++----
 arch/arm/mach-shmobile/include/mach/sh7372.h |   11 +++++------
 arch/arm/mach-shmobile/pm-sh7372.c           |   12 ++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    7 +++++++
 5 files changed, 30 insertions(+), 10 deletions(-)

