From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:15:05 +0000
Subject: [PATCH 00/08] ARM: shmobile: Suspend on non-SMP update for r8a7790
Message-Id: <20140605051505.18075.76727.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Suspend on non-SMP update for r8a7790

[PATCH 01/08] ARM: shmobile: Allow use of boot code for non-SMP case
[PATCH 02/08] ARM: shmobile: Adjust APMU code to build for non-SMP
[PATCH 03/08] ARM: shmobile: Move r8a7790 reset code to pm-r8a7790.c
[PATCH 04/08] ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
[PATCH 05/08] ARM: shmobile: Use __init for APMU suspend init function
[PATCH 06/08] ARM: shmobile: Setup APMU for suspend in non-SMP case
[PATCH 07/08] ARM: shmobile: Hook up r8a7790 PM code for Multiplatform
[PATCH 08/08] ARM: shmobile: Use shmobile_init_late on r8a7790 DT-only

These patches update mach-shmobile and r8a7790 to allow build of
early boot code and APMU power management code in case of CONFIG_SMP=n.

The reason for this change is to allow use of Suspend-to-RAM for recent
SoCs like r8a7790 with simplified kernel configuration such as when
SMP is disabled. Power management code like CPUFreq, CPUIdle and
Suspend-to-RAM should work regardless of what kind of CONFIG_SMP
setting the user decides.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-rc7-20140605

 arch/arm/mach-shmobile/Makefile        |   16 +++++++-----
 arch/arm/mach-shmobile/headsmp.S       |   13 ++++++----
 arch/arm/mach-shmobile/platsmp-apmu.c  |   17 +++++++++----
 arch/arm/mach-shmobile/pm-r8a7790.c    |   41 ++++++++++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-r8a7790.c |    8 ++++++
 arch/arm/mach-shmobile/smp-r8a7790.c   |   31 ------------------------
 6 files changed, 77 insertions(+), 49 deletions(-)
