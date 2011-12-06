From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Dec 2011 16:51:53 +0000
Subject: [PATCH 00/07] ARM: mach-shmobile: r8a7779 and Marzen prototype V1
Message-Id: <20111206165153.19348.46277.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: r8a7779 and Marzen prototype V1

[PATCH 01/07] ARM: mach-shmobile: Marzen mach-type entry
[PATCH 02/07] sh: CPG MSTP ioremap() prototype hack
[PATCH 03/07] ARM: mach-shmobile: r8a7779 and Marzen base support
[PATCH 04/07] ARM: mach-shmobile: Marzen early console hack
[PATCH 05/07] ARM: mach-shmobile: r8a7779 PFC GPIO-only prototype
[PATCH 06/07] ARM: mach-shmobile: r8a7779 PFC ioremap() workaround
[PATCH 07/07] ARM: mach-shmobile: Marzen GPIO LED test code

On the SoC-level simple things like the SCIF console, the TMU timer,
the GIC interrupt controller, initial CPG clock framework code and
and GPIO-only PFC support are implemented. On the Marzen board the
only code for now is support for LED2, LED3 and LED4. The LEDs are
used to test the GPIO-only PFC and can be toggled from user space.

On the immediate todo is:
- Rewrite [PATCH 02/07] and submit separately
- Add ioremap() support to drivers/sh/pfc.c and drop [PATCH 06/07]
- Add variable bit field length to drivers/sh/pfc.c
- Update r8a7779 PFC code to support GPIO_FN (needs variable bit field)

List of things I'm not going to touch this week:
- r8a7779 clock framework (Special gift for Morimoto-san)
- r8a7779 external IRQ pin support (INTC2 sits between IRQ pins and GIC)
- Marzen LAN89218 support (hooked up to EX_CS0/GP_0_15 and IRQ1_B/GP_4_14)

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 Do not merge - patches will be updated in the near future.

 Will most likely clash with A1 support written by Morimoto-san.
 Built on top of linus rc- git with Kota2 patches destined for -rc.

 arch/arm/mach-shmobile/Kconfig                |   12 
 arch/arm/mach-shmobile/Makefile               |    4 
 arch/arm/mach-shmobile/board-marzen.c         |  133 ++++++
 arch/arm/mach-shmobile/clock-r8a7779.c        |  105 +++++
 arch/arm/mach-shmobile/include/mach/common.h  |    6 
 arch/arm/mach-shmobile/include/mach/r8a7779.h |   69 +++
 arch/arm/mach-shmobile/intc-r8a7779.c         |   58 ++
 arch/arm/mach-shmobile/pfc-r8a7779.c          |  494 +++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-r8a7779.c        |  235 +++++++++++
 arch/arm/tools/mach-types                     |    1 
 drivers/sh/clk/cpg.c                          |    4 
 11 files changed, 1097 insertions(+), 24 deletions(-)
