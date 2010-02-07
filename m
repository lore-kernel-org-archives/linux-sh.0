From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 07 Feb 2010 19:22:14 +0000
Subject: [GIT PULL] DWARF unwinder updates for 2.6.34
Message-Id: <m3bpg0onq1.fsf@phlog.console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Paul,

I've got a bunch of DWARF unwinder patches in my tree. There are 3 bug
fixes but I'm guessing -rc7 is too late in the game for applying them?
I'm assuming that they will fix the issues you were seeing on qemu but I
haven't been able to test qemu recently so I'm not sure.

The following changes since commit 93e2b9ece0c619ff69d110df28594439882c7737:
  Paul Mundt (1):
        sh: Fix up large system memory handling for SH7780 PCI.

are available in the git repository at:

  git://github.com/mfleming/linux-2.6.git sh/dwarf-unwinder

Matt Fleming (5):
      sh: Correct the offset of the return address in ret_from_exception
      sh: Setup frame pointer in handle_exception path
      sh: Don't continue unwinding across interrupts
      sh: Remove superfluous setup_frame_reg call
      sh: Optimise FDE/CIE lookup by using red-black trees

 arch/sh/include/asm/dwarf.h    |   19 ++---
 arch/sh/include/asm/module.h   |   17 ++++-
 arch/sh/kernel/cpu/sh3/entry.S |    3 +-
 arch/sh/kernel/dwarf.c         |  194 +++++++++++++++++++++++++++++-----------
 arch/sh/kernel/entry-common.S  |    8 ++-
 5 files changed, 172 insertions(+), 69 deletions(-)
