From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Sep 2011 07:47:45 +0000
Subject: Re: [PATCH 09/10] fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
Message-Id: <87d3f21c2q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehzqqabh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehzqqabh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for checking my patch

> I'm not sure why you're using this convention of clobbering the return
> value. There are a number of reasons why clk_get() could fail, and you're
> simply discarding that information outright and unconditionally kicking
> up -EIO. You should simply do this as:
> 
> 	if (IS_ERR(...)) {
> 		ret = PTR_ERR(...);
> 		...
> 	}
> 
> in order to propagate the error value all the way down the chain. This
> seems to apply to some of the other patches in this series, too.

OK. I understand.
I send v2 of [PATCH 9/10], [PATCH 10/10]

Best regards
---
Kuninori Morimoto
