From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 23 May 2012 00:23:44 +0000
Subject: Re: [PATCH 02/11] ARM: mach-shmobile: setup-r8a7740: add MERAM work-around
Message-Id: <87ipfnvj77.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwatar29.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Rafael

> > On Tuesday 22 May 2012 13:41:54 Paul Mundt wrote:
> > > As long as this exists outside of the MERAM register map and we don't have
> > > to worry about the MERAM driver touching these values then having it as a
> > > board-specific thing is probably fine. If it falls within the MERAM mapping
> > > somewhere then the MERAM driver really should be dealing with it (or we can
> > > set it as a board-specific thing when the MERAM driver isn't being used),
> > > even if it is a magic value for the given CPU.
> > 
> > I agree. 0xFE950098 is outside of the MERAM registers address space (at least 
> > in the SH7372 datasheet I have). I'm thus fine with setting the register in 
> > board code.
> > 
> Ok, then we can just leave it in either the board or the CPU code.
> Someone will want to verify that we do not have to do anything special
> for this in the suspend/resume case, though. ie, losing the magic setting
> after resume.

I send v2 patch set.
This work-around will be called from board.
And tidyup confusable patch order.

Best regards
---
Kuninori Morimoto
