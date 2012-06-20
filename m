From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 08:01:29 +0000
Subject: [PATCH/RFC 00/11] ARM: mach-shmobile: add regulators for mmc and smsc911x
Message-Id: <1340179300-16452-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch-series is a first part in a larger patch set, that aims at 
adding regulator support to all arm/mach-shmobile/ and sh/ boards, using 
mmc (SDHI and MMCIF) or smsc911x ethernet devices.

It is based on yesterday's snapshot of the next branch of Rafael's "renesas"
git-tree, plus these recent patches from Morimoto-san:
http://www.spinics.net/lists/linux-sh/index.html#12061
Note, that some of those patches didn't apply cleanly, I had to merge them 
manually, maybe they are based on a different tree or I was missing some 
additional patches.

The whole set should consist of the following series:

1. add regulators to arm/mach-shmobile/ - these 10 patches
2. add regulators to sh/ - to follow shortly
3. add regulator support to sh_mmcif and tmio_mmc. The former has already 
   been submitted:
http://thread.gmane.org/gmane.linux.kernel.mmc/14967
   and the regulator patch has been reviewed by Mark - thanks. The tmio_mmc 
   part will follow shortly
4. clean up - remove no longer needed .set_pwr() call-backs, OCR mask 
   platform parameters and similar interfaces, made redundant by the use of 
   regulators - to be submitted for future kernel versions

A few notes:

1. Most of these platforms I cannot test, so, any reviews and tests would 
   be appreciated.
2. Some boards currently specify multiple voltages in their OCR masks 
   without any means to switch between them. This means, that to reproduce 
   those set ups we would need a regulator, supporting those voltages, and 
   just returning success, when switching between them, without actually 
   doing anything. Currently I just picked up one of those 2 voltages for 
   each such set up.
3. I also provide a Vccq voltage, which I set = Vdd everywhere.
4. Some platforms actually use a GPIO to enable and disable power supply to 
   SD/MMC cards. For this to work boards have to request respective GPIOs 
   in their initialisation routines. When switching to the fixed regulator, 
   it will also try to request the same GPIOs. To solve this I put 
   gpio_request() calls in platform files in a
#if !config_enabled(REGULATOR_FIXED_VOLTAGE)
	gpio_request();
	gpio_direction_output();
#endif
   block.
5. Patch 10/10 for kzm9g also takes care of the SDHI2 interface, added by
http://article.gmane.org/gmane.linux.ports.sh.devel/15493
   but is also safe to apply without that patch.

Thanks
Guennadi

Guennadi Liakhovetski (11):
  ARM: mach-shmobile: add a temporary macro to define fixed voltage
    regulators
  ARM: mach-shmobile: add 3.3V and 1.8V fixed regulators to mackerel
  ARM: mach-shmobile: add fixed voltage regulators to ag5evm
  ARM: mach-shmobile: add fixed voltage regulators to ap4evb
  ARM: mach-shmobile: add fixed voltage regulators to armadillo800eva
  ARM: mach-shmobile: add fixed voltage regulators to bonito
  ARM: mach-shmobile: add fixed voltage regulators to g4evm
  ARM: mach-shmobile: add fixed voltage regulators to kota2
  ARM: mach-shmobile: add fixed voltage regulators to kzm9d
  ARM: mach-shmobile: add fixed voltage regulators to kzm9g
  ARM: mach-shmobile: add fixed voltage regulators to marzen

 arch/arm/mach-shmobile/board-ag5evm.c           |   66 +++++++++++++++++++++++
 arch/arm/mach-shmobile/board-ap4evb.c           |   31 +++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c  |   16 ++++++
 arch/arm/mach-shmobile/board-bonito.c           |   10 ++++
 arch/arm/mach-shmobile/board-g4evm.c            |   14 +++++
 arch/arm/mach-shmobile/board-kota2.c            |   33 +++++++++++
 arch/arm/mach-shmobile/board-kzm9d.c            |   10 ++++
 arch/arm/mach-shmobile/board-kzm9g.c            |   33 +++++++++++
 arch/arm/mach-shmobile/board-mackerel.c         |   34 ++++++++++++
 arch/arm/mach-shmobile/board-marzen.c           |   10 ++++
 arch/arm/mach-shmobile/include/mach/regulator.h |   34 ++++++++++++
 11 files changed, 291 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/include/mach/regulator.h

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
