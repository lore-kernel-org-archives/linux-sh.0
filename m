From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:03:16 +0000
Subject: [PATCH v2 00/05] ARM: shmobile: Kconfig and Makefile cleanups V2
Message-Id: <20140825030316.1936.88249.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Kconfig and Makefile cleanups V2

[PATCH v2 01/05] ARM: shmobile: Introduce a Kconfig entry for R-Mobile
[PATCH v2 02/05] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen1
[PATCH v2 03/05] ARM: shmobile: Introduce a Kconfig entry for R-Car Gen2
[PATCH v2 04/05] ARM: shmobile: Cleanup pm-rcar.o build using Kconfig
[PATCH v2 05/05] ARM: shmobile: Cleanup pm-rmobile.o build using Kconfig

Update the ARM mach-shmobile Kconfig and Makefile to prepare for
multiplatform support of R-Mobile SoCs. While at it do various
cleanups - thanks to Simon Horman for suggesting using Kconfig
for pm-rmobile.o. I applied the same idea to patch 4. Thanks to
Geert Uytterhoeven for pointing out the mess in the Kconfig files,
hopefully this cleanup series is a step in the right direction.

The first patch in V1 of the series has been removed temporarily to
be extended into a separate series with more cleanups for the legacy
case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 Written on top of renesas-devel-20140823-v3.17-rc1

 Only lightly build tested. 

 Changes since V1:
 - Removed "[PATCH 01/06] ARM: shmobile: Consolidate GPIOLIB Kconfig bits"

 arch/arm/mach-shmobile/Kconfig      |   57 +++++++++++++++++++++--------------
 arch/arm/mach-shmobile/Makefile     |   36 +++++++++-------------
 arch/arm/mach-shmobile/pm-rcar.c    |    4 --
 arch/arm/mach-shmobile/pm-rmobile.c |    2 -
 arch/arm/mach-shmobile/pm-rmobile.h |    4 +-
 5 files changed, 53 insertions(+), 50 deletions(-)
