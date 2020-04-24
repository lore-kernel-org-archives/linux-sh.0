From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 24 Apr 2020 22:19:47 +0000
Subject: [GIT PULL] sh: remove sh5 support
Message-Id: <20200424221948.1120587-1-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>

The following changes since commit
ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/sh5-remove

for you to fetch changes up to 29e36fbee3be4c13ff6881a275c86d5f68acfa23:

  sh: remove sh5 support (2020-04-24 22:20:55 +0200)

----------------------------------------------------------------
sh: remove sh5 support

At long last, this is the removal of the 64-bit sh5 port
that never went into production.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------

v2: I should have fixed all the missing changes that Geert pointed out,
    this time sending it as a pull request as the removal patch is
    too big for the mailing lists, and a 'git format-patch -D' patch
    is unreliable

Arnd Bergmann (1):
  sh: remove sh5 support

 arch/sh/Kconfig                           |   62 +-
 arch/sh/Kconfig.cpu                       |    9 -
 arch/sh/Kconfig.debug                     |   13 +-
 arch/sh/Makefile                          |   29 +-
 arch/sh/boot/compressed/Makefile          |   12 +-
 arch/sh/boot/compressed/misc.c            |    8 -
 arch/sh/drivers/pci/Makefile              |    1 -
 arch/sh/drivers/pci/ops-sh5.c             |   65 -
 arch/sh/drivers/pci/pci-sh5.c             |  217 ---
 arch/sh/drivers/pci/pci-sh5.h             |  108 --
 arch/sh/include/asm/barrier.h             |    4 +-
 arch/sh/include/asm/bitops.h              |   26 -
 arch/sh/include/asm/bl_bit.h              |   11 +-
 arch/sh/include/asm/bl_bit_64.h           |   37 -
 arch/sh/include/asm/bugs.h                |    4 -
 arch/sh/include/asm/cache_insns.h         |   12 +-
 arch/sh/include/asm/cache_insns_64.h      |   20 -
 arch/sh/include/asm/checksum.h            |    6 +-
 arch/sh/include/asm/elf.h                 |   23 -
 arch/sh/include/asm/extable.h             |    4 -
 arch/sh/include/asm/fixmap.h              |    4 -
 arch/sh/include/asm/io.h                  |    4 -
 arch/sh/include/asm/irq.h                 |    3 -
 arch/sh/include/asm/mmu_context.h         |   12 -
 arch/sh/include/asm/mmu_context_64.h      |   75 -
 arch/sh/include/asm/module.h              |    4 -
 arch/sh/include/asm/page.h                |   21 +-
 arch/sh/include/asm/pgtable.h             |   17 -
 arch/sh/include/asm/pgtable_64.h          |  307 ----
 arch/sh/include/asm/posix_types.h         |    6 +-
 arch/sh/include/asm/processor.h           |   14 +-
 arch/sh/include/asm/processor_64.h        |  212 ---
 arch/sh/include/asm/ptrace_64.h           |   14 -
 arch/sh/include/asm/string.h              |    6 +-
 arch/sh/include/asm/string_64.h           |   21 -
 arch/sh/include/asm/switch_to.h           |   11 +-
 arch/sh/include/asm/switch_to_64.h        |   32 -
 arch/sh/include/asm/syscall.h             |    6 +-
 arch/sh/include/asm/syscall_64.h          |   75 -
 arch/sh/include/asm/syscalls.h            |    9 +-
 arch/sh/include/asm/syscalls_64.h         |   18 -
 arch/sh/include/asm/thread_info.h         |    4 +-
 arch/sh/include/asm/tlb.h                 |    6 +-
 arch/sh/include/asm/tlb_64.h              |   68 -
 arch/sh/include/asm/traps.h               |    4 -
 arch/sh/include/asm/traps_64.h            |   35 -
 arch/sh/include/asm/types.h               |    5 -
 arch/sh/include/asm/uaccess.h             |    4 -
 arch/sh/include/asm/uaccess_64.h          |   85 -
 arch/sh/include/asm/unistd.h              |    6 +-
 arch/sh/include/asm/user.h                |    7 -
 arch/sh/include/asm/vmlinux.lds.h         |    8 -
 arch/sh/include/cpu-sh5/cpu/addrspace.h   |   12 -
 arch/sh/include/cpu-sh5/cpu/cache.h       |   94 -
 arch/sh/include/cpu-sh5/cpu/irq.h         |  113 --
 arch/sh/include/cpu-sh5/cpu/mmu_context.h |   22 -
 arch/sh/include/cpu-sh5/cpu/registers.h   |  103 --
 arch/sh/include/cpu-sh5/cpu/rtc.h         |    9 -
 arch/sh/include/uapi/asm/posix_types.h    |    8 +-
 arch/sh/include/uapi/asm/posix_types_64.h |   29 -
 arch/sh/include/uapi/asm/ptrace.h         |    5 -
 arch/sh/include/uapi/asm/ptrace_64.h      |   15 -
 arch/sh/include/uapi/asm/sigcontext.h     |   13 -
 arch/sh/include/uapi/asm/stat.h           |   61 -
 arch/sh/include/uapi/asm/swab.h           |   10 -
 arch/sh/include/uapi/asm/unistd.h         |    8 +-
 arch/sh/include/uapi/asm/unistd_64.h      |  423 -----
 arch/sh/kernel/Makefile                   |   16 +-
 arch/sh/kernel/cpu/Makefile               |    1 -
 arch/sh/kernel/cpu/init.c                 |    2 +-
 arch/sh/kernel/cpu/irq/Makefile           |    3 +-
 arch/sh/kernel/cpu/irq/intc-sh5.c         |  194 --
 arch/sh/kernel/cpu/proc.c                 |    1 -
 arch/sh/kernel/cpu/sh5/Makefile           |   16 -
 arch/sh/kernel/cpu/sh5/clock-sh5.c        |   76 -
 arch/sh/kernel/cpu/sh5/entry.S            | 2000 ---------------------
 arch/sh/kernel/cpu/sh5/fpu.c              |  106 --
 arch/sh/kernel/cpu/sh5/probe.c            |   72 -
 arch/sh/kernel/cpu/sh5/setup-sh5.c        |  121 --
 arch/sh/kernel/cpu/sh5/switchto.S         |  195 --
 arch/sh/kernel/cpu/sh5/unwind.c           |  342 ----
 arch/sh/kernel/head_64.S                  |  346 ----
 arch/sh/kernel/irq_64.c                   |   48 -
 arch/sh/kernel/module.c                   |    9 -
 arch/sh/kernel/process.c                  |    2 -
 arch/sh/kernel/process_64.c               |  461 -----
 arch/sh/kernel/ptrace_64.c                |  576 ------
 arch/sh/kernel/reboot.c                   |    6 -
 arch/sh/kernel/sh_ksyms_64.c              |   51 -
 arch/sh/kernel/signal_64.c                |  567 ------
 arch/sh/kernel/syscalls_64.S              |  419 -----
 arch/sh/kernel/traps_64.c                 |  814 ---------
 arch/sh/kernel/vmlinux.lds.S              |   18 +-
 arch/sh/lib64/Makefile                    |   17 -
 arch/sh/lib64/copy_page.S                 |   89 -
 arch/sh/lib64/copy_user_memcpy.S          |  218 ---
 arch/sh/lib64/memcpy.S                    |  202 ---
 arch/sh/lib64/memset.S                    |   92 -
 arch/sh/lib64/panic.c                     |   15 -
 arch/sh/lib64/sdivsi3.S                   |  136 --
 arch/sh/lib64/strcpy.S                    |   98 -
 arch/sh/lib64/strlen.S                    |   34 -
 arch/sh/lib64/udelay.c                    |   49 -
 arch/sh/lib64/udivdi3.S                   |  121 --
 arch/sh/lib64/udivsi3.S                   |   60 -
 arch/sh/mm/Kconfig                        |   16 +-
 arch/sh/mm/Makefile                       |   31 +-
 arch/sh/mm/cache-sh5.c                    |  621 -------
 arch/sh/mm/cache.c                        |    6 -
 arch/sh/mm/extable_64.c                   |   84 -
 arch/sh/mm/tlb-sh5.c                      |  224 ---
 arch/sh/mm/tlbex_64.c                     |  166 --
 arch/sh/mm/tlbflush_64.c                  |  172 --
 drivers/rtc/Kconfig                       |    2 +-
 fs/Kconfig.binfmt                         |    2 +-
 scripts/headers_install.sh                |    3 -
 tools/arch/sh/include/asm/barrier.h       |    2 +-
 117 files changed, 67 insertions(+), 11554 deletions(-)
 delete mode 100644 arch/sh/drivers/pci/ops-sh5.c
 delete mode 100644 arch/sh/drivers/pci/pci-sh5.c
 delete mode 100644 arch/sh/drivers/pci/pci-sh5.h
 delete mode 100644 arch/sh/include/asm/bl_bit_64.h
 delete mode 100644 arch/sh/include/asm/cache_insns_64.h
 delete mode 100644 arch/sh/include/asm/mmu_context_64.h
 delete mode 100644 arch/sh/include/asm/pgtable_64.h
 delete mode 100644 arch/sh/include/asm/processor_64.h
 delete mode 100644 arch/sh/include/asm/ptrace_64.h
 delete mode 100644 arch/sh/include/asm/string_64.h
 delete mode 100644 arch/sh/include/asm/switch_to_64.h
 delete mode 100644 arch/sh/include/asm/syscall_64.h
 delete mode 100644 arch/sh/include/asm/syscalls_64.h
 delete mode 100644 arch/sh/include/asm/tlb_64.h
 delete mode 100644 arch/sh/include/asm/traps_64.h
 delete mode 100644 arch/sh/include/asm/uaccess_64.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/addrspace.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/cache.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/irq.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/mmu_context.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/registers.h
 delete mode 100644 arch/sh/include/cpu-sh5/cpu/rtc.h
 delete mode 100644 arch/sh/include/uapi/asm/posix_types_64.h
 delete mode 100644 arch/sh/include/uapi/asm/ptrace_64.h
 delete mode 100644 arch/sh/include/uapi/asm/unistd_64.h
 delete mode 100644 arch/sh/kernel/cpu/irq/intc-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/Makefile
 delete mode 100644 arch/sh/kernel/cpu/sh5/clock-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/entry.S
 delete mode 100644 arch/sh/kernel/cpu/sh5/fpu.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/probe.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/setup-sh5.c
 delete mode 100644 arch/sh/kernel/cpu/sh5/switchto.S
 delete mode 100644 arch/sh/kernel/cpu/sh5/unwind.c
 delete mode 100644 arch/sh/kernel/head_64.S
 delete mode 100644 arch/sh/kernel/irq_64.c
 delete mode 100644 arch/sh/kernel/process_64.c
 delete mode 100644 arch/sh/kernel/ptrace_64.c
 delete mode 100644 arch/sh/kernel/sh_ksyms_64.c
 delete mode 100644 arch/sh/kernel/signal_64.c
 delete mode 100644 arch/sh/kernel/syscalls_64.S
 delete mode 100644 arch/sh/kernel/traps_64.c
 delete mode 100644 arch/sh/lib64/Makefile
 delete mode 100644 arch/sh/lib64/copy_page.S
 delete mode 100644 arch/sh/lib64/copy_user_memcpy.S
 delete mode 100644 arch/sh/lib64/memcpy.S
 delete mode 100644 arch/sh/lib64/memset.S
 delete mode 100644 arch/sh/lib64/panic.c
 delete mode 100644 arch/sh/lib64/sdivsi3.S
 delete mode 100644 arch/sh/lib64/strcpy.S
 delete mode 100644 arch/sh/lib64/strlen.S
 delete mode 100644 arch/sh/lib64/udelay.c
 delete mode 100644 arch/sh/lib64/udivdi3.S
 delete mode 100644 arch/sh/lib64/udivsi3.S
 delete mode 100644 arch/sh/mm/cache-sh5.c
 delete mode 100644 arch/sh/mm/extable_64.c
 delete mode 100644 arch/sh/mm/tlb-sh5.c
 delete mode 100644 arch/sh/mm/tlbex_64.c
 delete mode 100644 arch/sh/mm/tlbflush_64.c

-- 
2.26.0
