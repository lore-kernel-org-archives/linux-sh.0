From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 21 Feb 2014 00:54:10 +0000
Subject: [PATCH 0/5][RESENT]mmc: sh_mobile_sdhi: DT update for R-Car
Message-Id: <878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org


Hi Chris

These are re-sent patches for R-Car, since there were no response.
Basically, these clarifies chip dependent settings
inside driver.
These are based on mmc/mmc-next branch
(7536d3f83aa42ba1a3b1c6b30c2b6d94a820cbb2)

Kuninori Morimoto (5):
      mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7778
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7779
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7790
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7791

 drivers/mmc/host/sh_mobile_sdhi.c |   42 +++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 13 deletions(-)
