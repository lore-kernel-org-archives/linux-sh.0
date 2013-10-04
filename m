From: Nguyen Hong Ky <nh-ky@jinso.co.jp>
Date: Fri, 04 Oct 2013 05:39:18 +0000
Subject: [PATCH] ARM: mach-shmobile: armadillo800eva: Fix RX packets errors on sh_eth
Message-Id: <1380865159-5982-1-git-send-email-nh-ky@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1340189605-22074-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

This patch will fix RX packets errors when receiving big size of data.
It was created on the top of mainline kernel v3.11.

Nguyen Hong Ky (1):
  ARM: mach-shmobile: armadillo800eva: Fix RX packets errors on sh_eth

 drivers/net/ethernet/renesas/sh_eth.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.5.4

