From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Nov 2015 09:15:15 +0000
Subject: [PATCH 00/02] ARM: shmobile: r8a7793 GOSE board HDMI prototype
Message-Id: <20151116091515.20711.14784.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: r8a7793 GOSE board HDMI prototype

[PATCH 01/02] ARM: shmobile: r8a7793: Add DU node to device tree
[PATCH 02/02] ARM: shmobile: r8a7793: gose: HDMI prototype hack

These patches include HDMI prototype support for the r8a7793 GOSE board.
No special merge time dependencies exist, however for correct run time
operation v4.4-rc1 is recommended and in particular the patch
"drm: rcar-du: Add support for the R8A7793 DU".

Tested with the modetest utility on the r8a7793 GOSE board.
# modetest -M rcar-du -c
# modetest -M rcar-du -s 33:1280x720@AR24

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-20151113-v4.3

 No special compile time dependencies. Run time dependency on
 "drm: rcar-du: Add support for the R8A7793 DU" which is present in v4.4-rc1.

 arch/arm/boot/dts/r8a7793-gose.dts |   98 ++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7793.dtsi     |   63 ++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 3 deletions(-)
