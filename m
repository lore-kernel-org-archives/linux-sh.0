From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 08 Jan 2016 21:56:47 +0000
Subject: [PATCH v2 0/3] drm: adv7511: edid read fixes
Message-Id: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, David Airlie <airlied@linux.ie>

So, here is my V2 of this series. Changes:

* Added tags. Thanks to Laurent and Lars-Peter for review and to Archit for
  testing. Much appreciated!
* rephrased the comment and commit message in patch 1 to be hopefully less
  confusing :)

No code changes!

Thanks,

   Wolfram


Wolfram Sang (3):
  drm: adv7511: really enable interrupts for EDID detection
  drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
  drm: adv7511: it's HPD, not HDP

 drivers/gpu/drm/i2c/adv7511.c | 48 ++++++++++++++++++++++++++-----------------
 drivers/gpu/drm/i2c/adv7511.h | 12 +++++------
 2 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.1.4

