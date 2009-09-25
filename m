From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Sep 2009 04:41:53 +0000
Subject: [GIT PULL] sh updates for 2.6.32-rc1, part 2.
Message-Id: <20090925044153.GB13166@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Which contains:

Guennadi Liakhovetski (1):
      sh_mobile_ceu_camera: fix compile breakage, caused by a bad merge

Jaswinder Singh Rajput (1):
      sh: includecheck fix: dwarf.c

Kuninori Morimoto (2):
      sh: mach-ecovec24: Add active low setting for sh_eth
      sh: add FSI driver support for ms7724se

Nobuhiro Iwamatsu (2):
      sh: Add support DMA Engine to SH7722
      sh: Add support DMA Engine to SH7780

Paul Mundt (4):
      sh: Handle unaligned 16-bit instructions on SH-2A.
      sh: Fix up uninitialized variable use caught by gcc 4.4.
      sh: update defconfigs.
      sh: enable onenand support in kfr2r09 defconfig.

 arch/sh/boards/mach-ecovec24/setup.c        |    1 +
 arch/sh/boards/mach-se/7724/setup.c         |   89 +++++
 arch/sh/configs/ap325rxa_defconfig          |  100 ++++--
 arch/sh/configs/dreamcast_defconfig         |   82 +++--
 arch/sh/configs/ecovec24-romimage_defconfig |   52 ++--
 arch/sh/configs/ecovec24_defconfig          |   70 +++--
 arch/sh/configs/edosk7705_defconfig         |   50 ++-
 arch/sh/configs/edosk7760_defconfig         |   82 +++--
 arch/sh/configs/espt_defconfig              |   75 +++-
 arch/sh/configs/hp6xx_defconfig             |   69 +++-
 arch/sh/configs/kfr2r09-romimage_defconfig  |   47 ++-
 arch/sh/configs/kfr2r09_defconfig           |   57 ++-
 arch/sh/configs/landisk_defconfig           |   86 +++-
 arch/sh/configs/lboxre2_defconfig           |   86 +++-
 arch/sh/configs/magicpanelr2_defconfig      |   85 +++--
 arch/sh/configs/microdev_defconfig          |   74 +++-
 arch/sh/configs/migor_defconfig             |  111 ++++--
 arch/sh/configs/polaris_defconfig           |   73 +++-
 arch/sh/configs/r7780mp_defconfig           |  116 +++++--
 arch/sh/configs/r7785rp_defconfig           |  125 +++++--
 arch/sh/configs/rsk7201_defconfig           |   60 +++-
 arch/sh/configs/rsk7203_defconfig           |   81 +++-
 arch/sh/configs/rts7751r2d1_defconfig       |   97 ++++-
 arch/sh/configs/rts7751r2dplus_defconfig    |  100 ++++--
 arch/sh/configs/sdk7780_defconfig           |   93 ++++--
 arch/sh/configs/se7206_defconfig            |   80 +++--
 arch/sh/configs/se7343_defconfig            |   91 +++--
 arch/sh/configs/se7619_defconfig            |   56 ++-
 arch/sh/configs/se7705_defconfig            |   75 +++-
 arch/sh/configs/se7712_defconfig            |   79 +++--
 arch/sh/configs/se7721_defconfig            |   86 +++--
 arch/sh/configs/se7722_defconfig            |   92 ++++--
 arch/sh/configs/se7724_defconfig            |  264 +++++++++++---
 arch/sh/configs/se7750_defconfig            |   75 +++-
 arch/sh/configs/se7751_defconfig            |   74 +++-
 arch/sh/configs/se7780_defconfig            |   89 ++++--
 arch/sh/configs/sh03_defconfig              |   87 +++-
 arch/sh/configs/sh7710voipgw_defconfig      |   71 +++-
 arch/sh/configs/sh7724_generic_defconfig    |   64 +++-
 arch/sh/configs/sh7763rdp_defconfig         |   79 +++-
 arch/sh/configs/sh7770_generic_defconfig    |   62 +++-
 arch/sh/configs/sh7785lcr_32bit_defconfig   |  559 +++++++++++++++++++--------
 arch/sh/configs/sh7785lcr_defconfig         |  107 ++++--
 arch/sh/configs/shmin_defconfig             |   68 +++-
 arch/sh/configs/shx3_defconfig              |   95 ++++--
 arch/sh/configs/snapgear_defconfig          |   40 +-
 arch/sh/configs/systemh_defconfig           |   61 +++-
 arch/sh/configs/titan_defconfig             |   93 ++++--
 arch/sh/configs/ul2_defconfig               |  104 ++++--
 arch/sh/configs/urquell_defconfig           |  125 +++++--
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c      |   14 +
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c      |   14 +
 arch/sh/kernel/dwarf.c                      |    1 -
 arch/sh/kernel/traps_32.c                   |   23 +-
 drivers/media/video/sh_mobile_ceu_camera.c  |    4 +-
 55 files changed, 3409 insertions(+), 1284 deletions(-)
