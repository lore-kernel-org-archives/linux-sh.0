From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 10:01:25 +0000
Subject: Re: [PATCH 06/27] ARM: shmobile: shareing DMAEngine USBTS_HI/LOW value
Message-Id: <87bokqp3pq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehpmqzc9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehpmqzc9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for checking patch

> > -#define USBTS_INDEX2VAL(i) (((i) & 3) << 6)
> > +unsigned int usbts_shift[] = USBTS_SHIFT;
> >  
> This doesn't need to be global.
> 
> The wrapping is also pointless, you can rename USBTS_SHIFT to usbts_shift
> and provide a static variable declaration in the header.
> 
> All of this ts_shift[] = TS_SHIFT stuff is a ridiculous attempt to work
> around the type definition, and needs to die.
> 
> We did used to do it this way, but I suppose somewhere along the way
> someone had a brilliant idea for a "cleanup" that we now have to
> propagate this stupidity for.

I see.
will fix in v2

Best regards
---
Kuninori Morimoto
