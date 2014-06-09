From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 09 Jun 2014 12:38:37 +0000
Subject: [PATCH 00/02] ARM: shmobile: R-car Gen2 CMA reservation support
Message-Id: <20140609123837.31532.85914.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: R-car Gen2 CMA reservation support

[PATCH 01/02] ARM: shmobile: Add shared R-Car Gen2 CMA reservation code
[PATCH 02/02] ARM: shmobile: Enable R-Car Gen2 CMA code in board files

These patches add CMA reservation code for R-Car Gen2 SoCs and boards.

Instead of using custom memory reservation hacks for demos and other
things, make use of standard CMA to reserve a pool of memory. This memory
is suitable for devices that take physically contiguous memory such as
DU and VSP1 multimedia devices. At this point no device assignment is
included - only memory reservation code is added for now.

All R-Car Gen2 SoCs so far have LPAE support and boards tend to use more
than 32-bits of physical addresses to access the system memory. These
patches add code that during run time parses the DT memory banks and nick
256MiB from the highest memory bank within the legacy 32-bit physical memory
space and use that for CMA.

On Lager and Koelsch boards these 256 MiB is at 0x7000000 -> 0x7fffffff.

The code uses dynamic calculation of the CMA area base address over static
DT reservation since this kind of configuration is based on software policy.
DT is however still used to describe the system memory banks as expected.
Software memory partitioning is excluded from DT by design.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-20140609v2

 arch/arm/mach-shmobile/board-koelsch-reference.c |    1 
 arch/arm/mach-shmobile/board-koelsch.c           |    1 
 arch/arm/mach-shmobile/board-lager-reference.c   |    1 
 arch/arm/mach-shmobile/board-lager.c             |    1 
 arch/arm/mach-shmobile/include/mach/rcar-gen2.h  |    1 
 arch/arm/mach-shmobile/setup-r8a7790.c           |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c           |    1 
 arch/arm/mach-shmobile/setup-rcar-gen2.c         |   79 ++++++++++++++++++++++
 8 files changed, 86 insertions(+)

