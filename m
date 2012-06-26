From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 26 Jun 2012 22:32:22 +0000
Subject: [PATCH 00/10 v3] ARM: mach-shmobile: add regulators for mmc and smsc911x
Message-Id: <1340749952-8534-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This is a respin of

http://thread.gmane.org/gmane.linux.ports.sh.devel/15544

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

Guennadi Liakhovetski (10):
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

 arch/arm/mach-shmobile/board-ag5evm.c          |   83 +++++++++++++++++++++++-
 arch/arm/mach-shmobile/board-ap4evb.c          |   29 ++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |   16 +++++
 arch/arm/mach-shmobile/board-bonito.c          |   10 +++
 arch/arm/mach-shmobile/board-g4evm.c           |   14 ++++
 arch/arm/mach-shmobile/board-kota2.c           |   30 +++++++++
 arch/arm/mach-shmobile/board-kzm9d.c           |   10 +++
 arch/arm/mach-shmobile/board-kzm9g.c           |   28 ++++++++
 arch/arm/mach-shmobile/board-mackerel.c        |   35 ++++++++++
 arch/arm/mach-shmobile/board-marzen.c          |   10 +++
 10 files changed, 262 insertions(+), 3 deletions(-)

-- 
1.7.2.5

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
