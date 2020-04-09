From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 09 Apr 2020 06:44:06 +0000
Subject: [PATCH v2 00/10] Allow COMMON_CLK to be selectable
Message-Id: <20200409064416.83340-1-sboyd@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, chenhc@lemote.com, Will Deacon <will@kernel.org>, linux-clk@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Alexander Shiyan <shc_work@mail.ru>, Neil Armstrong <narmstrong@baylibre.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Thierry Reding <treding@nvidia.com>, uclinux-h8-devel@lists.sourceforge.jp, Arnd Bergmann <arnd@arndb.de>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>, linux-m68k@lists.linux-m68k.org, Mark Brown <broonie@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

This patch series cleans up a handful of selects that were redundant and
deletes presumably dead code with the goal of making it possible to add
kunit tests for the CCF in the future. To do that, we introduce a
"legacy" clk Kconfig option to mark code that hasn't migrated to the
common clk framework and then make the COMMON_CLK config option visible
in the menuconfig as long as that legacy option isn't enabled. I've also
included a couple patches at the end that may be more controversial but
helped me consolidate all this logic/code.

I haven't done more than compile test a few configs for arm, arm64,
h8300, and mips. More testing is welcome.

The plan is that I'll just merge the whole pile through the clk tree. If
the first five patches or the last three patches are better going
through another tree like arm-soc or architecture trees that's fine too,
but there are potential conflicts between trees so maybe it's better to
just leave it all in one tree.

Changes from v1:
 * Fixed MIPS ralink build problem pointed out by Arnd
 * Fixed meson mx sdio build due to bad Kconfig exposed by this change
 * Picked up acks

Stephen Boyd (10):
  ARM: Remove redundant COMMON_CLK selects
  ARM: Remove redundant CLKDEV_LOOKUP selects
  arm64: tegra: Remove redundant CLKDEV_LOOKUP selects
  h8300: Remove redundant CLKDEV_LOOKUP selects
  MIPS: Remove redundant CLKDEV_LOOKUP selects
  mmc: meson-mx-sdio: Depend on OF_ADDRESS and not just OF
  clk: Allow the common clk framework to be selectable
  ARM: mmp: Remove legacy clk code
  MIPS: Loongson64: Drop asm/clock.h include
  clk: Move HAVE_CLK config out of architecture layer

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: "Andreas F=C3=A4rber" <afaerber@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: <chenhc@lemote.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <linux-c6x-dev@linux-c6x.org>
Cc: <linux-m68k@lists.linux-m68k.org>
Cc: <linux-mips@vger.kernel.org>
Cc: <linux-sh@vger.kernel.org>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

 arch/Kconfig                     |   6 --
 arch/arm/Kconfig                 |   5 +-
 arch/arm/mach-actions/Kconfig    |   1 -
 arch/arm/mach-clps711x/Kconfig   |   1 -
 arch/arm/mach-mmp/Kconfig        |   1 -
 arch/arm/mach-mmp/Makefile       |   6 --
 arch/arm/mach-mmp/clock-mmp2.c   | 114 -------------------------------
 arch/arm/mach-mmp/clock-pxa168.c |  94 -------------------------
 arch/arm/mach-mmp/clock-pxa910.c |  70 -------------------
 arch/arm/mach-mmp/clock.c        | 105 ----------------------------
 arch/arm/mach-mmp/clock.h        |  65 ------------------
 arch/arm/mach-vt8500/Kconfig     |   1 -
 arch/arm64/Kconfig.platforms     |   1 -
 arch/c6x/Kconfig                 |   1 +
 arch/h8300/Kconfig               |   1 -
 arch/m68k/Kconfig.cpu            |   2 +-
 arch/mips/Kconfig                |   7 +-
 arch/mips/loongson2ef/Kconfig    |   2 +-
 arch/mips/loongson64/smp.c       |   1 -
 arch/mips/ralink/Kconfig         |   4 ++
 arch/sh/boards/Kconfig           |   5 ++
 arch/unicore32/Kconfig           |   2 +-
 drivers/clk/Kconfig              |  23 +++++--
 drivers/mmc/host/Kconfig         |   2 +-
 24 files changed, 38 insertions(+), 482 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/clock-mmp2.c
 delete mode 100644 arch/arm/mach-mmp/clock-pxa168.c
 delete mode 100644 arch/arm/mach-mmp/clock-pxa910.c
 delete mode 100644 arch/arm/mach-mmp/clock.c
 delete mode 100644 arch/arm/mach-mmp/clock.h


base-commit: 7111951b8d4973bda27ff663f2cf18b663d15b48
--=20
Sent by a computer, using git, on the internet
