From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:15:49 +0000
Subject: [PATCH 00/08] sh: Physically contiguous memory reservation rework
Message-Id: <20110106101549.1617.28207.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: Physically contiguous memory reservation rework

[PATCH 01/08] sh: Add new memblock reservation code for mem_init
[PATCH 02/08] sh: Convert sh7366 to mem_init
[PATCH 03/08] sh: Convert sh7343 and se7343 to mem_init
[PATCH 04/08] sh: Convert sh7722, Migo-R and se7722 to mem_init
[PATCH 05/08] sh: Convert sh7723 and AP325RXA to mem_init
[PATCH 06/08] sh: Convert sh7724, Ecovec, se7724 and kfr2r09 to mem_init
[PATCH 07/08] sh: Remove old physically contiguous reservation code
[PATCH 08/08] sh: Move new memblock reservation code to drivers/sh

These patches convert the SH-Mobile processors in the SH architecture
to make use of memblock for physically contiguous memory reservation.

With these patches applied the physically contiguous memory is excluded
from the system memory - this can be determined by /proc/iomem contents.

Excluding the physically contiguous memory from main system memory is
not a requirement for the SH architecture, but after converting the SH
side we can easily tie in the same implementation for ARM where this
is a hardware requirement.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Compile time tested for all SH-Mobile processors.
 Runtime tested on sh7724 and Ecovec using mplayer (VEU over UIO).

 arch/sh/boards/mach-ap325rxa/setup.c   |    9 +-
 arch/sh/boards/mach-ecovec24/setup.c   |   10 ++
 arch/sh/boards/mach-kfr2r09/setup.c    |    9 +-
 arch/sh/boards/mach-migor/setup.c      |    9 +-
 arch/sh/boards/mach-se/7343/setup.c    |    2 
 arch/sh/boards/mach-se/7722/setup.c    |    1 
 arch/sh/boards/mach-se/7724/setup.c    |   10 ++
 arch/sh/include/asm/device.h           |    4 -
 arch/sh/include/cpu-sh4/cpu/sh7343.h   |    6 +
 arch/sh/include/cpu-sh4/cpu/sh7366.h   |    6 +
 arch/sh/include/cpu-sh4/cpu/sh7722.h   |    2 
 arch/sh/include/cpu-sh4/cpu/sh7723.h   |    2 
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    2 
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   13 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   13 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   12 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   12 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   18 ++--
 arch/sh/mm/consistent.c                |  126 ++++++++------------------------
 drivers/sh/Makefile                    |    1 
 drivers/sh/memchunk.c                  |   78 +++++++++++++++++++
 21 files changed, 219 insertions(+), 126 deletions(-)
