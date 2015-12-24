From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Thu, 24 Dec 2015 11:16:45 +0000
Subject: [PATCH 0/2] spi: sh-msiof: add rcar compatibility strings
Message-Id: <1450955807-22869-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-spi@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This series adds generic rcar and SoC-specific r8a7795 compatibility
strings to the sh-msiof driver. The intention is to provide a complete
set of compatibility strings for known R-Car Gen2 and Gen3 SoCs.

This series is based on the for-next branch of Mark Brown's spi tree.

Hiromitsu Yamasaki (1):
  spi: sh-msiof: Add compatible string for r8a7795

Yoshihiro Kaneko (1):
  spi: sh-msiof: Add rcar fallback compatibility string

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 12 +++++++++---
 drivers/spi/spi-sh-msiof.c                         |  5 +++--
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
1.9.1

