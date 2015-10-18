From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 18 Oct 2015 05:13:19 +0000
Subject: [PATCH 00/02] ARM: shmobile: r8a7794 ALT board DU VGA port enablement
Message-Id: <20151018051319.746.85959.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7794 ALT board DU VGA port enablement

[PATCH 01/02] ARM: shmobile: r8a7794: Add DU device and MSTP clocks
[PATCH 02/02] ARM: shmobile: r8a7794: alt: Enable VGA port

These patches enable VGA port support for the r8a7794 ALT board. No
special merge time dependencies exist, however for correct run time
operation "drm: rcar-du: Add support for the R8A7794 DU" is needed.

Tested with the modetest utility on the r8a7794 ALT board.
# modetest -M rcar-du -c
# modetest -M rcar-du -s 33:1024x768@AR24

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-20151015-v4.3-rc5
 No special compile time dependencies.
 Run time dependency on "drm: rcar-du: Add support for the R8A7794 DU"

 arch/arm/boot/dts/r8a7794-alt.dts         |   61 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7794.dtsi            |   36 +++++++++++++++--
 include/dt-bindings/clock/r8a7794-clock.h |    2 
 3 files changed, 96 insertions(+), 3 deletions(-)
