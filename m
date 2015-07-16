From: Chris Brandt <chris.brandt@renesas.com>
Date: Thu, 16 Jul 2015 14:37:12 +0000
Subject: [PATCH 0/2] ARM: xip: Get XIP for ARMv7 working again
Message-Id: <1437057434-1616-1-git-send-email-chris.brandt@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

While it seems that XIP_KERNEL for ARMv7 is not a popular option, this patchset
is the minimum code fixes needed to get it working which it appears to have
been broken for a couple years.

The current Kconfig architecture prevents you from enabling XIP_KERNEL on many
platforms due to ARCH_MULTIPLATFORM. That will have to be addressed in a later
patchset.


Chris Brandt (2):
  ARM: xip: Can't use text area as stack
  ARM: xip: Use correct symbol for end of ROM marker

 arch/arm/kernel/module.c       |    2 +-
 arch/arm/mm/mmu.c              |    4 ++--
 arch/arm/mm/proc-v7.S          |    4 ++++
 include/asm-generic/sections.h |    2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.7.9.5


