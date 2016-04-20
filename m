From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 20 Apr 2016 08:58:11 +0000
Subject: [PATCH 13/23] sh: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
Message-Id: <1461142701-21096-14-git-send-email-linus.walleij@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

This replaces:

- "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
  now be selected directly.

- "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
  is now selectable by everyone, so we need not declare our
  intent to select it.

When ordering the symbols the following rationale was used:
if the selects were in alphabetical order, I moved select GPIOLIB
to be in alphabetical order, but if the selects were not
maintained in alphabetical order, I just replaced
"select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB".

Cc: Michael B=C3=BCsch <m@bues.ch>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Various arch maintainers:

either ACK this and I will merge it into the GPIO tree for v4.7
anticipating no clashes, or you wait until I have the enabling patch
upstream (patch 1 in this series, removing deps on
ARCH_[WANTS_OPTIONAL|REQUIRES]_GPIOLIB), and you will be able to
merge it to your arch trees yourselves for late v4.7
(post GPIO tree merge) or for v4.8.

You can also ask me for an immutable branch if you prefer that, I
will put the enabling patch on a branch and the patch for your arch
on top and ask you to pull it.

Select your option from the menu, silence probably means I will
merge it to the GPIO tree. Unless you are X86 or ARM in which case
I will be cautious.
---
 arch/sh/Kconfig                        | 11 +----------
 arch/sh/boards/Kconfig                 | 17 ++++++++---------
 arch/sh/boards/mach-highlander/Kconfig |  2 +-
 arch/sh/boards/mach-rsk/Kconfig        |  6 +++---
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7ed20fc3fc81..4988b5ec1e7d 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -261,7 +261,6 @@ config CPU_SUBTYPE_SH7203
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_MTU2
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
=20
 config CPU_SUBTYPE_SH7206
@@ -350,7 +349,6 @@ config CPU_SUBTYPE_SH7720
 	select CPU_SH3
 	select CPU_HAS_DSP
 	select SYS_SUPPORTS_SH_CMT
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_OHCI_SH if USB_OHCI_HCD
 	select PINCTRL
 	help
@@ -416,7 +414,6 @@ config CPU_SUBTYPE_SH7723
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
@@ -428,7 +425,6 @@ config CPU_SUBTYPE_SH7724
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_SH_CMT
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
 	help
 	  Select SH7724 if you have an SH-MobileR2R CPU.
@@ -437,7 +433,6 @@ config CPU_SUBTYPE_SH7734
 	bool "Support SH7734 processor"
 	select CPU_SH4A
 	select CPU_SHX2
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
 	help
 	  Select SH7734 if you have a SH4A SH7734 CPU.
@@ -446,7 +441,6 @@ config CPU_SUBTYPE_SH7757
 	bool "Support SH7757 processor"
 	select CPU_SH4A
 	select CPU_SHX2
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
 	help
 	  Select SH7757 if you have a SH4A SH7757 CPU.
@@ -472,7 +466,6 @@ config CPU_SUBTYPE_SH7785
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
=20
 config CPU_SUBTYPE_SH7786
@@ -481,7 +474,6 @@ config CPU_SUBTYPE_SH7786
 	select CPU_SHX3
 	select CPU_HAS_PTEAEX
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select USB_OHCI_SH if USB_OHCI_HCD
 	select USB_EHCI_SH if USB_EHCI_HCD
 	select PINCTRL
@@ -491,7 +483,7 @@ config CPU_SUBTYPE_SHX3
 	select CPU_SH4A
 	select CPU_SHX3
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select PINCTRL
=20
 # SH4AL-DSP Processor Support
@@ -510,7 +502,6 @@ config CPU_SUBTYPE_SH7722
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_SH_CMT
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select PINCTRL
=20
 config CPU_SUBTYPE_SH7366
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 5e52d5362292..e0db04664e2e 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -70,7 +70,7 @@ config SH_7724_SOLUTION_ENGINE
 	bool "SolutionEngine7724"
 	select SOLUTION_ENGINE
 	depends on CPU_SUBTYPE_SH7724
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
@@ -174,7 +174,6 @@ config SH_SDK7786
 	depends on CPU_SUBTYPE_SH7786
 	select SYS_SUPPORTS_PCI
 	select NO_IOPORT_MAP if !PCI
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select HAVE_SRAM_POOL
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
@@ -190,7 +189,7 @@ config SH_HIGHLANDER
 config SH_SH7757LCR
 	bool "SH7757LCR"
 	depends on CPU_SUBTYPE_SH7757
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
=20
 config SH_SH7785LCR
@@ -217,14 +216,14 @@ config SH_SH7785LCR_PT
 config SH_URQUELL
 	bool "Urquell"
 	depends on CPU_SUBTYPE_SH7786
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select SYS_SUPPORTS_PCI
 	select NO_IOPORT_MAP if !PCI
=20
 config SH_MIGOR
 	bool "Migo-R"
 	depends on CPU_SUBTYPE_SH7722
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
@@ -233,7 +232,7 @@ config SH_MIGOR
 config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Renesas "AP-325RXA" support.
@@ -242,7 +241,7 @@ config SH_AP325RXA
 config SH_KFR2R09
 	bool "KFR2R09"
 	depends on CPU_SUBTYPE_SH7724
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  "Kit For R2R for 2009" support.
@@ -250,7 +249,7 @@ config SH_KFR2R09
 config SH_ECOVEC
 	bool "EcoVec"
 	depends on CPU_SUBTYPE_SH7724
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select SND_SOC_DA7210 if SND_SIMPLE_CARD
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
@@ -327,7 +326,7 @@ config SH_X3PROTO
 config SH_MAGIC_PANEL_R2
 	bool "Magic Panel R2"
 	depends on CPU_SUBTYPE_SH7720
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Magic Panel R2 if configuring for Magic Panel R2.
diff --git a/arch/sh/boards/mach-highlander/Kconfig b/arch/sh/boards/mach-h=
ighlander/Kconfig
index def49cc0a7b9..42f5589b4bf3 100644
--- a/arch/sh/boards/mach-highlander/Kconfig
+++ b/arch/sh/boards/mach-highlander/Kconfig
@@ -18,7 +18,7 @@ config SH_R7780MP
 config SH_R7785RP
 	bool "R7785RP board support"
 	depends on CPU_SUBTYPE_SH7785
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
=20
 endchoice
=20
diff --git a/arch/sh/boards/mach-rsk/Kconfig b/arch/sh/boards/mach-rsk/Kcon=
fig
index 458a11ffd022..0b9b2c4952c1 100644
--- a/arch/sh/boards/mach-rsk/Kconfig
+++ b/arch/sh/boards/mach-rsk/Kconfig
@@ -10,17 +10,17 @@ config SH_RSK7201
=20
 config SH_RSK7203
 	bool "RSK7203"
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	depends on CPU_SUBTYPE_SH7203
=20
 config SH_RSK7264
 	bool "RSK2+SH7264"
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	depends on CPU_SUBTYPE_SH7264
=20
 config SH_RSK7269
 	bool "RSK2+SH7269"
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	depends on CPU_SUBTYPE_SH7269
=20
 endchoice
--=20
2.4.11

