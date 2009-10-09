From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 Oct 2009 02:53:44 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc4
Message-Id: <20091009025344.GB7179@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.32

Which contains:

Kuninori Morimoto (3):
      sh: mach-ecovec24: Add TouchScreen support
      sh: mach-ecovec24: modify 1st MTD area to read only
      sh: mach-ecovec24: Document DS2 switch settings.

Lubomir Rintel (1):
      sh: Build fix: export __movmem

Magnus Damm (2):
      usb: r8a66597-udc unaligned fifo fix
      sh: enable sleep state LEDs on Ecovec24

Matt Fleming (5):
      sh: Don't enable interrupts in the page fault path
      sh: Sprinkle __uses_jump_to_uncached
      sh: Plug PMB alloc memory leak
      sh: Try PMB mapping based on physical address, not mapping size
      sh: Don't allocate smaller sized mappings on every iteration

Paul Mundt (4):
      sh: Handle ioport_map() cases for >= P1SEG addresses.
      sh: Set the default I/O port base to P2SEG.
      sh: magicpanelr2 and dreamcast can use the generic I/O base.
      sh: Disable unaligned kernel access printks by default.

 arch/sh/boards/board-magicpanelr2.c   |    2 -
 arch/sh/boards/mach-dreamcast/setup.c |    2 -
 arch/sh/boards/mach-ecovec24/setup.c  |   63 +++++++++++++++++++-
 arch/sh/kernel/cpu/sh3/entry.S        |    2 -
 arch/sh/kernel/io_generic.c           |    3 +
 arch/sh/kernel/machvec.c              |    3 +
 arch/sh/kernel/sh_ksyms_32.c          |    1 +
 arch/sh/kernel/traps_32.c             |    4 +-
 arch/sh/mm/cache-sh4.c                |    2 +-
 arch/sh/mm/cache-sh7705.c             |    4 +-
 arch/sh/mm/ioremap_32.c               |    2 +-
 arch/sh/mm/pmb.c                      |   37 ++++++++++--
 drivers/usb/gadget/r8a66597-udc.h     |  105 +++++++++++++++++++-------------
 13 files changed, 168 insertions(+), 62 deletions(-)
