From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 10 Apr 2012 13:00:49 +0000
Subject: [PATCH 0/4] sh: Add sh7264 device and RSK2+SH7264 board
Message-Id: <1334062853-23045-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add the sh7264 device (sh2a) and the RSK2+SH7264 board.

Phil Edworthy (4):
  sh: Add support for 8-bit module stop registers
  sh: Add sh7264 device
  sh: Add RSK2+SH7264 board
  sh: Add pinmux for sh7264

 arch/sh/Kconfig                           |    8 +
 arch/sh/boards/Kconfig                    |    2 +-
 arch/sh/boards/mach-rsk/Kconfig           |    5 +
 arch/sh/boards/mach-rsk/Makefile          |    1 +
 arch/sh/boards/mach-rsk/devices-rsk7264.c |   58 +
 arch/sh/configs/rsk7264_defconfig         |   80 ++
 arch/sh/include/asm/processor.h           |    2 +-
 arch/sh/include/cpu-sh2a/cpu/sh7264.h     |  176 +++
 arch/sh/kernel/cpu/proc.c                 |    1 +
 arch/sh/kernel/cpu/sh2a/Makefile          |    2 +
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c    |  184 +++
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c   | 2136 +++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/probe.c           |    3 +
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c    |  606 ++++++++
 arch/sh/tools/mach-types                  |    1 +
 drivers/sh/clk/cpg.c                      |   34 +
 include/linux/sh_clk.h                    |    1 +
 17 files changed, 3298 insertions(+), 2 deletions(-)
 create mode 100644 arch/sh/boards/mach-rsk/devices-rsk7264.c
 create mode 100644 arch/sh/configs/rsk7264_defconfig
 create mode 100644 arch/sh/include/cpu-sh2a/cpu/sh7264.h
 create mode 100644 arch/sh/kernel/cpu/sh2a/clock-sh7264.c
 create mode 100644 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
 create mode 100644 arch/sh/kernel/cpu/sh2a/setup-sh7264.c

