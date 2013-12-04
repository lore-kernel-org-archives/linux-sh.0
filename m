From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Dec 2013 20:38:18 +0000
Subject: [PATCH v3 00/03] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <20131204203818.19090.92396.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms@verge.net.au, john.stultz@linaro.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits (v3)

[PATCH v3 01/03] clocksource: Add Kconfig entries for CMT, MTU2, TMU and STI
[PATCH v3 02/03] ARM: shmobile: Remove CMT, TMU and STI Kconfig entries
[PATCH v2 03/03] sh: Remove Kconfig entries for TMU, CMT and MTU2

This is V3 of the SH and ARM mach-shmobile clocksource Kconfig
consolidation series.

By sharing Kconfig entires in drivers/clocksource/Kconfig we
can get rid of duplicated bits that do not belong under arch/.

With this series applied it is possible to build the timer
drivers for CMT, MTU2, TMU and STI in case of SH or ARM. The timer
drivers are automatically selected by default. It is also possible
to select and/or deselect freely when COMPILE_TEST has been selected.

Since last time this has been broken out into 3 separate patches,
where [PATCH v3 01/03] needs to go first, and the other patches
can be merged any time after without any build or configuration
issues.

Thanks to Daniel, John and Arnd for feedback!

This version tries to find a middle ground by:
 - Not allowing user selection of timers by default
 - Automaticlally select available drivers using SYS_SUPPORTS_xxx.
 - Allow manual override in case of COMPILE_TEST (select and deselect)
 - The system will boot regardless of these settigns
 - In this version the special case menu tand if have been dropped

Slightly different and/or not really handled in this version:
 - The acronym soup is kept as-is for now
 - Allow select _and_ deselect in case of COMPILE_TEST (not only select)
 - Follow same style as SH and select per-SoC SYS_SUPPORTS_xxx

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-rc2-20131202

 arch/arm/mach-shmobile/Kconfig |   35 +++++++++++++++++------------------
 arch/sh/Kconfig                |   21 ---------------------
 drivers/clocksource/Kconfig    |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 39 deletions(-)
