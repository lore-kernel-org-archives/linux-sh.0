From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 23 Aug 2013 11:16:29 +0000
Subject: Re: [PATCH 1/5] sh-pfc: r8a7778: add SRU/SSI pin support
Message-Id: <3589033.Z2Kq7Gym4X@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738qmjgav.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thursday 22 August 2013 17:51:20 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > The only copy of the datasheet I have access to is in Japanese, so it's a
> > bit hard to understand for me :-)
> 
> Oops
> 
> > We seem to have three pin sharing groups: SSI0/1/2, SSI3/4 and SSI7/8.
> > 
> > SSI7 and SSI8 have a single set of SCK and WS pins called SCK78 and WS78.
> > What are the possible combinations here ? I can think of
> > 
> > - SSI7 alone with (SCK78, WS78, SDATA7)
> > - SSI8 alone with (SCK78, WS78, SDATA8)
> > - SSI7 and SSI8 together with (SCK78, WS78, SDATA7, SDATA8) using a single
> > set of shared SCK and WS signals, driven by either SSI7 or SSI8
> > 
> > For SSI3 and SSI4, I can think of more combinations:
> > 
> > - SSI3 alone with (SCK34, WS34, SDATA3)
> > - SSI4 alone with (SCK4, WS4, SDATA4)
> > - SSI4 alone with (SCK34, WS34, SDATA4)
> > - SSI3 and SSI4 together with (SCK34, WS34, SDATA3) for SSI3 and (SCK4,
> > WS4, SDATA4) for SSI4
> > - SSI3 and SSI4 together with (SCK34, WS34, SDATA3, SDATA4) using a single
> > set of shared SCK and WS signals, driven by either SSI3 or SSI4
> > - SSI3 and SSI4 together with (SCK4, WS4, SDATA3, SDATA4) using a single
> > set of shared SCK and WS signals, driven by either SSI3 or SSI4
> > 
> > SSI0/1/2 is even more complex.
> > 
> > Could you please tell me which of the above combinations is supported ?
> > Based on that we can divide the pins into proper groups.
> 
> Sorry for my confusable explain.
> I can try to explain about this.
> 
> The image is like this
> * can be shared pin
> 
> * SSI0
>   SSI1 (can use SSI0 SCK/WS pin)
>   SSI2 (can use SSI0 SCK/WS pin)
> 
> * SSI3
>   SSI4 (can use SSI3 SCK/WS pin)
> 
>   SSI5
>   SSI6
> 
> * SSI7
>   SSI8 (can use SSI7 SCK/WS pin)

I can pretty much understand the image from the datasheet, it's just the 
Japanese text that I have trouble understanding :-)

> For example, in SSI3/SSI4 case, there are 2 patterns
> 
>  1) alone pattern
>     SSI3 with SCK34, WS34, SDATA3
>     SSI4 with SCK4,  WS4,  SDATA4
> 
>  2) share pattern
>     SSI3 with SCK34, WS34, SDATA3
>     SSI4 with SCK34, WS34, SDATA4
> 
> SSI4 can use (share) SSI3's SCK/WS pin,
> and share SCK or WS only doesn't happen.

Can you also use SSI4 alone (without SSI3) with SCK34, WS34 and SDATA4 ?

> And, SSI8 is very special. it always uses shared pin.
> (can't be alone)
> The pattern for SSI7/SSI8 are...
> 
>  1) alone pattern
>     SSI7 with SCK78, WS78, SDATA7
> 
>  2) share pattern
>     SSI7 with SCK78, WS78, SDATA7
>     SSI8 with SCK78, WS78, SDATA8

Same question, can you use SSI8 alone with SCK78, WS78 and SDATA8 ?

> > > But hmm...
> > > this style can solve above complex SSIxyz settings ?
> > > 
> > >  - separate data / ctrl pin
> > >  - select these each
> > >  
> > > 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> > > 				  "ssi01_ctrl", "ssi"),
> > > 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> > > 				  "ssi0_data", "ssi"),
> > > 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
> > > 				  "ssi1_data", "ssi"),
> > 
> > The answer to this depends on what combinations are supported by the
> > hardware. Let's first discuss that, and then decide how to divide pins in
> > pin groups.
>
> OK
> 
> From SSI4 point of view, the DATA4 is fixed,
> and it can select SCK / WS pin from SSI4 (= alone) or SSI3 (= share)

-- 
Regards,

Laurent Pinchart

