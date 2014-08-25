From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:45:33 +0000
Subject: [PATCH 00/03] ARM: shmobile: Legacy Kconfig Consolidation
Message-Id: <20140825034533.9316.94291.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Legacy Kconfig Consolidation

[PATCH 01/03] ARM: shmobile: Consolidate Legacy CPU_V7 Kconfig
[PATCH 02/03] ARM: shmobile: Consolidate Legacy SH_CLK_CPG Kconfig
[PATCH 03/03] ARM: shmobile: Consolidate Legacy GPIOLIB Kconfig bits

Consolidate shared Kconfig entries for ARM mach-shmobile legacy
support code. This saves a couple of lines of code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20140823-v3.17-rc1 and
 "[PATCH v2 00/05] ARM: shmobile: Kconfig and Makefile cleanups V2"

 arch/arm/Kconfig               |    3 +++
 arch/arm/mach-shmobile/Kconfig |   24 ------------------------
 2 files changed, 3 insertions(+), 24 deletions(-)
