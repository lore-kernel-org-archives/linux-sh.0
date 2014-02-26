From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Feb 2014 23:13:26 +0000
Subject: [PATCH 00/02] ARM: shmobile: CCI and MCPM support for r8a7790
Message-Id: <20140226231326.4303.71886.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

ARM: shmobile: CCI and MCPM support for r8a7790

[PATCH 01/02] ARM: shmobile: Hook in CCI/MCPM support to shared APMU code
[PATCH 02/02] ARM: shmobile: Add CCI nodes to r8a7790 DTS

Add code to interface to the CCI driver and MCPM to mach-shmobile. The
shared APMU SMP code is extended to share CPU power domain power on
and off support via both regular SMP hooks and MCPM callbacks.

It is worth noting that the APMU code is used for multiple SoCs including
the Dual core CA15 r8a7791 where this MCPM support is not needed and the
big.LITTLE r8a7790 that needs to program the CCI.

Previously posted as "[PATCH] ARM: shmobile: MCPM and CCI prototype".

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc4-20140226

 arch/arm/boot/dts/r8a7790.dtsi               |   28 ++++++
 arch/arm/mach-shmobile/headsmp.S             |    7 +
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/platsmp-apmu.c        |  111 ++++++++++++++++++++++++--
 arch/arm/mach-shmobile/platsmp.c             |    4 
 5 files changed, 144 insertions(+), 7 deletions(-)
