From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 10 May 2012 08:26:51 +0000
Subject: [PATCH 0/3] sh: Add sh7269 device and RSK2+SH7269 board
Message-Id: <1336638414-3251-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add the sh7269 device (sh2a) and the RSK2+SH7269 board.

Phil Edworthy (3):
  sh: Add sh7269 device
  sh: Add RSK2+SH7269 board
  sh: Add pinmux for sh7269

 arch/sh/Kconfig                           |   10 +-
 arch/sh/boards/Kconfig                    |    3 +-
 arch/sh/boards/mach-rsk/Kconfig           |    5 +
 arch/sh/boards/mach-rsk/Makefile          |    1 +
 arch/sh/boards/mach-rsk/devices-rsk7269.c |   60 +
 arch/sh/configs/rsk7269_defconfig         |   65 +
 arch/sh/include/asm/processor.h           |    3 +-
 arch/sh/include/cpu-sh2a/cpu/sh7269.h     |  201 +++
 arch/sh/kernel/cpu/proc.c                 |    2 +-
 arch/sh/kernel/cpu/sh2a/Makefile          |    2 +
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c    |  199 ++
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c   | 2799 +++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/probe.c           |    3 +
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c    |  615 +++++++
 arch/sh/tools/mach-types                  |    1 +
 15 files changed, 3965 insertions(+), 4 deletions(-)
 create mode 100644 arch/sh/boards/mach-rsk/devices-rsk7269.c
 create mode 100644 arch/sh/configs/rsk7269_defconfig
 create mode 100644 arch/sh/include/cpu-sh2a/cpu/sh7269.h
 create mode 100644 arch/sh/kernel/cpu/sh2a/clock-sh7269.c
 create mode 100644 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
 create mode 100644 arch/sh/kernel/cpu/sh2a/setup-sh7269.c

-- 
1.7.5.4

