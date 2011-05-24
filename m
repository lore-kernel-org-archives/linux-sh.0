From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 24 May 2011 07:16:18 +0000
Subject: [PATCH 0/3] LCDC MERAM runtime PM support
Message-Id: <1306221381-30083-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds runtime PM support for the LCDC MERAM

This patch series is based on the common/fbdev-meram branch

This series should be applied after the "MERAM support for LCDC 
(clocks and platform data)" series.


Damian Hobson-Garcia (3):
  sh_mobile_meram: Add clock enable/disble hooks via runtime PM - v2
  sh_mobile_meram: Enable/disable MERAM clocks along with LCDC clocks - v2
  sh_mobile_meram: Back up and restore device registers on suspend

 drivers/video/sh_mobile_lcdcfb.c |   10 ++++
 drivers/video/sh_mobile_meram.c  |  106 ++++++++++++++++++++++++++++++++++++++
 drivers/video/sh_mobile_meram.h  |    8 ---
 include/video/sh_mobile_meram.h  |    6 ++
 4 files changed, 122 insertions(+), 8 deletions(-)

