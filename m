From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 02:08:00 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <87d2gk1x4x.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > Grr, indeed !
> > This is not needed on board code.
> > But, how about setup code side which has same issue ?
> 
> Magnus may have a different opinion, but I feel that the SoC setup code
> is also legacy code, though likely to hang around longer than board code.
> So my personal feeling is that it would be better to use your energy
> on other areas.

Hehe, I see, will do  :)
