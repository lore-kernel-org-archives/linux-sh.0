From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Aug 2012 05:39:57 +0000
Subject: Re: bug report: ecovec boot got WARNING
Message-Id: <877gtjdvbp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdze039.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdze039.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> This looks like the gpio_request() failed and the sanity check in
> gpio_direction_output() triggered.
> 
> Can you attach your .config and a boot log with both gpiolib and pinctrl
> debugging enabled?
> 
> I don't seem to have an ecovec board lying around, so if that doesn't
> provide any helpful clues, you can put the board on my desk when you're
> done with it and I'll track it down. I'll see if I can reproduce
> something similar on the 7724 solution engine in the meantime.

OK.
I send required infomation by next off-list mail

Best regards
---
Kuninori Morimoto
