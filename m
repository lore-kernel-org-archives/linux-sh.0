From: Nick Bowler <nbowler@elliptictech.com>
Date: Fri, 09 Sep 2011 15:26:47 +0000
Subject: [PATCH 0/5] Convert ARM subarchitectures to generic wfi macro.
Message-Id: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series cleans up all remaining ARM subarchitectures that I could
find to use the generic wfi macro.  As I don't have any of the boards in
question, I've only compile-tested these patches to the extent that I
was able.

See the previous discussion in https://lkml.org/lkml/2011/8/19/433 for
more background.

Nick Bowler (5):
  ARM: realview: Use wfi macro in platform_do_lowpower.
  ARM: exynos4: Use wfi macro in platform_do_lowpower.
  ARM: shmobile: Use wfi macro in platform_cpu_die.
  ARM: tegra: Use wfi macro in platform_do_lowpower.
  ARM: omap4: Kill private do_wfi macro.

 arch/arm/mach-exynos4/hotplug.c                 |    9 ++-------
 arch/arm/mach-omap2/include/mach/omap4-common.h |   11 -----------
 arch/arm/mach-omap2/omap-hotplug.c              |    7 +++----
 arch/arm/mach-omap2/pm44xx.c                    |    4 +++-
 arch/arm/mach-realview/hotplug.c                |    9 ++-------
 arch/arm/mach-shmobile/hotplug.c                |   10 +++-------
 arch/arm/mach-tegra/hotplug.c                   |    9 ++-------
 7 files changed, 15 insertions(+), 44 deletions(-)

-- 
1.7.3.4
