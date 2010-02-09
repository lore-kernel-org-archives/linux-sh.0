From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 03:35:33 +0000
Subject: [PATCH 00/03] ARM: mach-shmobile: INTCA patches
Message-Id: <20100209033533.22732.2030.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: INTCA support

[PATCH 01/03] ARM: mach-shmobile: sh7367 INTCA support
[PATCH 02/03] ARM: mach-shmobile: sh7377 INTCA support
[PATCH 03/03] ARM: mach-shmobile: sh7372 INTCA support

These patches add support for the INTCA harware block in
sh7367, sh7377 and sh7372 using INTC tables. The INTCA
hardware block is an interrupt controller for all on-chip
peripherals and external interrupt sources that connect
to the ARM core. Interrupt sources tied to the SH core
using the INTCS interrupt controller are not supported yet.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile       |    6 
 arch/arm/mach-shmobile/intc-sh7367.c  |  270 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/intc-sh7372.c  |  367 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/intc-sh7377.c  |  350 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7367.c |   43 ---
 arch/arm/mach-shmobile/setup-sh7372.c |   42 ---
 arch/arm/mach-shmobile/setup-sh7377.c |   45 ----
 7 files changed, 990 insertions(+), 133 deletions(-)
