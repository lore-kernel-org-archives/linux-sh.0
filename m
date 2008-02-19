From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:34:20 +0000
Subject: [PATCH 00/09] sh: clean up pci code
Message-Id: <20080219123420.4266.2965.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These patches rework the pci code for the sh architecture.

Currently each board implements some kind of ioport to address mapping. Some
boards use generic_io_base others try passing addresses as io ports. This is
the first set of patches that try to unify the pci code as much as possible
to avoid duplicated code. This will in the end lead to fewer lines board
specific code and more generic code.

Only high level stuff so far. These patches avoid changing low level bits,
I have patches for sh7751 and sh7780 doing that already. I'll post then 
later on this week after some more testing.

Have fun and people with pci host controllers - please test!

/ magnus

 arch/sh/boards/dreamcast/setup.c        |    6 -
 arch/sh/boards/titan/io.c               |    2 
 arch/sh/drivers/pci/fixups-lboxre2.c    |   23 +++----
 arch/sh/drivers/pci/fixups-r7780rp.c    |   35 +++++-----
 arch/sh/drivers/pci/fixups-rts7751r2d.c |   23 +++----
 arch/sh/drivers/pci/fixups-sdk7780.c    |   52 ++++++++--------
 arch/sh/drivers/pci/fixups-se7780.c     |   36 +++++------
 arch/sh/drivers/pci/ops-cayman.c        |    3 
 arch/sh/drivers/pci/ops-dreamcast.c     |   17 ++---
 arch/sh/drivers/pci/ops-landisk.c       |    4 -
 arch/sh/drivers/pci/ops-lboxre2.c       |    6 -
 arch/sh/drivers/pci/ops-r7780rp.c       |    5 -
 arch/sh/drivers/pci/ops-rts7751r2d.c    |    6 -
 arch/sh/drivers/pci/ops-sdk7780.c       |    5 -
 arch/sh/drivers/pci/ops-se7780.c        |    5 -
 arch/sh/drivers/pci/ops-sh03.c          |    2 
 arch/sh/drivers/pci/ops-sh4.c           |   40 ++++++------
 arch/sh/drivers/pci/ops-snapgear.c      |    4 -
 arch/sh/drivers/pci/ops-titan.c         |    5 -
 arch/sh/drivers/pci/pci-auto.c          |    1 
 arch/sh/drivers/pci/pci-sh4.h           |   15 ++--
 arch/sh/drivers/pci/pci-sh5.c           |   15 +++-
 arch/sh/drivers/pci/pci-sh5.h           |    1 
 arch/sh/drivers/pci/pci-sh7751.c        |  100 +++++++++++++++----------------
 arch/sh/drivers/pci/pci-sh7751.h        |    5 -
 arch/sh/drivers/pci/pci-sh7780.c        |   57 ++++++++---------
 arch/sh/drivers/pci/pci-sh7780.h        |    5 -
 arch/sh/drivers/pci/pci.c               |   30 ++++++---
 arch/sh/kernel/io.c                     |    5 +
 arch/sh/mm/ioremap_32.c                 |    4 -
 include/asm-sh/pci.h                    |   80 ++++++++++++++----------
 31 files changed, 321 insertions(+), 276 deletions(-)
