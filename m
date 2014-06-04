From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 09:02:54 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <538EE0BE.5030304@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>	<20140603214226.GA2520@sirena.org.uk> <87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, linux-sh@vger.kernel.org

On 04/06/14 01:26, Kuninori Morimoto wrote:
> 
> Hi Violeta, Mark
> 
>> Adding Morimoto-san who does most of the work on those drivers upstream
>> - it's always best to CC relevant maintainers/developers on kernel stuff
>> as things only on the lists are easily missed.  Not deleting context so
>> he sees it.
> 
> Thank you for adding me.
> I want to help you
> 
>>> We have a problem where audio on r8a7790 is not working due to it not
>>> sending interrupts.
> 
> I need to ask you something
> 
> - Are you using lager board ?
> - Which kernel are you using ?
> - Does your kernel booted from legacy code (= using board-lager.c)
>   or from DT code (= using board-lager-referenct.c) ?
> 
>> We've made a hack to force /mstp10_clks /on that makes the audio work.
>> Further investigation showed that it's only needed to force SSI(ALL) on,
>> but, as far as we know, the manual doesn't say anything about it having to
>> be kept on.
> 
> YES. all SSI port needs SSI(ALL).
> (Actually, all SRC needs SRC(ALL) too if you use it)

The result of our investigation is as follows:

- The clock code correctly enables SSI(ALL) but the audio does not work
- If we force SSI(ALL) to be on all the time, we have working audio

> Basically, R-Car sound is very complex IP.
> The interrupt/data register/DMA selection are depends on your "data path"
> 
> This driver is producing many steps to use it.
> 
> At 1st, you can use "PIO transfer". this is not good performance,
> but, very easy settings. you can check your basic setting by this.
> (power/codec/pin/clock...)
> 
> The data path is..
> 
>           PIO
>     [MEM] ---> [SSI]
> 
> Next step is "using DMA". but, R-Car sound has 2 DMAs (Audio DMAC/Audio DMAC peri peri)
> And, these DMAC usage is complex too. So, you can use basic DMA transfer as DMA 1st step.
> The data path is..
> 
>        Audio DMAC
>     [MEM] ---> [SSI]
> 
> Next step is more complex. use SRC
> 
>                      Audio DMAC
>         Audio DMAC    peri peri
>     [MEM] ---> [SRC] --->[SSI]
> 
> Final step is using DVC
> 
>                             Audio DMAC
>         Audio DMAC           peri peri
>     [MEM] ---> [SRC] ---> [DVC] --->[SSI]
> 
> 
> Actually, lagacy boot is supporting above all path.
> But, DT boot is supporting 1st/2nd step only at this point
> (On rsnd driver side, DMAEngine DT is not yet supporing)
> I want to support 3rd/4th step on DT, but I'm busy now...
> 
> I pushed my local patches which are based on LTSI v3.4 + our original patches.
> These are tring to use sound as legacy code (= not DT) for lager/koelsh.
> Maybe not good fit too you, but can help ?
> 
> https://dl.dropboxusercontent.com/u/2774973/lager-koelsh-sound.tar.bz2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
