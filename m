From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:51:31 +0000
Subject: [PATCH 00/07] sh: SuperH Mobile Sleep Mode Rewrite Part 1/2
Message-Id: <20091029105131.29078.26418.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: SuperH Mobile Sleep Mode Rewrite Part 1/2

[PATCH 01/07] sh: Rename romimage-macros.h to partner-jet-macros.h
[PATCH 02/07] sh: Add notifiers chains for cpu/board code
[PATCH 03/07] sh: Add sh7724 notifier for R-standby save/restore
[PATCH 04/07] sh: Allow boards to register memory pre/post sleep code
[PATCH 05/07] sh: Add kfr2r09 specific memory pre/post sleep code
[PATCH 06/07] sh: Add ms7724se specific memory pre/post sleep code
[PATCH 07/07] sh: Add migor specific memory pre/post sleep code

These patches implement the first part of the sleep mode rewrite
for SuperH Mobile. This is ground work for R-standby support.

Included in these patches are two main features:
 - notifier chains and sh7724 r-standby save/restore code
 - board specific self-refresh code

At this point the board specific self-refresh code is unused,
but in next series the sleep code will be updated to make use
of the new functions.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-kfr2r09/Makefile          |    2 
 arch/sh/boards/mach-kfr2r09/sdram.S           |   52 +++++++
 arch/sh/boards/mach-kfr2r09/setup.c           |   13 +
 arch/sh/boards/mach-migor/Makefile            |    2 
 arch/sh/boards/mach-migor/sdram.S             |   69 ++++++++++
 arch/sh/boards/mach-migor/setup.c             |   13 +
 arch/sh/boards/mach-se/7724/Makefile          |    1 
 arch/sh/boards/mach-se/7724/sdram.S           |   52 +++++++
 arch/sh/boards/mach-se/7724/setup.c           |   12 +
 arch/sh/include/asm/partner-jet-macros.h      |   73 ++++++++++
 arch/sh/include/asm/romimage-macros.h         |   73 ----------
 arch/sh/include/asm/suspend.h                 |   15 ++
 arch/sh/include/mach-ecovec24/mach/romimage.h |    2 
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |    2 
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c        |  167 +++++++++++++++++++++++++
 arch/sh/kernel/cpu/shmobile/pm.c              |   18 ++
 16 files changed, 487 insertions(+), 79 deletions(-)
