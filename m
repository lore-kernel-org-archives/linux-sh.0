From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Apr 2014 02:05:49 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <20140414020547.GG22411@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 10, 2014 at 05:42:24PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > platform_device_register_xxx() uses kmemdup() for res / data.
> > > This means we can move these codes into init function if
> > > it was defined.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > >> Simon, Magnus
> > > 
> > > This is not exciting patch, but cleanup code.
> > > This is focusing to lager only at this point.
> > > Actually, I would like to create board_add_xxx() function
> > > for all devices, on all board-xxx.c / setup-xxx.c
> > > Because, board-xxx.c has many global variable, but, almost all are copied
> > > by kmemdup() and removed by __init.
> > > It will be more readable if these are inside board_add_xxx() function.
> > > Yes, not exciting...
> > 
> > I'm not sure that I understand the motivation for this change.
> > Especially as the long term goal is to remove board files entirely.
> 
> Grr, indeed !
> This is not needed on board code.
> But, how about setup code side which has same issue ?

Magnus may have a different opinion, but I feel that the SoC setup code
is also legacy code, though likely to hang around longer than board code.
So my personal feeling is that it would be better to use your energy
on other areas.
