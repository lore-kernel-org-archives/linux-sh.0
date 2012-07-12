From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jul 2012 04:26:46 +0000
Subject: [GIT PULL] sh fixes for 3.5-rc7
Message-Id: <20120712042646.GC16064@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit ca24a145573124732152daff105ba68cc9a2b545:

  Merge branch 'fixes' of git://git.linaro.org/people/rmk/linux-arm (2012-07-01 11:02:25 -0700)

are available in the git repository at:


  git://github.com/pmundt/linux-sh.git tags/sh-for-linus

for you to fetch changes up to 44033109e99cf584d6285226ed521098f5ef7250:

  SH: Convert out[bwl] macros to inline functions (2012-07-12 13:12:13 +0900)

----------------------------------------------------------------
SuperH fixes for 3.5-rc7

----------------------------------------------------------------
Corey Minyard (1):
      SH: Convert out[bwl] macros to inline functions

Paul Mundt (1):
      sh: Fix up se7721 GPIOLIB=y build warnings.

 arch/sh/include/asm/io_noioport.h      | 17 ++++++++++++++---
 arch/sh/kernel/cpu/sh3/serial-sh7720.c |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)
