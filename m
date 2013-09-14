From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 15:28:48 +0000
Subject: [PATCH 00/03] ARM: shmobile: r8a7790 CA7 boot mode support
Message-Id: <20130914152848.12327.55620.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7790 CA7 boot mode support

[PATCH 01/03] ARM: shmobile: Add r8a7790 CA7 CPU cores to DTSI
[PATCH 02/03] ARM: shmobile: Extend APMU code to allow single cluster only
[PATCH 03/03] ARM: shmobile: Include CA7 cores in APMU table

This series enables the CA7 boot mode on r8a7790. Earlier this was
included in the r8a7790 SMP patch, but it was removed from the shared
APMU SMP code during adjustment to r8a7791 single cluster support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-20130906

 arch/arm/boot/dts/r8a7790.dtsi        |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c |   17 +++++++++++++++++
 2 files changed, 45 insertions(+)
