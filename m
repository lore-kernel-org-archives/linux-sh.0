From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 05 Sep 2008 05:59:12 +0000
Subject: [GIT PULL] sh updates for 2.6.27-rc6
Message-Id: <20080905055912.GB2051@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.27

Which contains:

Adrian Bunk (2):
      sh64: re-add the __strnlen_user() prototype
      sh: fix ptrace_64.c:user_disable_single_step()

Carmelo Amoroso (1):
      sh: resume_kernel fix for kernel oops built with CONFIG_BKL_PREEMPT=y.

Magnus Damm (6):
      sh: crash kernel resource fix
      sh: fix kexec entry point for crash kernels
      sh: fix platform_resource_setup_memory() section mismatch
      sh: update Migo-R defconfig
      sh: update AP325RXA defconfig
      i2c: fix i2c-sh_mobile timing issues

Paul Mundt (1):
      sh64: resume_kernel fix for kernel oops built with CONFIG_BKL_PREEMPT=y.

Yoshihiro Shimoda (1):
      sh: fix semtimedop syscall

 arch/sh/configs/ap325rxa_defconfig |   22 ++--
 arch/sh/configs/migor_defconfig    |   21 ++-
 arch/sh/include/asm/uaccess_64.h   |    2 +
 arch/sh/kernel/cpu/sh5/entry.S     |   14 +--
 arch/sh/kernel/entry-common.S      |   27 +---
 arch/sh/kernel/machine_kexec.c     |    2 +-
 arch/sh/kernel/ptrace_64.c         |    2 +
 arch/sh/kernel/setup.c             |    6 +-
 arch/sh/kernel/sys_sh.c            |    2 +-
 arch/sh/mm/consistent.c            |    6 +-
 drivers/i2c/busses/i2c-sh_mobile.c |  271 +++++++++++++++++++++++++++---------
 11 files changed, 250 insertions(+), 125 deletions(-)
