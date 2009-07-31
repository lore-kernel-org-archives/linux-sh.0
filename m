From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:47:05 +0000
Subject: [PATCH 00/09] sh: Runtime PM pdev hwblk
Message-Id: <20090731074705.29009.33769.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: Runtime PM pdev hwblk changes

[PATCH 01/09] sh: Runtime PM pdev hwblk - header change
[PATCH 02/09] sh: Runtime PM pdev hwblk - sh7722
[PATCH 03/09] sh: Runtime PM pdev hwblk - Migo-R
[PATCH 04/09] sh: Runtime PM pdev hwblk - Solution Engine 7722
[PATCH 05/09] sh: Runtime PM pdev hwblk - sh7723
[PATCH 06/09] sh: Runtime PM pdev hwblk - AP325RXA
[PATCH 07/09] sh: Runtime PM pdev hwblk - sh7724
[PATCH 08/09] sh: Runtime PM pdev hwblk - kfr2r09
[PATCH 09/09] sh: Runtime PM pdev hwblk - Solution Engine 7724

These patches extend struct platform device data for a bunch of
SuperH Mobile processors and embedded boards. The patches simply
add hardware block ids to on-chip platform devices. Platform
devices off chip (such as external ethernet controllers or flash
chips) are left out which gives them a special case hardware block
id of zero.

Upcoming Runtime PM code will make use of the hardware block id
to group devices together. The hardware block id can also be used
to extend the SuperH Mobile clock framework implementation.

This series of patches depend on the following:
"Driver Core: Add platform device arch data V3".

The patch above is part of Rafaels for-linux topic branch.
I would however prefer to see this series merged independently
of the Runtime PM patches.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Build tested on all boards. No runtime logic changes.

 arch/sh/boards/board-ap325rxa.c        |    6 ++++
 arch/sh/boards/mach-kfr2r09/setup.c    |    3 ++
 arch/sh/boards/mach-migor/setup.c      |    9 ++++++
 arch/sh/boards/mach-se/7722/setup.c    |    4 ++
 arch/sh/boards/mach-se/7724/setup.c    |   18 +++++++++++++
 arch/sh/include/asm/device.h           |    9 +++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   31 +++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   40 +++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   43 ++++++++++++++++++++++++++++++++
 9 files changed, 162 insertions(+), 1 deletion(-)

