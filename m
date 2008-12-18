From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Dec 2008 16:49:09 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <Pine.LNX.4.64.0812181730080.5510@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
	<20081218160841.GA13851@linux-sh.org>
	<Pine.LNX.4.64.0812181717320.5510@axis700.grange>
	<20081218162439.GA27151@linux-sh.org>
In-Reply-To: <20081218162439.GA27151@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, linux-sh@vger.kernel.org

On Fri, 19 Dec 2008, Paul Mundt wrote:

> It should not cause extra work at all. The only time it may cause extra
> work is if you are talking about splitting up the patch and pulling in
> the v4l specific parts in to your v4l tree. My point is that this is
> absolutely the wrong thing to do, since the changes are tied together for
> a reason.
> 
> The last time you went down this splitting of the patch path you
> completely broke bisection for us for an extended period of time, and
> choosing policy over functionality is simply not something I will be part
> of. If you want to split the patch up and merge parts in to your own
> tree, that is perfectly fine, but it is both unnecessary, and I will
> still be merging the change including its dependencies in one shot
> without the split in my own tree so as to not break bi-section.
> 
> If v4l has a policy that anything modifying drivers/media in anyway
> whatsoever needs to be split out and merged through the v4l tree, you
> might consider rethinking your policy and reshaping it in to something
> that actually makes sense. Breaking bisection is not acceptable, period.

Agree - breaking bisection is not something I'm looking into.

If you like, I can explain to you where this extra work comes from. That's 
my current understanding of the work flow on v4l, it might still be not 
quite right, so I'll be happy if anyone corrects me and tells me a better 
way to handle this.

v4l uses mercurial repositories as primary dveelopment trees. These 
repositories do not contain complete kernel trees, instead, they present a 
directory with some tools, where linux is a subdirectory of, and that's 
where a part of the kernel is reproduced.

That part includes of course drivers/media, include/media, some files 
under include/linux, and a couple more random files which has at some 
moment been integrated because they were relevant or because some patch 
touched simultaneously those files and v4l code.

These trees are used for out-of-tree driver development, besides, they are 
trying to make this development and testing possible with a few kernel 
versions back, which means they have to modify sources to include various

#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 27)
...
#else
...
#endif

blocks etc.

Now, it is implicitly assumed, that any development touching v4l code goes 
only in one direction - from these hg trees towards mainline. Any changes 
coming in the other direction involve extra work - they have to be 
back-ported to those hg-trees and specially marked to avoid scripts 
attempting to push them into git-trees again.

So, that's exactly what I had to do this time - find your patch, split off 
the v4l part, commit it marking "not for upstream".

So, now I'd really love to hear that I'm wrong and I oversee much easier 
ways to do this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
