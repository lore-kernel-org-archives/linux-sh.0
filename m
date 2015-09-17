From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Sep 2015 08:59:36 +0000
Subject: [PATCH 20/21] ARM: shmobile: remove Makefile.boot
Message-Id: <fc22a4d484fafb373c51bb6792bb5a4ef4caae71.1442478814.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now that the only multiplatform boot is supported for all
shmobile platforms Makefile.boot may be removed.

This seems correct to me given:
* Setting MACHINE to no value in arch/arm/Makefile
  if CONFIG_ARCH_MULTIPLATFORM is set
* Not including Makefile.boot in arch/arm/boot/Makefile
  if MACHINE has no value

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Makefile.boot | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/Makefile.boot

diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.1.4

