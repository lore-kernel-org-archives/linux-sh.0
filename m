From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Oct 2013 07:20:29 +0000
Subject: [PATCH v3 0/3] ARM: shmobile: CPUFreq support on Lager
Message-Id: <1380871232-31896-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is v3 of CPUFreq support on Lager, when booting on a CA15 core. Only
compile tested due to lacking hardware access. But changes since v2 are
minimal, so, there's a good chance this still works. In fact there's only
one change, explained in patch 1. Patches 2 and 3 are simply former patc
5, trivially split into 2.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: shmobile: r8a7790: add CPUFreq clock support
  ARM: shmobile: lager: add Device Tree entries for CA15 CPUFreq
    support
  ARM: shmobile: lager: add CPUFreq support

 arch/arm/boot/dts/r8a7790-lager-reference.dts  |   33 +++++
 arch/arm/mach-shmobile/Kconfig                 |    2 +
 arch/arm/mach-shmobile/board-lager-reference.c |    4 +-
 arch/arm/mach-shmobile/clock-r8a7790.c         |  152 ++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 1 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
