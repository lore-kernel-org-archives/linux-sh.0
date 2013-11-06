From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Nov 2013 11:05:08 +0000
Subject: [PATCH v2 00/03] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <20131106110508.6806.48070.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits (v2)

[PATCH v2 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
[PATCH v2 02/03] ARM: shmobile: Remove CMT, TMU and STI Kconfig entries
[PATCH v2 03/03] sh: Remove Kconfig entries for TMU, CMT and MTU2

This is V2 of the SH and ARM mach-shmobile clocksource Kconfig
consolidation series.

By sharing Kconfig entires in drivers/clocksource/Kconfig we
can get rid of duplicated bits that do not belong under arch/.

With this series applied it is possible to build the timer
drivers for CMT, MTU2, TMU and STI in case of SH or ARM
or when COMPILE_TEST is selected.

Since last time this has been broken out into 3 separate patches,
where [PATCH v2 01/03] needs to go first, and the other patches
can be merged any time after without any build or configuration
issues.

Thanks to Olof and Simon for feedback! If I interpreted your
ideas wrong please let me know and I will update.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.12-rc7-20131101

 arch/arm/mach-shmobile/Kconfig |   21 ---------------------
 arch/sh/Kconfig                |   21 ---------------------
 drivers/clocksource/Kconfig    |   30 ++++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 42 deletions(-)

