From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 08:34:43 +0000
Subject: [PATCH 00/05] SH-Mobile ARM UIO Multimedia Support
Message-Id: <20100512083443.9395.90768.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH-Mobile ARM UIO Multimedia Support

[PATCH 01/05] ARM: mach-shmobile: Add memchunk support
[PATCH 02/05] ARM: mach-shmobile: Add CONFIG_FORCE_MAX_ZONEORDER
[PATCH 03/05] ARM: mach-shmobile: UIO platform data for sh7372
[PATCH 04/05] ARM: mach-shmobile: UIO platform data for sh7377
[PATCH 05/05] ARM: mach-shmobile: UIO platform data for sh7367

These patches use UIO to export various multimedia hardware blocks
to user space. The code is for SH-Mobile ARM SoCs, but the same
hardware blocks also exist in SH-Mobile SoCs with SH cores. The UIO
interfaces have been in use on the SH architecture for soon two years.

The memchunk patch makes the SH-Mobile ARM kernel behave as the
SH-Mobile SH kernel. The same thing with CONFIG_FORCE_MAX_ZONEORDER,
which is needed to allow allocation of large physically contiguous
memory chunks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the genesis-2.6 git tree without any special dependencies.

 arch/arm/mach-shmobile/Kconfig               |   15 +
 arch/arm/mach-shmobile/Makefile              |    2 
 arch/arm/mach-shmobile/include/mach/common.h |    4 
 arch/arm/mach-shmobile/memory.c              |   74 +++++++
 arch/arm/mach-shmobile/setup-sh7367.c        |  258 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7372.c        |  257 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh7377.c        |  257 +++++++++++++++++++++++++
 7 files changed, 866 insertions(+), 1 deletion(-)
