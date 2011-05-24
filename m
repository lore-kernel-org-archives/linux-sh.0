From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 24 May 2011 06:58:54 +0000
Subject: [PATCH 0/3] MERAM support for LCDC (clocks and platform data)
Message-Id: <1306220482-29107-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds the necessary platform data for the LCDC MERAM 
support.

This patch series is based on the common/fbdev-meram branch

The fisrt patch "sh_mobile: Add MSTP clock for MERAM" is being resubmitted
as it is currently not in the the common/fbdev-meram branch. 

Damian Hobson-Garcia (3):
  sh_mobile: Add MSTP clock for MERAM
  sh_mobile_meram: Safely disable MERAM operation when not initialized
  sh_mobile_meram: MERAM platform data for LCDC - v3

 arch/arm/mach-shmobile/board-ap4evb.c   |   56 +++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-mackerel.c |   58 +++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7372.c   |    4 ++-
 drivers/video/sh_mobile_lcdcfb.c        |    3 +-
 4 files changed, 119 insertions(+), 2 deletions(-)

