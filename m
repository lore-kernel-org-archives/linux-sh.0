From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Nov 2013 02:02:01 +0000
Subject: Re: [PATCH 01/16] gpio: rcar: use postcore_init()
Message-Id: <87vbzmy0kq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<1556705.9JOUK7Uj8L@avalon>
	<CACRpkdZ9vGV+=m0kjxu4Apgy1+q5X2NfZ8SKJQZ=dUr3A997+g@mail.gmail.com>
	<2135069.aoIAqI8vgH@avalon>
In-Reply-To: <2135069.aoIAqI8vgH@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Hi Laurent, Linus,

> > The general guideline, as everybody should be aware ;-) is that we
> > should always use module_init(), i.e. device_initcall() and let deferred
> > probe handle any dependencies.
> 
> Thought so, good :-)
> 
> > The only exception would be things like timers and interrupt controllers...
> 
> I wouldn't be against moving regulators and gpios one level up in the initcall 
> order, given that they provide resources used by a very large number of 
> drivers. That would be an optimization only though, and not a work around 
> broken probe deferral paths.
> 
> > Usually not relying on deferred probe is a sign of bugs in the deferral
> > probe path.
> > 
> > I know "my" drivers have this problem too, I would prefer that we try to fix
> > the root issue instead of trying to shovel initcalls around.

I see.
I will fixup driver side.
Thank you

Best regards
---
Kuninori Morimoto
