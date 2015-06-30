From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Tue, 30 Jun 2015 16:25:04 +0000
Subject: [PATCH v2 0/2] v4l: vsp1: Fix Suspend-to-RAM
Message-Id: <1435681506-24296-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Damian Hobson-Garcia <dhobsong@igel.co.jp>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This series fixes Suspend-to-RAM to make VSP1 driver continue working
after resuming.
This series includes two patches:
- fix simple ref_count bug
- add stop/restart the video stream

Sei Fumizono (1):
  v4l: vsp1: Fix Suspend-to-RAM

Yoshihiro Kaneko (1):
  v4l: vsp1: Fix ref_count bug

 drivers/media/platform/vsp1/vsp1_drv.c   | 11 +++--
 drivers/media/platform/vsp1/vsp1_video.c | 69 +++++++++++++++++++++++++++++++-
 drivers/media/platform/vsp1/vsp1_video.h |  5 ++-
 3 files changed, 80 insertions(+), 5 deletions(-)

v2 [Yoshihiro Kaneko]
* compile tested only
* As suggested by Laurent Pinchart
  - separate a patch into two patches
  - add stop/restart the video stream code to vsp1_pipelines_suspend() and
    vsp1_pipelines_resume() function in vsp1_video.c.

-- 
1.9.1

