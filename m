From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Jan 2010 06:55:57 +0000
Subject: [GIT PULL] sh updates for 2.6.33-rc2, part 2.
Message-Id: <20100104065557.GA8721@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The only real churn here is the defconfig updates, which should all be
settled now. The rest of the changes relate to a couple of build and boot
fixes that popped up in -rc1. If it's too late for -rc2, feel free to
just pull it for -rc3 at your leisure.

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.33

Which contains:

Daisuke HATAYAMA (1):
      binfmt_elf_fdpic: Fix build breakage introduced by coredump changes.

Paul Mundt (4):
      sh: Only provide a PCLK definition for legacy CPG CPUs.
      sh: Disable PMB for SH4AL-DSP CPUs.
      sh: Don't default enable PMB support.
      sh: update defconfigs.

 arch/sh/Kconfig                             |   16 ++-
 arch/sh/configs/ap325rxa_defconfig          |   87 +++++++++++---
 arch/sh/configs/cayman_defconfig            |  168 ++++++++++++++++++++-------
 arch/sh/configs/dreamcast_defconfig         |   78 ++++++++++---
 arch/sh/configs/ecovec24-romimage_defconfig |   76 ++++++++++---
 arch/sh/configs/ecovec24_defconfig          |   89 ++++++++++++---
 arch/sh/configs/edosk7705_defconfig         |   49 +++++++--
 arch/sh/configs/edosk7760_defconfig         |   70 ++++++++---
 arch/sh/configs/espt_defconfig              |   77 ++++++++++---
 arch/sh/configs/hp6xx_defconfig             |   70 +++++++++---
 arch/sh/configs/kfr2r09-romimage_defconfig  |   58 ++++++++--
 arch/sh/configs/kfr2r09_defconfig           |   71 ++++++++++--
 arch/sh/configs/landisk_defconfig           |   85 ++++++++++---
 arch/sh/configs/lboxre2_defconfig           |   89 +++++++++++----
 arch/sh/configs/magicpanelr2_defconfig      |   69 ++++++++---
 arch/sh/configs/microdev_defconfig          |   71 +++++++++---
 arch/sh/configs/migor_defconfig             |   92 +++++++++++----
 arch/sh/configs/polaris_defconfig           |   77 ++++++++++---
 arch/sh/configs/r7780mp_defconfig           |   99 ++++++++++++----
 arch/sh/configs/r7785rp_defconfig           |   98 ++++++++++++----
 arch/sh/configs/rsk7201_defconfig           |   59 ++++++++--
 arch/sh/configs/rsk7203_defconfig           |   71 +++++++++---
 arch/sh/configs/rts7751r2d1_defconfig       |   95 ++++++++++++----
 arch/sh/configs/rts7751r2dplus_defconfig    |   95 ++++++++++++----
 arch/sh/configs/sdk7780_defconfig           |   88 +++++++++++---
 arch/sh/configs/se7206_defconfig            |   66 +++++++++--
 arch/sh/configs/se7343_defconfig            |   72 +++++++++---
 arch/sh/configs/se7619_defconfig            |   58 ++++++++--
 arch/sh/configs/se7705_defconfig            |   71 +++++++++---
 arch/sh/configs/se7712_defconfig            |   61 ++++++++---
 arch/sh/configs/se7721_defconfig            |   62 ++++++++---
 arch/sh/configs/se7722_defconfig            |   69 +++++++++---
 arch/sh/configs/se7724_defconfig            |  100 +++++++++++++---
 arch/sh/configs/se7750_defconfig            |   70 +++++++++---
 arch/sh/configs/se7751_defconfig            |   70 +++++++++---
 arch/sh/configs/se7780_defconfig            |   79 ++++++++++---
 arch/sh/configs/sh03_defconfig              |   80 ++++++++++---
 arch/sh/configs/sh7710voipgw_defconfig      |   66 ++++++++---
 arch/sh/configs/sh7724_generic_defconfig    |   80 ++++++++++----
 arch/sh/configs/sh7763rdp_defconfig         |   74 +++++++++---
 arch/sh/configs/sh7770_generic_defconfig    |   79 ++++++++++---
 arch/sh/configs/sh7785lcr_32bit_defconfig   |   83 ++++++++++----
 arch/sh/configs/sh7785lcr_defconfig         |   83 ++++++++++----
 arch/sh/configs/shmin_defconfig             |   64 ++++++++---
 arch/sh/configs/shx3_defconfig              |   93 ++++++++++++---
 arch/sh/configs/snapgear_defconfig          |   79 ++++++++++---
 arch/sh/configs/systemh_defconfig           |   64 ++++++++--
 arch/sh/configs/titan_defconfig             |   87 +++++++++++---
 arch/sh/configs/ul2_defconfig               |   86 ++++++++++----
 arch/sh/configs/urquell_defconfig           |   99 ++++++++++++-----
 arch/sh/include/asm/timex.h                 |   10 ++
 arch/sh/mm/Kconfig                          |    7 +-
 fs/binfmt_elf_fdpic.c                       |    4 +-
 53 files changed, 3029 insertions(+), 884 deletions(-)
