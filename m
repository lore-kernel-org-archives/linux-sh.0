From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Apr 2013 10:00:35 +0000
Subject: [PATCH v5 0/3] CPUFreq for sh73a0 / kzm9g, using cpufreq-cpu0
Message-Id: <1365156038-12467-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

v5: essentially identical to v4, one hunk has been moved from one patch
over to another one, patch #1 no longer depends on a different patch-
series, which will have to be updated.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (3):
  ARM: shmobile: sh73a0: add support for adjusting CPU frequency
  ARM: shmobile: kzm9g-reference: add AS3711 and CPUFreq DT bindings
  ARM: shmobile: sh73a0: add CPUFreq support

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   86 +++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig               |    2 +
 arch/arm/mach-shmobile/clock-sh73a0.c        |   95 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c        |    5 ++
 4 files changed, 186 insertions(+), 2 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
