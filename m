From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Aug 2011 04:13:02 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-sh73a0: tidyup CKSCR main clock selecter
Message-Id: <87liuc26ut.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking my patch

> > MAINCKSEL is [29:28], not [27:24]
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This matches the data sheet, thanks for submitting this Morimoto-san.
> 
> In the future, please include the word "bug fix" in the subject so we
> can tell it's a bug fix.

Thank you for pointing it.
I will do

Best regards
---
Kuninori Morimoto
