From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Mon, 11 Jan 2016 18:00:08 +0000
Subject: [PATCH 0/3] media: soc_camera: rcar_vin: add rcar-gen3 support
Message-Id: <1452535211-4869-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

* add rcar compatibility strings

  This series adds generic rcar and SoC-specific r8a7795 compatibility
  strings to the rcar-vin driver. The intention is to provide a complete
  set of compatibility strings for known R-Car Gen2 and Gen3 SoCs.

* add ARGB8888 capture format support 

  This series contain a patch which adds the ARGB8888 capture format
  support for R-Car Gen3.

* compile tested only

This series is based on the master branch of linuxtv.org/media_tree.git.


Koji Matsuoka (1):
  media: soc_camera: rcar_vin: Add ARGB8888 caputre format support

Yoshihiko Mori (1):
  media: soc_camera: rcar_vin: Add R-Car Gen3 support

Yoshihiro Kaneko (1):
  media: soc_camera: rcar_vin: Add rcar fallback compatibility string

 .../devicetree/bindings/media/rcar_vin.txt         |  9 +++++++-
 drivers/media/platform/soc_camera/rcar_vin.c       | 24 ++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

-- 
1.9.1

