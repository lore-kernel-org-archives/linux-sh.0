From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 15:12:08 +0000
Subject: [PATCH 00/14] sh: add regulators for mmc and smsc911x
Message-Id: <1340205142-32606-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series is part two of the set, described in
http://thread.gmane.org/gmane.linux.ports.sh.devel/15544
It adds regulators for mmc devices and for the smsc911x driver to sh 
platforms, similar to how the previous series has done this for
arm/mach-shmobile. The auxiliary macro, added in patch 01/14 is also
going to be dropped, as soon as we switch to using the new 
regulator_register_always_on(), that macro will be dropped.

Thanks
Guennadi

Guennadi Liakhovetski (14):
  sh: add a temporary macro to define fixed voltage regulators
  sh: ecovec: switch MMC power control to regulators
  sh: add fixed voltage regulators to apsh4a3a
  sh: add fixed voltage regulators to apsh4ad0a
  sh: add fixed voltage regulators to magicpanelr2
  sh: add fixed voltage regulators to polaris
  sh: add fixed voltage regulators to sh2007
  sh: add fixed voltage regulators to sh7757lcr
  sh: add fixed voltage regulators to ap325rxa
  sh: add fixed voltage regulators to kfr2r09
  sh: add fixed voltage regulators to migor
  sh: add fixed voltage regulators to rsk
  sh: add fixed voltage regulators to sdk7786
  sh: add fixed voltage regulators to se7724

 arch/sh/boards/board-apsh4a3a.c              |   10 ++++
 arch/sh/boards/board-apsh4ad0a.c             |   10 ++++
 arch/sh/boards/board-magicpanelr2.c          |   10 ++++
 arch/sh/boards/board-polaris.c               |   10 ++++
 arch/sh/boards/board-sh2007.c                |   12 ++++
 arch/sh/boards/board-sh7757lcr.c             |   14 +++++
 arch/sh/boards/mach-ap325rxa/setup.c         |   23 ++++++++
 arch/sh/boards/mach-ecovec24/setup.c         |   73 ++++++++++++++++++++++++++
 arch/sh/boards/mach-kfr2r09/setup.c          |   12 ++++
 arch/sh/boards/mach-migor/setup.c            |   12 ++++
 arch/sh/boards/mach-rsk/setup.c              |   10 ++++
 arch/sh/boards/mach-sdk7786/setup.c          |   10 ++++
 arch/sh/boards/mach-se/7724/setup.c          |   14 +++++
 arch/sh/include/mach-common/mach/regulator.h |   34 ++++++++++++
 14 files changed, 254 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/include/mach-common/mach/regulator.h

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
