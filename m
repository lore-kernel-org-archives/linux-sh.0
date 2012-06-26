From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:49:56 +0000
Subject: [PATCH 00/13 v2] sh: add regulators for mmc and smsc911x
Message-Id: <1340751009-18663-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a respin of

http://thread.gmane.org/gmane.linux.ports.sh.devel/15568

ported on top of the fixed regulator driver update patches from the

http://lkml.indiana.edu/hypermail/linux/kernel/1206.2/index.html#01395

patch-set, which thereby becomes a prerequisite for this series! Basing on 
top of those patches made the temporary macro redundant, which simplifies 
the whole work quite a bit. Other changes since v2 are listed in respective 
patches.

DEPENDENCY: the above fixed regulator patches can be obtained from

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed

Thanks
Guennadi

Guennadi Liakhovetski (13):
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

 arch/sh/boards/board-apsh4a3a.c      |   10 +++
 arch/sh/boards/board-apsh4ad0a.c     |   10 +++
 arch/sh/boards/board-magicpanelr2.c  |   10 +++
 arch/sh/boards/board-polaris.c       |   10 +++
 arch/sh/boards/board-sh2007.c        |   12 ++++
 arch/sh/boards/board-sh7757lcr.c     |   14 ++++
 arch/sh/boards/mach-ap325rxa/setup.c |   21 ++++++
 arch/sh/boards/mach-ecovec24/setup.c |  116 +++++++++++++++++++++++++++++-----
 arch/sh/boards/mach-kfr2r09/setup.c  |   12 ++++
 arch/sh/boards/mach-migor/setup.c    |   13 ++++
 arch/sh/boards/mach-rsk/setup.c      |   10 +++
 arch/sh/boards/mach-sdk7786/setup.c  |   10 +++
 arch/sh/boards/mach-se/7724/setup.c  |   15 +++++
 13 files changed, 247 insertions(+), 16 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
