From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 Jun 2013 07:10:34 +0000
Subject: [PATCH 0/4] Add DVFS support on APE6EVM
Message-Id: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Having added CPUFreq support to the Cortex A15 cores on APE6 (r8a73a4) and 
DT support to the max8973 regulator driver it is now possible to implement 
CA15 CPUFreq support on APE6EVM, using a max8972 PMU to adjust SoC's DVFS
voltage. This series depends on earlier

"ARM: shmobile: r8a73a4: wait for completion when kicking the clock"
https://patchwork.kernel.org/patch/2601071/
"ARM: shmobile: r8a73a4: implement CPU clock scaling for CPUFreq"
https://patchwork.kernel.org/patch/2601111/

and requires the following max8973 patches:

"regulators: max8973: fix multiple instance support"
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg456101.html
"regulators: max8973: initial DT support"
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg456102.html

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Guennadi Liakhovetski (4):
  ARM: shmobile: r8a73a4: safeguard against wrong clk_set_rate() uses
  ARM: shmobile: r8a73a4: add I2C DT nodes and required clocks
  ARM: shmobile: ape6evm: add CPUFreq support
  ARM: shmobile: r8a73a4: add Z2 clock support

 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   26 ++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi         |   81 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a73a4.c |   56 +++++++++++++++++++++-
 3 files changed, 160 insertions(+), 3 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
