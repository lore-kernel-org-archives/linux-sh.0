From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:30:20 +0000
Subject: Re: mmc: sh_mobile_sdhi: DT update for R-Car
Message-Id: <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Hi Chris, Simon

These are v2 of updates code for R-Car.
I separated v1 patches into for mmc, and for SH-ARM.
This is "mmc" part patches.

Kuninori Morimoto (4):
      mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7778
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7779
      mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7790

 drivers/mmc/host/sh_mobile_sdhi.c |   41 +++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 13 deletions(-)
)
