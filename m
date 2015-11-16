From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Nov 2015 08:57:03 +0000
Subject: [PATCH v2 00/03] ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2
Message-Id: <20151116085703.7119.2518.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7794 ALT board DU VGA port enablement V2

[PATCH v2 01/03] ARM: shmobile: r8a7794: Add DU0 clock
[PATCH v2 02/03] ARM: shmobile: r8a7794: Add DU node to device tree
[PATCH v2 03/03] ARM: shmobile: r8a7794: alt: Enable VGA port

These patches enable VGA port support for the r8a7794 ALT board. No
special merge time dependencies exist, however for correct run time
operation v4.4-rc1 is recommended and in particular the patch
"drm: rcar-du: Add support for the R8A7794 DU".

Tested with the modetest utility on the r8a7794 ALT board.
# modetest -M rcar-du -c
# modetest -M rcar-du -s 33:1024x768@AR24

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-20151113-v4.3

 Changes since V1:
 - The first patch in V1 is replaced with r8a7794 integration patches
   by Laurent from "[PATCH 0/5] R-Car DU: Add support for R8A7793 and R8A7794"
 - Patch 3/3 is updated to fit on top of patch 1 and 2.
 
 No special compile time dependencies. Run time dependency on
 "drm: rcar-du: Add support for the R8A7794 DU" which is present in v4.4-rc1.

 arch/arm/boot/dts/r8a7794-alt.dts         |   61 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi            |   35 +++++++++++++++-
 include/dt-bindings/clock/r8a7794-clock.h |    1 
 3 files changed, 94 insertions(+), 3 deletions(-)
