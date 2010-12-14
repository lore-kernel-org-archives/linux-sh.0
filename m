From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 10:05:47 +0000
Subject: [GIT PULL] sh updates for 2.6.37-rc6
Message-Id: <20101214100547.GH14606@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Not much of note here. A missing syscall for non-multiplexed socketcalls,
and we've temporarily re-enabled the deprecated IRQ chip APIs to give the
MFD and GPIO drivers a chance to catch up in .38 as requested by Mark Brown.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Carmelo AMOROSO (1):
      sh: wire up accept4 syscall (non-multiplexed path)

Paul Mundt (1):
      sh: Enable deprecated IRQ chip APIs for MFD and GPIOLIB drivers.

 arch/sh/Kconfig                 |    3 ++-
 arch/sh/include/asm/unistd_32.h |    3 ++-
 arch/sh/kernel/syscalls_32.S    |    1 +
 3 files changed, 5 insertions(+), 2 deletions(-)
