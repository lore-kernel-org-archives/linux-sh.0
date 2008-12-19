From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Dec 2008 07:15:19 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <Pine.LNX.4.64.0812190808390.3922@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
	<20081218160841.GA13851@linux-sh.org>
	<Pine.LNX.4.64.0812181717320.5510@axis700.grange>
	<20081218162439.GA27151@linux-sh.org>
	<Pine.LNX.4.64.0812181730080.5510@axis700.grange>
	<20081218191839.78cb627d@caramujo.chehab.org>
	<Pine.LNX.4.64.0812190026180.8046@axis700.grange>
	<20081218205706.60bf1526@caramujo.chehab.org>
In-Reply-To: <20081218205706.60bf1526@caramujo.chehab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Thu, 18 Dec 2008, Mauro Carvalho Chehab wrote:

> On Fri, 19 Dec 2008 00:30:05 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > > A side note: maybe the design of pxa_camera could be improved to avoid needing
> > > to be touched as architecture changes. This is the only v4l driver that includes
> > > asm/arch header files.
> > 
> > The patch in question was for sh_mobile_ceu_camera.c - not for pxa, and 
> > even though that one doesn't include any asm headers, as you see, it is 
> > also tied pretty closely with respective platform code.
> 
> > As for including asm headers in pxa_camera.c - it wouldn't be easy to get 
> > rid of them, one of the main obstacles is the use of the pxa-specific 
> > dma-channel handling API.
> 
> Ok. I dunno the specific details of the sh and pxa bindings, but it would be
> better to have it more independent from architecture specific implementation
> details.

...that's what I'm saying - we have to work with the complete kernel tree. 
Working with a part of it is no fun. Just think about one thing - changing 
platform data struct layout. It will still compile as long as you preserve 
the name, because that's just a void * you get from platform, but you 
better don't try to run that... Or take this clock change now to the 
sh_mobile_ceu_camera.c. It will still compile with older kernels, but it 
won't run.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
