From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Jun 2012 09:22:13 +0000
Subject: [GIT PULL] sh fixes for 3.5-rc5
Message-Id: <20120628092213.GB28162@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following changes since commit 47b514cd476db2eca066a2ad31501b079d6c9cce:

  Merge tag 'usb-3.5-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2012-06-27 12:54:05 -0700)

are available in the git repository at:


  git://github.com/pmundt/linux-sh.git tags/sh-for-linus

for you to fetch changes up to e9bcd470d814473c31ffc5d09e249396a2196ad4:

  Merge branches 'sh/urgent' and 'sh/trivial' into sh-fixes-for-linus (2012-06-28 16:46:13 +0900)

----------------------------------------------------------------

SuperH fixes for 3.5-rc5

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      sh: kfr2r09: fix compile breakage

Nobuhiro Iwamatsu (1):
      sh: Convert sh_clk_mstp32_register to sh_clk_mstp_register

Paul Mundt (1):
      Merge branches 'sh/urgent' and 'sh/trivial' into sh-fixes-for-linus

 arch/sh/boards/mach-kfr2r09/setup.c    | 4 ++--
 arch/sh/drivers/pci/pcie-sh7786.c      | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c | 2 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   | 2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)
