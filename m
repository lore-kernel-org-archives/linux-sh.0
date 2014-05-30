From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 30 May 2014 11:14:30 +0000
Subject: Re: [PATCH 1/3] mmc: block: add block number limitation flag for lultiple block read
Message-Id: <87ha47plgq.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
	<87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
	<538864C1.2040203@samsung.com>
In-Reply-To: <538864C1.2040203@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Jaehoon

> Subject has the typo. lultiple -> multiple?

grr..

> I didn't know why you need this patch. Would you use the MMC_CAP2_NO_MULTI_READ?
> And I think...it's not good that used the card's capability flags to fix your H/W bug.

Actually, current platform is using MMC_CAP2_NO_MULTI_READ at this point.
But, our HW bug happens when block size was 2.
Other block size is no problem.

I want to solve this issue somehow.
I'm not sure this is good method or not,
but, can I exchange block size under
mmc_host_ops :: request ?

Best regards
---
Kuninori Morimoto
