From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 Feb 2013 15:44:38 +0000
Subject: [PATCH 00/06] ARM: shmobile: Trivial SMP cleanups
Message-Id: <20130212154438.13067.77359.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: Trivial SMP cleanups

[PATCH 01/06] ARM: shmobile: Remove unused headers from hotplug.c
[PATCH 02/06] ARM: shmobile: Remove partial CPU Hotplug from EMEV2
[PATCH 03/06] ARM: shmobile: Move EMEV2 CPU boot vector setup code
[PATCH 04/06] ARM: shmobile: Remove sh73a0_get_core_count()
[PATCH 05/06] ARM: shmobile: Remove r8a7779_get_core_count()
[PATCH 06/06] ARM: shmobile: Remove emev2_get_core_count()

This series contains random trivial SMP cleanups for mach-shmobile.

The patches are known to build for sh73a0, r8a7779 and EMEV2,
and on top of that they also work well on the KZM9D/EMEV2 board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 No known dependencies, simply written against -next in renesas.git.

 arch/arm/mach-shmobile/hotplug.c     |    4 --
 arch/arm/mach-shmobile/smp-emev2.c   |   55 ++++++----------------------------
 arch/arm/mach-shmobile/smp-r8a7779.c |    9 -----
 arch/arm/mach-shmobile/smp-sh73a0.c  |    9 -----
 4 files changed, 13 insertions(+), 64 deletions(-)


