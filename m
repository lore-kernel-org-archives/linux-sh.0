From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 12 Mar 2012 06:34:33 +0000
Subject: [GIT PULL] sh fixes for 3.3-rc8
Message-Id: <20120312063433.GA5767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 55062d061790b43aee01ab3f9ac57b8596254f19:

  x86: fix typo in recent find_vma_prev purge (2012-03-06 18:48:13 -0800)

are available in the git repository at:
  git://github.com/pmundt/linux-sh.git sh-for-linus

Phil Edworthy (1):
      sh: Fix sh2a vbr table for more than 255 irqs

Rafael J. Wysocki (1):
      sh-sci / PM: Avoid deadlocking runtime PM

Shimoda, Yoshihiro (1):
      sh: add parameter for RSPI in clock-sh7757

Thomas Schwinge (1):
      sh: fix up the ubc clock definition for sh7785.

 arch/sh/kernel/cpu/sh2a/ex.S           |    1 +
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    4 +++-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 drivers/tty/serial/sh-sci.c            |    5 +++++
 4 files changed, 10 insertions(+), 2 deletions(-)
