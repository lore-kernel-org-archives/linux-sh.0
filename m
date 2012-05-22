From: kuninori.morimoto.gx@renesas.com
Date: Tue, 22 May 2012 08:04:11 +0000
Subject: Re: [PATCH 02/11] ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
Message-Id: <87r4ucabgo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> The problem with doing these sorts of setting outside of the context of
> the MERAM driver is that the MERAM driver could just turn around and undo
> the work by setting whatever bit this workaround is clearing.
> 
> As long as this exists outside of the MERAM register map and we don't
> have to worry about the MERAM driver touching these values then having it
> as a board-specific thing is probably fine. If it falls within the MERAM
> mapping somewhere then the MERAM driver really should be dealing with it
> (or we can set it as a board-specific thing when the MERAM driver isn't
> being used), even if it is a magic value for the given CPU.
> 
> The main thing is avoiding subtle hard to debug problems where the board
> config workarounds are inadvertently trampled later on.

OK. I see.
There should be no necessity that we worry about the MERAM driver.
Initial setting is enough at this point.

But, I noticed that (maybe) it needs re-initialization if suspend/resume are happen.
It is not supported at this point though.

I can move this workaround from setup.c to board.c at this point.
Is it OK for now ?
