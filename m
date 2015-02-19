From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:08:15 +0000
Subject: [PATCH 00/02] ARM: shmobile: 64-bit DU build test prototype
Message-Id: <20150219010815.1660.27980.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: 64-bit DU build test prototype

[PATCH 01/02] ARM: shmobile: Drop DU deps to allow 64-bit build
[PATCH 02/02] ARM: shmobile: Drop DU LVDS deps to allow 64-bit build

This series contains prototype code that adjust the Kconfig dependencies
to allow building the R-Car DU driver on any architecture including 64-bit
x86_64 and arm64. The DU driver builds just fine without any warnings.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150215-v3.19. Not for upstream merge.

 drivers/gpu/drm/rcar-du/Kconfig |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)
