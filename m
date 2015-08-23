From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 23 Aug 2015 07:24:27 +0000
Subject: [PATCH v2 00/07] ARM: shmobile: APMU DT support via SMP Enable method V2
Message-Id: <20150823072427.14156.1960.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

ARM: shmobile: APMU DT support via SMP Enable method V2

[PATCH v2 01/07] devicetree: bindings: Renesas APMU and SMP Enable method
[PATCH v2 02/07] ARM: shmobile: Add APMU DT support via Enable method
[PATCH v2 03/07] ARM: shmobile: Add APMU nodes to r8a7790 DTSI
[PATCH v2 04/07] ARM: shmobile: Add APMU nodes to r8a7791 DTSI
[PATCH v2 05/07] ARM: shmobile: Add function to prioritize DT SMP
[PATCH v2 06/07] ARM: shmobile: Prioritize r8a7790 DT APMU support
[PATCH v2 07/07] ARM: shmobile: Prioritize r8a7791 DT APMU support

These patches add DT support for the APMU hardware commonly found in
Renesas R-Car Gen2 SoCs. Without these patches the APMU gets configured
through data expressed in C, and with this series applied it is possible
to describe the APMU configuration in DT and let the enable method point
out that the APMU should be used.

Patch 1 and 2 are Documenting and adding DT support to the APMU driver
together with enabling use of the enable-method way to describe that
the APMU hardware is needed for SMP operation.

Patch 3 and 4 are related to r8a7790/r8a7791 support that get a DTSI update
to describe the APMU hardware. To avoid breaking support for older DTBs out
in the wild these patches keep the older existing C code APMU configuration
as-is. Patch 5-7 make sure that during run-time, if the APMU is installed
via the DT enable-method then it will not be overriden by older non-DT
configuration.

I suggest making APMU DT configuration mandatory for SMP operation on
newer SoCs and that we keep the old APMU support code in place for a
good number of kernel releases or until we can identify a couple of major
reasons good enough to force a DTB update on the end users.

In the future r8a7793 and r8a7794 support may be added by using code
similar to patch 3 and 4 but without any C-based SMP code and fallback.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

Written against renesas-drivers-2015-08-18-v4.2-rc7
 
 Documentation/devicetree/bindings/arm/cpus.txt           |    1 
 Documentation/devicetree/bindings/power/renesas,apmu.txt |   31 ++++
 arch/arm/boot/dts/r8a7790.dtsi                           |   13 ++
 arch/arm/boot/dts/r8a7791.dtsi                           |    7 +
 arch/arm/mach-shmobile/common.h                          |    1 
 arch/arm/mach-shmobile/platsmp-apmu.c                    |   89 +++++++++++++-
 arch/arm/mach-shmobile/platsmp.c                         |    7 +
 arch/arm/mach-shmobile/setup-r8a7790.c                   |    1 
 arch/arm/mach-shmobile/setup-r8a7791.c                   |    1 
 9 files changed, 147 insertions(+), 4 deletions(-)
