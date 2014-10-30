From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Oct 2014 01:28:27 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <87sii6xs5j.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > I thik "normal" cyclic is OK on this driver now.
> > Are all patches which are required for cyclic posted to ML ?
> > I'm asking because ...
> >  - I want to send sound support patch
> >  - LTSI 3.14 backport want to use it.
> 
> I've just send the latest version of the rcar-dmac patches to the dmaengine 
> and linux-sh mailing list, CC'ing you. They include hardware descriptor list 
> and cyclic transfer support. I've tested them with your audio patches (I've 
> just pushed my test branch to git://linuxtv.org/pinchartl/fbdev.git 
> dma/audio).

Thank you !
I will check it, and will post sound support patches to ML

Best regards
---
Kuninori Morimoto
