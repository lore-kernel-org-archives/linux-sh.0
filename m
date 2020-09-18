From: Rich Felker <dalias@libc.org>
Date: Fri, 18 Sep 2020 17:45:35 +0000
Subject: [GIT PULL] arch/sh important regression fixes 5.9
Message-Id: <20200918174528.GY3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.9-part2

for you to fetch changes up to b0cfc315ff38c423a5ce9ce159bd5baa4135e688:

  sh: fix syscall tracing (2020-09-13 21:22:55 -0400)

----------------------------------------------------------------
Fixes for build and function regression.

----------------------------------------------------------------
Rich Felker (2):
      sh: remove spurious circular inclusion from asm/smp.h
      sh: fix syscall tracing

 arch/sh/include/asm/smp.h     |  1 -
 arch/sh/kernel/entry-common.S |  1 -
 arch/sh/kernel/ptrace_32.c    | 15 +++++----------
 3 files changed, 5 insertions(+), 12 deletions(-)
