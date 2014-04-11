From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 11 Apr 2014 00:42:24 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <87vbugofwn.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > platform_device_register_xxx() uses kmemdup() for res / data.
> > This means we can move these codes into init function if
> > it was defined.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > >> Simon, Magnus
> > 
> > This is not exciting patch, but cleanup code.
> > This is focusing to lager only at this point.
> > Actually, I would like to create board_add_xxx() function
> > for all devices, on all board-xxx.c / setup-xxx.c
> > Because, board-xxx.c has many global variable, but, almost all are copied
> > by kmemdup() and removed by __init.
> > It will be more readable if these are inside board_add_xxx() function.
> > Yes, not exciting...
> 
> I'm not sure that I understand the motivation for this change.
> Especially as the long term goal is to remove board files entirely.

Grr, indeed !
This is not needed on board code.
But, how about setup code side which has same issue ?
