From: Rich Felker <dalias@libc.org>
Date: Fri, 11 May 2018 19:02:47 +0000
Subject: [GIT PULL] arch/sh regression fixes for 4.17
Message-Id: <20180511190247.GA18860@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>

Linus,

Please pull these changes for arch/sh. They fix regressions introduced
in 4.15 and 4.17-rc1 that prevent booting on affected systems.

Rich



The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-for-4.17-fixes

for you to fetch changes up to ac21fc2dcb405cf250ad3f1228f64f64930d9211:

  sh: switch to NO_BOOTMEM (2018-05-11 13:35:46 -0400)

----------------------------------------------------------------
Fixes for critical regressions and a build failure.

----------------------------------------------------------------
Jacopo Mondi (1):
      sh: mm: Fix unprotected access to struct device

Rich Felker (1):
      sh: fix build failure for J2 cpu with SMP disabled

Rob Herring (1):
      sh: switch to NO_BOOTMEM

 arch/sh/Kconfig                |  1 +
 arch/sh/kernel/cpu/sh2/probe.c |  4 +++
 arch/sh/kernel/setup.c         |  1 -
 arch/sh/mm/consistent.c        | 11 +++++--
 arch/sh/mm/init.c              | 68 ++++--------------------------------------
 arch/sh/mm/numa.c              | 19 ------------
 6 files changed, 19 insertions(+), 85 deletions(-)
