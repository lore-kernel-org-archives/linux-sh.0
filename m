From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Mon, 29 Sep 2014 05:05:40 +0000
Subject: [PATCH RFC v2 0/7] ARM: shmobile: Support L2 shutdown mode in Suspend-to-RAM
Message-Id: <5428E8A4.7020507@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches implement L2 shutdown mode in RCar Gen2 SoC and change
Suspend-to-RAM from Core Standby mode to L2 shutdown mode.
The impact to CPUIdle operation was also put into consideration during
implementation.

I have confirmed Suspend-to-RAM in Lager board and Koelsch board. 
So far, there is no regression detected during my testing. 
There might be further patches to support Alt board. But it would be
after upstream kernel can boot up in Alt board.

I hope to receive some comments for this patch series whether it's
right direction or not. Therefore, I marked it with RFC.
Any comments are appreciated.

This patch series is written on top of renesas-devel-20140924-v3.17-rc6
and has dependency on CPUIdle patches from Kobayashi-san
(http://www.spinics.net/lists/linux-sh/msg34150.html).

Known issue:
 - Build error occurred in case CONFIG_SUSPEND is disable, thanks for 
 report from Geert-san.
 This error caused by CPUIdle patches, which are prerequisite of this 
 patch series. I guess Kobayashi-san will fix it in next version of 
 CPUIdle patches.
 
--
v2
 - Use {} for both arms of *if*
 - Append lacked code to set cpucmcr_ca15 in patch 0007

--
Khiem Nguyen (7):
  ARM: shmobile: use common ARMv7 cache disabling code
  ARM: shmobile: use signals from SYSC to wake up from Suspend-to-RAM
  ARM: shmobile: Implement L2 shutdown mode for Suspend-to-RAM
  ARM: shmobile: Backup and restore L2CTLR in Suspend-to-RAM
  ARM: shmobile: Clear External Event Request in system resume
  ARM: shmobile: Do additional settings for L2shutdown mode
  ARM: shmobile: Use separate CPUCMCR addresses for CA15/CA7

 arch/arm/mach-shmobile/common.h       |    4 ++
 arch/arm/mach-shmobile/headsmp.S      |   28 +++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |   82 ++++++++++++++++++++++++---------
 arch/arm/mach-shmobile/pm-rcar.c      |   22 +++++++++
 arch/arm/mach-shmobile/pm-rcar.h      |    1 +
 5 files changed, 116 insertions(+), 21 deletions(-)

-- 
1.7.9.5
