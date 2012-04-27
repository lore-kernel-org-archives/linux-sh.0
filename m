From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 27 Apr 2012 02:10:31 +0000
Subject: [GIT PULL] sh fixes for 3.4-rc5
Message-Id: <20120427021031.GB7988@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 82b769063598d01a8b24abf250a53f8b437e09f1:

  Merge branch 'stable' of git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile (2012-04-26 15:36:27 -0700)

are available in the git repository at:

  git://github.com/pmundt/linux-sh.git sh-for-linus

Nobuhiro Iwamatsu (1):
      sh: Fix up tracepoint build fallout from static key introduction.

Paul Mundt (2):
      Merge branch 'sh/st-integration' into sh/urgent
      Merge branch 'sh/urgent' into sh-fixes-for-linus

Stuart Menefy (1):
      sh: Fix error synchronising kernel page tables

 arch/sh/include/asm/atomic.h |    2 +-
 arch/sh/mm/fault_32.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
