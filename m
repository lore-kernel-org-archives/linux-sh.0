From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Oct 2009 00:23:45 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc6, part 2.
Message-Id: <20091028002345.GB27042@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.32

Which contains:

Lubomir Rintel (1):
      sh: Build fix: define more __movmem* symbols

Magnus Damm (2):
      sh: rsk7203 CONFIG_MTD=n fix
      sh: add uImage.bin target

Matt Fleming (1):
      sh: Check for return_to_handler when unwinding the stack

Paul Mundt (3):
      sh: __irq_entry annotate do_IRQ().
      sh: Document uImage.bin target in archhelp.
      sh: Fix hugetlbfs dependencies for SH-3 && MMU configurations.

 arch/sh/Kconfig                           |    5 +++++
 arch/sh/Makefile                          |    3 ++-
 arch/sh/boards/mach-rsk/devices-rsk7203.c |    4 ----
 arch/sh/boards/mach-rsk/setup.c           |   23 ++++++++++++++---------
 arch/sh/boot/Makefile                     |    6 +++++-
 arch/sh/kernel/dwarf.c                    |   22 ++++++++++++++++++++++
 arch/sh/kernel/irq.c                      |    3 ++-
 arch/sh/kernel/sh_ksyms_32.c              |   14 ++++++++++++++
 arch/sh/mm/Kconfig                        |    2 +-
 fs/Kconfig                                |    4 ++--
 10 files changed, 67 insertions(+), 19 deletions(-)
