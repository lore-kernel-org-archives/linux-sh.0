From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Apr 2009 08:17:28 +0000
Subject: [GIT PULL] sh updates for 2.6.30-rc4
Message-Id: <20090427081727.GC26020@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.30

Which contains:

Adrian McMenamin (1):
      maple: input: fix up maple mouse driver

Paul Mundt (1):
      sh: Fix up unsigned syscall_nr in SH-5 pt_regs.

Yoshihiro Shimoda (1):
      sh: sh7785lcr: fix defconfig for 29-bit mode

 arch/sh/configs/sh7785lcr_defconfig |   57 ++++++++++++++++++++++------------
 arch/sh/include/asm/ptrace.h        |    2 +-
 drivers/input/mouse/maplemouse.c    |   43 ++++++++++++++------------
 3 files changed, 61 insertions(+), 41 deletions(-)
