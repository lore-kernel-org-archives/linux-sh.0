From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:36:03 +0000
Subject: [PATCH 00/05] ARM: mach-shmobile: r8a7779 and Marzen V2
Message-Id: <20111213163603.4096.10169.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: r8a7779 and Marzen V2

[PATCH 01/05] ARM: mach-shmobile: r8a7779 and Marzen base support V2
[PATCH 02/05] ARM: mach-shmobile: r8a7779 PFC GPIO-only support V2
[PATCH 03/05] ARM: mach-shmobile: r8a7779 PFC function support
[PATCH 04/05] ARM: mach-shmobile: Marzen SCIF2/SCIF4 support
[PATCH 05/05] ARM: mach-shmobile: Marzen LAN89218 support

On the SoC-level simple things like the SCIF console, the TMU timer,
the GIC interrupt controller, initial CPG clock framework code and
now full PFC support are implemented. On the Marzen board the only
code for now is support for SCIF2/SCIF4 and the LAN89218 ethernet
chip.

Changes since V1:
- Various CPG and PFC changes have now been submitted separately
- Local CPG and PFC workarounds have been dropped
- The r8a7779 PFC code has been updated to fix incorrect register base address
- PMMR support has been added to the PFC code
- r8a7779 PFC function support has been added
- The PFC function code is now used to configure SCIF2/SCIF4 pins
- LAN89218 platform data and pin configuration via PFC function code

People interested in mach-type entry and serial debug code can look at:
[PATCH 00/07] ARM: mach-shmobile: r8a7779 and Marzen prototype V1

Feel free to contact me privately for the following patch that may
be rejected by mailing lists due to size issues:
[PATCH 03/05] ARM: mach-shmobile: r8a7779 PFC function support

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Again, will most likely clash with A1 support written by Morimoto-san.
 Built on top of linus rc- git with Kota2 patches destined for -rc.

 Depends on the following patches for CPG and PFC:
  [PATCH 00/04] sh: clock / CPG ioremap() update
  [PATCH 01/04] sh: extend clock struct with mapped_reg member
  [PATCH 02/04] sh: use ioread32/iowrite32 and mapped_reg for mstp32
  [PATCH 03/04] sh: use ioread32/iowrite32 and mapped_reg for div4
  [PATCH 04/04] sh: use ioread32/iowrite32 and mapped_reg for div6
  [PATCH] sh: pfc: ioremap() support
  [PATCH 00/05] sh: pfc: Variable bitfield width and unlock reg patches
  [PATCH 01/05] sh: pfc: Add gpio_read_bit() for data register access
  [PATCH 02/05] sh: pfc: Convert index to field and value pair
  [PATCH 03/05] sh: pfc: Add config_reg_helper() function
  [PATCH 04/05] sh: pfc: Variable bitfield width config register support
  [PATCH 05/05] sh: pfc: Unlock register support

 arch/arm/mach-shmobile/Kconfig                |   12 
 arch/arm/mach-shmobile/Makefile               |    4 
 arch/arm/mach-shmobile/board-marzen.c         |  157 +
 arch/arm/mach-shmobile/clock-r8a7779.c        |  105 
 arch/arm/mach-shmobile/include/mach/common.h  |    6 
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  327 +++
 arch/arm/mach-shmobile/intc-r8a7779.c         |   58 
 arch/arm/mach-shmobile/pfc-r8a7779.c          | 2647 ++++++++++++++++++++++++-
 arch/arm/mach-shmobile/setup-r8a7779.c        |  231 ++
 9 files changed, 3545 insertions(+), 2 deletions(-)

