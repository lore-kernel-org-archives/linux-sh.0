From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 06 Jan 2011 15:19:26 +0000
Subject: [GIT PULL] sh updates for 2.6.38-rc1
Message-Id: <20110106151926.GA19310@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-latest

Which contains:

Magnus Damm (1):
      sh: include Migo-R TS driver in Migo-R defconfig

Paul Mundt (8):
      sh: machvec IO death.
      sh: migrate SH_CLK_MD to mode pin API.
      sh: Enable optional gpiolib for all CPUs with pinmux tables.
      sh: Break out cpuinfo_op procfs bits.
      sh: mach-rsk: Add polled GPIO buttons support for RSK+7203.
      sh: mach-sdk7786: Handle baseboard NMI source selection.
      dma: shdma: NMI support.
      sh: Tidy up SH-4A unaligned load support.

Roel Kluin (1):
      sh: correct definitions to access stack pointers

 arch/sh/Kconfig                           |   20 +-
 arch/sh/boards/board-secureedge5410.c     |    2 -
 arch/sh/boards/mach-rsk/devices-rsk7203.c |   37 +++-
 arch/sh/boards/mach-sdk7786/Makefile      |    2 +-
 arch/sh/boards/mach-sdk7786/nmi.c         |   83 +++++++
 arch/sh/boards/mach-sdk7786/setup.c       |    1 +
 arch/sh/boards/mach-se/7206/setup.c       |    6 +
 arch/sh/boards/mach-se/board-se7619.c     |    6 +
 arch/sh/configs/migor_defconfig           |    2 +
 arch/sh/drivers/pci/pci.c                 |    3 +-
 arch/sh/include/asm/io.h                  |  345 +++++++++++++++--------------
 arch/sh/include/asm/io_generic.h          |   25 --
 arch/sh/include/asm/machvec.h             |   21 --
 arch/sh/include/asm/ptrace.h              |    4 +-
 arch/sh/include/asm/ptrace_32.h           |    2 +-
 arch/sh/include/asm/ptrace_64.h           |    2 +-
 arch/sh/include/asm/unaligned-sh4a.h      |  164 +++++----------
 arch/sh/include/mach-sdk7786/mach/fpga.h  |    8 +
 arch/sh/kernel/Makefile                   |    6 +-
 arch/sh/kernel/cpu/Makefile               |    2 +-
 arch/sh/kernel/cpu/proc.c                 |  148 ++++++++++++
 arch/sh/kernel/cpu/sh2/clock-sh7619.c     |   22 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c    |   20 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c    |   21 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c    |   20 +-
 arch/sh/kernel/io_generic.c               |  180 ---------------
 arch/sh/kernel/iomap.c                    |  165 ++++++++++++++
 arch/sh/kernel/ioport.c                   |   43 ++++
 arch/sh/kernel/machvec.c                  |   22 --
 arch/sh/kernel/setup.c                    |  144 ------------
 drivers/dma/shdma.c                       |  132 ++++++++++--
 drivers/dma/shdma.h                       |    1 +
 32 files changed, 907 insertions(+), 752 deletions(-)
 create mode 100644 arch/sh/boards/mach-sdk7786/nmi.c
 create mode 100644 arch/sh/kernel/cpu/proc.c
 delete mode 100644 arch/sh/kernel/io_generic.c
 create mode 100644 arch/sh/kernel/iomap.c
 create mode 100644 arch/sh/kernel/ioport.c
