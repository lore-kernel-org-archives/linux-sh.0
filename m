From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:20 +0000
Subject: [PATCH 00/14] Dynamic PMB support
Message-Id: <cover.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

this patch series resurrects dynamic PMB support. Support isn't quite
finished yet, for example even though the MMU will run in 32bit mode
there's still not support for mapping the entire 512MB SDRAM that is
available on my sh7785lcr board, but I'm expecting to have that sorted
by the end of the week. These patches are mainly to make sure that I
haven't broken anything and people's machines still boot.

What I'd appreciate is for anyone with an SH4A board to try out these
patches. The MMU should be switched to 32bit mode seemlessly on boot if
you build your kernel with CONFIG_PMB. Also, if people with sh7785lcr
boards that have pmb support in the bootloader can try this patches with
CONFIG_PMB_FIXED, just to ensure I haven't screwed anything up when
merging pmb-fixed. and pmb.c.

If you prefer git trees, these patches are available at,

   git://github.com/mfleming/linux-2.6.git sh/pmb-dynamic

but please note that the sh/pmb-dynamic branch may be rebased.

Paul, I've tried to separate out the commits as much as possible so that
you can ACK/NACK in a more fine-grained way. If you'd prefer for me to
squash some of the patches, just shout.

Matt Fleming (14):
  sh: Sprinkle __uses_jump_to_uncached
  sh: Plug PMB alloc memory leak
  sh: Allocate PMB entry slot earlier
  sh: Obliterate the P1 area macros
  sh: Prepare for dynamic PMB support
  sh: CONFIG_PMB doesn't mean the MMU is in 32bit mode
  sh: Try PMB mapping based on physical address, not mapping size
  sh: Make most PMB functions static
  sh: Get rid of the kmem cache code
  sh: Remap physical memory into P1 and P2 in pmb_init()
  sh: Use page_to_phys() to get the physical address of a page
  sh: Fix the offset from P1SEG/P2SEG where we map RAM
  sh: Fold fixed-PMB support into dynamic PMB support
  sh: Don't allocate smaller sized mappings on every iteration

 arch/sh/boot/compressed/misc.c    |    2 +-
 arch/sh/include/asm/addrspace.h   |    9 +-
 arch/sh/include/asm/io.h          |    4 +-
 arch/sh/include/asm/mmu.h         |   13 +-
 arch/sh/include/asm/pgtable.h     |   26 +++-
 arch/sh/include/asm/pgtable_32.h  |    2 +-
 arch/sh/include/asm/scatterlist.h |    2 +-
 arch/sh/kernel/head_32.S          |    2 +-
 arch/sh/kernel/machine_kexec.c    |    2 +-
 arch/sh/kernel/setup.c            |    4 +
 arch/sh/mm/Kconfig                |    2 -
 arch/sh/mm/Makefile               |    3 +-
 arch/sh/mm/cache-sh4.c            |   12 +-
 arch/sh/mm/cache-sh7705.c         |    6 +-
 arch/sh/mm/consistent.c           |    2 +-
 arch/sh/mm/init.c                 |    8 +
 arch/sh/mm/ioremap_32.c           |    2 +-
 arch/sh/mm/pmb-fixed.c            |   45 ------
 arch/sh/mm/pmb.c                  |  295 ++++++++++++++++++++-----------------
 19 files changed, 224 insertions(+), 217 deletions(-)
 delete mode 100644 arch/sh/mm/pmb-fixed.c

