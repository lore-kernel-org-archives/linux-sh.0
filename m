From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 13 Jun 2012 13:37:10 +0000
Subject: [PATCH 0/5 v4] mmc: sh_mmcif: clock and power updates
Message-Id: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

This patch series supersedes this thread

http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus626

and these patches:

http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus630
http://thread.gmane.org/gmane.linux.kernel.mmc/14624/focus638

It has been decided to reorganise the above series to split it into 
several smaller and simpler ones, to separate platform patches from driver 
patches to reduce cross-dependencies as much as possible.

It requires the recently posted v5 of "mmc: add a function to get 
regulators, supplying card's power," and patch "mmc: sh_mmcif: Support 
MMC_SLEEP_AWAKE command" from Laurent:

http://thread.gmane.org/gmane.linux.kernel.mmc/14939

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
