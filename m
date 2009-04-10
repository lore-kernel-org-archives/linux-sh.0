From: morimoto.kuninori@renesas.com
Date: Fri, 10 Apr 2009 00:27:12 +0000
Subject: Re: [PATCH] sh7786: modify usb setup timeout judgment bug.
Message-Id: <u4owxnyjj.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzleql7ud.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear all

> > SH7763's OHCI need initialization too
> > (but differ proccess: arch/sh/board/mach-sh7763rdp/setup.c: line 172).
> > 
> > I'm sorry, I don't know detail of this function.
> > Morimoto-san, please tell me this information?

Sorry, I don't know either...

> deferrable. Introduce a platform data it can be usefull but I would like to
> know if there are other info that can be passed with the platform data.
> Is that the only cpu that needs a specific initialization? Before a patch
> maybe we can ask how can we use it?

SH7724 CPU (new CPU) need specific initialization too.
It use r8a66597.

> Just to know:
> what is this function sh7786_usb_use_exclock?

sh7786 can select usb clock mode.
- crystal resonator (default)
- external clock

So, if board use external clock,
we have to set it to register.
This function for it.

Best regards
--
Kuninori Morimoto
 
