From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 21 Oct 2014 05:10:26 +0000
Subject: [PATCH v3 0/3] media: soc_camera: rcar_vin: Add scaling support
Message-Id: <1413868229-22205-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This series is against master branch of linuxtv.org/media_tree.git.

Koji Matsuoka (3):
  media: soc_camera: rcar_vin: Add scaling support
  media: soc_camera: rcar_vin: Add capture width check for NV16 format
  media: soc_camera: rcar_vin: Add NV16 horizontal scaling-up support

 drivers/media/platform/soc_camera/rcar_vin.c | 478 ++++++++++++++++++++++++++-
 1 file changed, 468 insertions(+), 10 deletions(-)

-- 
1.9.1

