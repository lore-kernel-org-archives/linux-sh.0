From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 07 Nov 2009 10:55:54 +0000
Subject: [PATCH 0/3] Fixed ioremap
Message-Id: <cover.1257590789.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

this patch series provides and uses a new early ioremap implementation
using fixmaps. ioremap_fixed() is useful when you need to map some
physical address range really early in boot. See PATCH 2/3 for an
example. It's based on x86's early_ioremap().

Paul, as I don't have an sh64 compiler or board I've been unable to test
PATCH 3/3. If you (or anyone else) could give it a go, that'd be
great. Also, it's possible that some of the MMU code that is in
iroemap_fixed.c is SH4/SH4-A specific. I've done the best I could from
code inspection to make sure that it would work on non-SH4 boards, but I
could have missed something, and some SH4 quirks may have slipped in.

Matt Fleming (3):
  sh: Add fixed ioremap support
  sh: Use ioremap_fixmed to map the SM501 DRAM config register
  sh: Use ioremap_fixed() to implement SH-5 ioremap()

 arch/sh/boards/board-sh7785lcr.c |   11 ++-
 arch/sh/include/asm/fixmap.h     |    8 +
 arch/sh/include/asm/io.h         |    4 +
 arch/sh/kernel/setup.c           |    2 +
 arch/sh/mm/Makefile              |    3 +-
 arch/sh/mm/ioremap_64.c          |  290 +-------------------------------------
 arch/sh/mm/ioremap_fixed.c       |  209 +++++++++++++++++++++++++++
 7 files changed, 238 insertions(+), 289 deletions(-)
 create mode 100644 arch/sh/mm/ioremap_fixed.c

