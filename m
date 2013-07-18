From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Jul 2013 01:52:05 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <87zjtkljni.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > >>    NAK.
> > 
> > >Please provide some reasoning for your objection to this change.
> > >Likewise for other patches in this series to which you have replied
> > >in the same manner. I for one do not understand what it is you object to.
> > 
> >    Sorry, I was just out of words when I saw this. I for one do not
> > understand how this change will help the DT support and to me it
> > seems no more than a pointless churn and step backward from what we
> > had. Under no circumstances I will accept this change -- I'm totally
> > opposed to the idea of moving the SoC devices to the board code.
(snip)
> And furthermore you don't see how this change aids adding DT support.
> 
> This question also seems reasonable to me.

Now, we are aiming to support DT.
If we have perfect DT support, these all r8a77xx_add_xxx_device()
and board-xxx.c will be removed, since these are not needed on DT any more.
(board-xxxx-reference.c will be survived)

Now, our r8a77xx_add_xxx_device() has 2 types.
 - r8a77xx_add_xxx_device()
 - r8a77xx_add_xxx_device(pdata)

In DT point of view, "main" device setting code will be exist on r8a77xx.dtsi,
and we can add "additional" settings on r8a77xx-board.dts.
So, these will be replaced like this

 - r8a77xx_add_xxx_device()      -> r8a77xx.dtsi
 - r8a77xx_add_xxx_device(pdata) -> r8a77xx.dtsi + r8a77xx-board.dts

In C base code point of view,
of course we need r8a77xx_add_xxx_device(pdata) for code sharing
if we have some boards which are using same SoC.
But, As you know, we have 1 board - 1 SoC pair only.
So now, we can cleanup these code, because
 1) we don't need this kind of non-shared sharing code
 2) these code will be removed if we have DT support
 3) these non-shared sharing code complicates code

When we have DT support,
"remove un-necessary board code" is more easy than
"remove un-necessary board code" + "remove unused code from setup.c"

On r8a77xx_add_xxx_device() case,
these are automatically registered from SoC code,
and this is same style with DT.

On this style, some non-necessary driver will be registered automatically,
and it will waste some memory.
But now we have enough memory, and Sergei is already understanding
that why these styles don't become trouble, since he is using same style on USB code.

> I believe that the crux of your concern is that the way that
> SH ethernet support has been added recently is to place SoC portions
> in setup-xxx.c and board-specific portions into board-YYY.c

I wonder where can I find this
"recently added board code which support sh ethernet, and which needs SoC" ?

Best regards
---
Kuninori Morimoto
