From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 05 Feb 2009 09:51:31 +0000
Subject: [GIT PULL] sh updates for 2.6.29-rc4
Message-Id: <20090205095131.GA23256@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.29

Which contains:

Carmelo AMOROSO (1):
      sh: fcnvds fix with denormalized numbers on SH-4 FPU.

Christopher SMITH (1):
      sh: Only reserve memory under CONFIG_ZERO_PAGE_OFFSET when it != 0.

Kuninori Morimoto (4):
      sh: mach-migor: Enable ov772x and tw9910 in defconfig.
      sh: ap325rxa: control camera power toggling.
      sh: ap325rxa: Add ov772x support.
      sh: ap325rxa: Enable ov772x in defconfig.

Paul Mundt (1):
      sh: Fix up spurious syscall restarting.

Stuart Menefy (1):
      sh: Handle calling csum_partial with misaligned data

Takashi Yoshii (1):
      sh: Fix up T-bit error handling in SH-4A mutex fastpath.

 arch/sh/boards/board-ap325rxa.c    |   63 ++++++++++++++++++++++++++++++--
 arch/sh/configs/ap325rxa_defconfig |   27 ++++++++++----
 arch/sh/configs/migor_defconfig    |   42 +++++++++++++++++-----
 arch/sh/include/asm/mutex-llsc.h   |   21 +++++------
 arch/sh/include/asm/syscall_32.h   |   22 ++----------
 arch/sh/include/asm/syscall_64.h   |   22 ++----------
 arch/sh/kernel/cpu/sh4/fpu.c       |    2 +-
 arch/sh/kernel/setup.c             |    8 ++--
 arch/sh/kernel/signal_32.c         |    4 +--
 arch/sh/kernel/signal_64.c         |    4 +--
 arch/sh/lib/checksum.S             |   69 ++++++++++++++++++++++++++----------
 11 files changed, 184 insertions(+), 100 deletions(-)
