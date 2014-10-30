From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 30 Oct 2014 00:46:28 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <2059640.IgUDrPFQl3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 29 October 2014 17:07:20 Kuninori Morimoto wrote:
> Hi Laurent, Magnus
> 
> >>>> I've pushed my test branch to
> >>>> 
> >>>> 	git://linuxtv.org/pinchartl/fbdev.git dma/audio
> >>>> 
> >>>> It doesn't include support for DMA hardware descriptors yet, as I
> >>>> wanted to rule out any issue with them.
> >> 
> >> Unfortunately, it was patch applying magic.
> >> ak4643 is needed under iic2, not iic1.
> >> Can you add attached patch on your dma/audio branch ?
> >> 
> >> It works for me.
> >> When you use sound on Lager board, you need amixer setting.
> >> And you can use bottom jack of CN17 for sound output.
> >> 
> >>      / # amixer set "LINEOUT Mixer DACL" on
> > 
> > After applying your patch and setting the control I get sound ! I'll now
> > test and debug hardware descriptors support.
> 
> Nice !
> I thik "normal" cyclic is OK on this driver now.
> Are all patches which are required for cyclic posted to ML ?
> I'm asking because ...
>  - I want to send sound support patch
>  - LTSI 3.14 backport want to use it.

I've just send the latest version of the rcar-dmac patches to the dmaengine 
and linux-sh mailing list, CC'ing you. They include hardware descriptor list 
and cyclic transfer support. I've tested them with your audio patches (I've 
just pushed my test branch to git://linuxtv.org/pinchartl/fbdev.git 
dma/audio).

-- 
Regards,

Laurent Pinchart

