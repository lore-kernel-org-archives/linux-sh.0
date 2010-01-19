From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 19 Jan 2010 08:05:09 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc5, part 2.
Message-Id: <20100119080509.GD16013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

A few more minor changes, primarily addressing the recvmmsg/accept4 mess.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Kuninori Morimoto (1):
      sh: ms7724: Correct sh-eth EEPROM polling timeout.

Paul Mundt (2):
      sh: unwire sys_recvmmsg.
      sh64: wire up sys_accept4.

 arch/sh/boards/mach-se/7724/setup.c |    2 +-
 arch/sh/include/asm/unistd_32.h     |    5 +++--
 arch/sh/include/asm/unistd_64.h     |    3 ++-
 arch/sh/kernel/syscalls_32.S        |    1 -
 arch/sh/kernel/syscalls_64.S        |    1 +
 5 files changed, 7 insertions(+), 5 deletions(-)
