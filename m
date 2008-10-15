From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 15 Oct 2008 09:07:27 +0000
Subject: Re: [PATCH] soc-camera: fix compile breakage on SH
Message-Id: <Pine.LNX.4.64.0810151101330.5361@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20081014183936.GB4710@cs181140183.pp.htv.fi>
	<Pine.LNX.4.64.0810142335400.10458@axis700.grange>
	<20081015033303.GC4710@cs181140183.pp.htv.fi>
	<20081015052026.GC20183@cs181140183.pp.htv.fi>
	<aec7e5c30810142328n1563163bw636b8baf1a47ad8b@mail.gmail.com>
	<Pine.LNX.4.64.0810150836100.3896@axis700.grange>
	<aec7e5c30810150103p7ed810ccyc815ad578d64feac@mail.gmail.com>
	<Pine.LNX.4.64.0810151011450.3896@axis700.grange>
	<aec7e5c30810150155q244834c0i65b2f3b927ba2d37@mail.gmail.com>
In-Reply-To: <aec7e5c30810150155q244834c0i65b2f3b927ba2d37@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: video4linux-list@redhat.com, Mauro Carvalho Chehab <mchehab@redhat.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, lethal@linux-sh.org, Magnus Damm <damm@igel.co.jp>

On Wed, 15 Oct 2008, Magnus Damm wrote:

> Yeah, that one plus a patch for the smc91x platform data and another
> one for mmc (which needs updating anyway). So maybe it's not such a
> big deal. And I see your point with closing the window ASAP to do
> damage control. Otoh I wonder how big difference it will be extending
> the breakage window with one commit - there must be zillions of
> commits in after the breakage already.

So, let's close it ASAP.

> Paul, any strong feelings regarding merging things though the SuperH tree?

Hm, I think, soc_camera_platform parts would have to go through v4l tree. 
Unless we ask Andrew / Linus apply a fix directly to minimize the window, 
after you test it of course:-)

> > Thanks, but no thanks:-) I cannot add your copyright, at least not without
> > your explicit agreement (I think). So, I'd prefer you submit a patch for
> > that.
> 
> I wonder if it's a large enough bit sequence to actually copyright. =)
> But sure, I'll do that.

Good, thanks.

> Is this .29 material, or will there be a second v4l round with trivial
> driver changes for .28?
> 
> I've already posted some vivi patches and two simple patches for the
> sh_mobile_ceu driver - sorry about the timing - and i have one more
> sh_mobile_ceu patch outstanding. Also, I think one of my coworkers may
> post a soc_camera driver for ov772x chips soon too.
> 
> Is there any chance that can get included in .28?

I think there is still a chane, if we are fast enough. In any case I 
queued your sh_mobile_ceu patches, will try to push them on to Mauro 
latest this weekend.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
