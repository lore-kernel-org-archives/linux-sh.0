From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Mar 2011 08:09:19 +0000
Subject: [GIT PULL] sh updates for 2.6.38-rc8
Message-Id: <20110304080919.GC13621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh-fixes-for-linus

Which contains:

Francesco Virlinzi (1):
      sh: Change __nosave_XXX symbols to long

Nobuhiro Iwamatsu (2):
      sh: sh7750: move machtypes.h to include/generated
      sh: sh7750: Fix incompatible pointer type

Stuart Menefy (2):
      sh: Ensure ST40-300 BogoMIPS value is consistent
      sh: Flush executable pages in copy_user_highpage

 arch/sh/include/asm/sections.h        |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |   13 +++++++++----
 arch/sh/lib/delay.c                   |   10 ++++++++++
 arch/sh/mm/cache.c                    |    3 ++-
 4 files changed, 22 insertions(+), 6 deletions(-)
