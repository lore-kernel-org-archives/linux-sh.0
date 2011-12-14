From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 14 Dec 2011 18:31:50 +0000
Subject: [PATCH 0/4 v2] mmc_ sh_mmcif: process requests asynchronously
Message-Id: <1323887514-12650-1-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

This used to be a single patch, which now has been split into 2, plus, two more 
not directly related patches for the same driver have been included. Patch 1/4 
is actually a fix and could be considered for 3.2, but I personally haven't 
heard any bug-reports, that could be attributed to it, so, it doesn't seem to 
be very critical. Also, on request from Magnus, a state machine description has 
been added to the file header.

Guennadi Liakhovetski (4):
  mmc: sh_mmcif: process error interrupts first
  mmc: sh_mmcif: cosmetic clean up
  mmc: sh_mmcif: process requests asynchronously
  mmc: sh_mmcif: remove now superfluous sh_mmcif_host::data member

 drivers/mmc/host/sh_mmcif.c |  709 +++++++++++++++++++++++++++++--------------
 1 files changed, 474 insertions(+), 235 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
