From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Fri, 19 Nov 2010 04:06:56 +0000
Subject: [PATCH 0/2] GPIO support for sh73a0/ag5evm
Message-Id: <20101119130656.8b8a50b9.takashi.yoshii.zj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches add GPIO/Pin-multiplex support to sh73a0 CPU and ag5evm board.
A few of them have been tested to work by using keysc, LEDs, switches and others.
Most of others have been checked only by eyes, comparing with hardware manual.
This system seems to be too big to do full test, sorry.

Takashi YOSHII (2):
  ARM: mach-shmobile: Add sh73a0 pinmux support
  ARM: mach-shmobile: ag5evm: use gpio.

 arch/arm/mach-shmobile/Kconfig               |    2 +
 arch/arm/mach-shmobile/Makefile              |    1 +
 arch/arm/mach-shmobile/board-ag5evm.c        |   17 +-
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 arch/arm/mach-shmobile/include/mach/sh73a0.h |  442 +++++-
 arch/arm/mach-shmobile/pfc-sh73a0.c          | 2679 ++++++++++++++++++++++++++
 6 files changed, 3134 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pfc-sh73a0.c

-- 
1.7.2.2
