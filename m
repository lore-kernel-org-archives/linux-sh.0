From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 May 2015 01:21:38 +0000
Subject: [PATCH 00/04] ARM: shmobile: APMU DT support via SMP Enable method
Message-Id: <20150521012138.25972.91336.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>

ARM: shmobile: APMU DT support via SMP Enable method

[PATCH 01/04] devicetree: bindings: Renesas APMU and SMP Enable method
[PATCH 02/04] ARM: shmobile: Add APMU DT support via Enable method
[PATCH 03/04] ARM: shmobile: Add APMU nodes to r8a7791 DTSI
[PATCH 04/04] ARM: shmobile: Remove r8a7791 non-DT APMU override

These patches add DT support for the APMU hardware commonly found in
Renesas R-Car Gen2 SoCs. Without these patches the APMU gets configured
through data expressed in C, and with this series applied it is possible
to describe the APMU configuration in DT and let the enable method point
out that the APMU should be used.

Patch 1 and 2 are Documenting and adding DT support to the APMU driver
together with enabling use of the enable-method way to describe that
the APMU hardware is needed for SMP operation.

Patch 3 and 4 are related to r8a7791 support which gets a DTSI update to
describe the APMU hardware. To avoid breaking support for older DTBs out
in the wild these patches keep the older existing C code APMU configuration
for r8a7791 as-is. During run-time, if the APMU is installed via the
enable-method then it will not be overriden by older non-DT configuration.

I suggest making APMU DT configuration mandatory for SMP operation on
newer SoCs and that we keep the old APMU support code in place for a
good number of kernel releases or until we can identify a couple of major
reasons good enough to force a DTB update on the end users.

The series have been tested on r8a7791 Koelsch in 4 cases:
A) Default case when series is applied - 2 cores - OK (DT APMU)
B) Like A) but r8a7791 smp_init() commented out - 2 cores - OK (DT APMU)
C) Like B) but with patch 3 reverted - 1 core - OK (No SMP available)
D) Like C) but reverted commented out code from B) - 2 cores - OK (C APMU)

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---
 Written against renesas-devel-20150519-v4.1-rc4

 Documentation/devicetree/bindings/arm/cpus.txt           |    1 
 Documentation/devicetree/bindings/power/renesas,apmu.txt |   31 ++++
 arch/arm/boot/dts/r8a7791.dtsi                           |    7 +
 arch/arm/mach-shmobile/platsmp-apmu.c                    |   89 +++++++++++++-
 arch/arm/mach-shmobile/r8a7791.h                         |    2 
 arch/arm/mach-shmobile/setup-r8a7791.c                   |    2 
 arch/arm/mach-shmobile/smp-r8a7791.c                     |   11 +
 7 files changed, 136 insertions(+), 7 deletions(-)
