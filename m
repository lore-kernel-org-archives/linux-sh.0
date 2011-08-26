From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 06:43:16 +0000
Subject: [PATCH 00/03] ARM: mach-shmobile: sh7372 power domain update
Message-Id: <20110826064316.373.79503.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094653.10442.68817.sendpatchset@t400s>
In-Reply-To: <20110630094653.10442.68817.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: mach-shmobile: sh7372 power domain update

[PATCH 01/03] ARM: mach-shmobile: sh7372 A3SM support
[PATCH 02/03] ARM: mach-shmobile: sh7372 A3SP support
[PATCH 03/03] ARM: mach-shmobile: sh7372 A4R support

These patches add support for the A3SM, A3SP and A4R
power domains included in the sh7372 SoC. More work
in needed with QoS for I/O devices and CPUIdle with
A3SM together with future A4S power domain support.

Testing needed, especiall WRT to Suspend-to-RAM!

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c        |    5 
 arch/arm/mach-shmobile/board-mackerel.c      |    9 
 arch/arm/mach-shmobile/include/mach/common.h |    3 
 arch/arm/mach-shmobile/include/mach/sh7372.h |    5 
 arch/arm/mach-shmobile/intc-sh7372.c         |   52 ++++
 arch/arm/mach-shmobile/pm-sh7372.c           |  287 ++++++++++++++++++++++++--
 arch/arm/mach-shmobile/setup-sh7372.c        |   21 +
 arch/arm/mach-shmobile/sleep-sh7372.S        |   55 ++++
 8 files changed, 416 insertions(+), 21 deletions(-)
