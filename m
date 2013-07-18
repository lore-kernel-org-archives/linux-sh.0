From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Jul 2013 06:35:12 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <87vc48l6jn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for your reply

> > In C base code point of view,
> > of course we need r8a77xx_add_xxx_device(pdata) for code sharing
> > if we have some boards which are using same SoC.
> > But, As you know, we have 1 board - 1 SoC pair only.
> > So now, we can cleanup these code, because
> >  1) we don't need this kind of non-shared sharing code
> >  2) these code will be removed if we have DT support
> >  3) these non-shared sharing code complicates code
> 
> But by that logic we could add all device initialisation
> into board code for the case where we only support one board
> for a given SoC.

The target of these cleanup codes are r8a77xx_add_xxx_device(pdata) type,
not r8a77xx_add_xxx_device() at this point,
But the later will be removed if we have DT support.

The confusing things is that we have DT/non-DT code.
I don't move r8a77xx_add_xxx_device() from setup code to board code,
because we have board-xxx-reference.c.
This means these are shared.

> But is it really that much easier?
> Does this series remove all the other unused code from setup.c?
> Does it really matter if we forget to remove some bits of setup.c
> once they are unused?

The point is not "unused code", but "non-shared sharing code".
I guess people use copy-paste base development.
So, if we don't clean-up these "non-shared sharing code" now,
we will have more and more r8a77xx_add_xxx_device(pdata) type method
(which is the "non-shared sharing code" :)
in both board-xxx.c and setup-xxx.c before we have DT support.
This means clean-up these "after" DT support will be more complex.
I don't want this type of nightmare.

> In board-bockw.c there is ether_platform_data which provides
> board-specific configuration. And in setup-r8a7778.c there
> is ether_resources which provides SoC specific information.
(snip)
> This change seems to treat sh eth as a special case.
> I don't have a particularly strong opinion about it.
> But it doesn't seem like a good idea to me.

Sorry, I still can't understand about this...
bockw - r8a7778 sh_eth clean-up code is caring
its resource (from setup) and board configuration (from bockw).
I don't think there is conflict, but do I mistake ?

Do you mean r8a7779 sh_eth clean-up code ?
If so, 1) I can't find "board" code which is using r8a7779_add_ether_device(xx),
2) I guess marzen board doesn't have sh_eth HW implementation.

Best regards
---
Kuninori Morimoto
