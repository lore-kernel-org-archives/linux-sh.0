From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Aug 2013 04:39:28 +0000
Subject: [GIT PULL 0/9] Renesas ARM based SoC SMP updates for v3.12
Message-Id: <cover.1375841380.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Olof, Hi Arnd,

please consider these Renesas ARM based SoC SMP updates for v3.12.

This pull-request is based on renesas-dt2-for-v3.12, which I have
previously sent a pull-request for.


The following changes since commit 8b3e32c1fe5dce55e28e76b20361841dc863ec17:

  ARM: shmobile: r8a7740: Add TPU node to the device tree (2013-08-06 18:06:23 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-smp-for-v3.12

for you to fetch changes up to 1d33a354bbb618ba578bb372ebc18fe58457f6f3:

  ARM: shmobile: Per-CPU SMP boot / sleep code for SCU SoCs (2013-08-06 18:07:26 +0900)

----------------------------------------------------------------
Renesas ARM based SoC SMP updates for v3.12

* Per-CPU SMP boot and sleep code on SoCs that use SCU
* Shared SCU CPU Hotplug code on r8a7779 and sh73a0 SoCs
* Shared SCU CPU boot code on emev2, r8a7779 and sh73a0 SoCs

----------------------------------------------------------------
Magnus Damm (9):
      ARM: shmobile: Introduce shared SCU SMP boot code
      ARM: shmobile: Use shared SCU SMP boot code on sh73a0
      ARM: shmobile: Use shared SCU SMP boot code on r8a7779
      ARM: shmobile: Use shared SCU SMP boot code on emev2
      ARM: shmobile: Add shared SCU CPU Hotplug code
      ARM: shmobile: Use shared SCU CPU Hotplug code on sh73a0
      ARM: shmobile: Use shared SCU CPU Hotplug code on r8a7779
      ARM: shmobile: Introduce per-CPU SMP boot / sleep code
      ARM: shmobile: Per-CPU SMP boot / sleep code for SCU SoCs

 arch/arm/mach-shmobile/Makefile              |  6 +--
 arch/arm/mach-shmobile/headsmp.S             | 49 +++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |  9 ++++
 arch/arm/mach-shmobile/platsmp-scu.c         | 81 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp.c             | 18 +++++++
 arch/arm/mach-shmobile/smp-emev2.c           | 19 +++----
 arch/arm/mach-shmobile/smp-r8a7779.c         | 64 ++++++----------------
 arch/arm/mach-shmobile/smp-sh73a0.c          | 67 ++++++-----------------
 8 files changed, 202 insertions(+), 111 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/platsmp-scu.c
