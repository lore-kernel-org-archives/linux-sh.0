From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 16 May 2014 12:10:11 +0000
Subject: [PATCH 0/5] remove Genmai Reference from Legacy support
Message-Id: <1400242216-20848-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Here is the series to remove Genmai Reference from Legacy support since we now
have CCF in multiplatform. Removal is done very similar to Marzen and the
commit messages are largely from that series. Thanks a lot!

Technically, only the first patch fixes the unbootable Genmai-Reference-with-
Legacy-constellation. The other patches clean up the leftovers. Simon, I think
you know best when to push which patches?

The series has been tested with/without multiplatform on a genmai board. The
branch is based on my r7s-ccf branch and can also be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/r7s-ccf-with-fixup

Thanks,

   Wolfram

Wolfram Sang (5):
  ARM: shmobile: Remove non-multiplatform Genmai reference support
  ARM: shmobile: genmai-reference: Remove legacy clock support
  ARM: shmobile: Sync Genmai DTS with Genmai reference DTS
  ARM: shmobile: Let Genmai multiplatform boot with Genmai DTB
  ARM: shmobile: Remove Genmai reference DTS

 arch/arm/boot/dts/Makefile                      |  3 +-
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 59 -------------------------
 arch/arm/boot/dts/r7s72100-genmai.dts           | 30 ++++++++++++-
 arch/arm/mach-shmobile/Kconfig                  | 11 -----
 arch/arm/mach-shmobile/Makefile                 |  1 -
 arch/arm/mach-shmobile/Makefile.boot            |  1 -
 arch/arm/mach-shmobile/board-genmai-reference.c |  8 +---
 7 files changed, 31 insertions(+), 82 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r7s72100-genmai-reference.dts

-- 
1.9.2

