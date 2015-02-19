From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Feb 2015 01:27:49 +0000
Subject: [PATCH 00/01] ARM: shmobile: 64-bit VSP1 build test prototype
Message-Id: <20150219012749.1740.77896.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: 64-bit VSP1 build test prototype

[PATCH 01/01] ARM: shmobile: Drop VSP1 deps to allow 64-bit build

This series contains prototype code that adjusts the Kconfig dependencies
to allow building the R-Car VSP1 driver on any architecture including 64-bit
x86_64 and arm64. The VSP1 driver builds just fine without any warnings.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20150215-v3.19. Not for upstream merge.

 drivers/media/platform/Kconfig |    1 -
 1 file changed, 1 deletion(-)
