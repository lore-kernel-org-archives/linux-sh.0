From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 29 Oct 2014 00:08:46 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <87ppdbivow.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> By the way, when you submit "ARM: shmobile: r8a7790: Add Audio DMAC devices to 
> DT", you might want to s/contorller/controller/ in r8a7790.dts.

Ohh my...
It never happens if I can use Japanese comment in patch :P

> That gets rid of the runtime PM issue, but I then get a status check failed 
> when trying to play audio and no audio or DMA interrupt seem to be generated:
(snip)
> I can't hear any sound being output (just for confirmation, is the audio 
> output port the bottom connector ?).
> 
> As I don't have amixer installed on my rootfs the problem might also be 
> related to the output being muted. Do you know in which state it starts by 
> default ?
> 
> I've pushed my test branch to
> 
> 	git://linuxtv.org/pinchartl/fbdev.git dma/audio
> 
> It doesn't include support for DMA hardware descriptors yet, as I wanted to 
> rule out any issue with them.

Thank you for pushing your test branch.
I will check it.

Best regards
---
Kuninori Morimoto
