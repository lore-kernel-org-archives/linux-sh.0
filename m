From: Rich Felker <dalias@libc.org>
Date: Wed, 13 Apr 2016 01:45:57 +0000
Subject: [GIT PULL] arch/sh fixes for regressions in 4.6-rc1
Message-Id: <20160413014557.GA18973@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

Linus,

Please pull these changes (regression fixes only) for arch/sh. They're
based on 4.6-rc1 when I did them, but apply cleanly to 4.6-rc3 and
build successfully.

Rich



The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-fixes-4.6-rc1

for you to fetch changes up to ccc7d5a1cdae78ccd623540dc87e281135a1c053:

  sh: fix function signature of cpu_coregroup_mask to match pointer type (2016-03-30 00:47:49 +0000)

----------------------------------------------------------------
Fixes for two arch/sh build regressions that appeared in 4.6-rc1, one
introduced by me, and one caused by changes elsewhere.

----------------------------------------------------------------
Rich Felker (3):
      Merge tag 'v4.6-rc1'
      sh: fix smp-shx3 build regression from removal of arch localtimer
      sh: fix function signature of cpu_coregroup_mask to match pointer type

 arch/sh/include/asm/smp.h          | 5 -----
 arch/sh/include/asm/topology.h     | 2 +-
 arch/sh/kernel/cpu/sh4a/smp-shx3.c | 2 --
 arch/sh/kernel/topology.c          | 4 ++--
 4 files changed, 3 insertions(+), 10 deletions(-)
