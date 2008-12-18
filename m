From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: Thu, 18 Dec 2008 21:18:39 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <20081218191839.78cb627d@caramujo.chehab.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
	<20081218160841.GA13851@linux-sh.org>
	<Pine.LNX.4.64.0812181717320.5510@axis700.grange>
	<20081218162439.GA27151@linux-sh.org>
	<Pine.LNX.4.64.0812181730080.5510@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0812181730080.5510@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org

Hi Paul,

> On Fri, 19 Dec 2008, Paul Mundt wrote:
> 
> > It should not cause extra work at all. The only time it may cause extra
> > work is if you are talking about splitting up the patch and pulling in
> > the v4l specific parts in to your v4l tree. My point is that this is
> > absolutely the wrong thing to do, since the changes are tied together for
> > a reason.

Not sure why, buy your replies didn't arrive at the ML. Anyway, from my side,
it is ok to tie the v4l and sh changes together and commit it via either sh or
v4l tree, provided that the patch won't break bisect.

Yet, it is nice if you can c/c us on such patches, in order to help to avoid
future merge conflicts (since, otherwise, development may be done using the
previous version). Otherwise, I'll backport the patch into the development tree
only after reaching Linus tree.

A side note: maybe the design of pxa_camera could be improved to avoid needing
to be touched as architecture changes. This is the only v4l driver that includes
asm/arch header files.

Cheers,
Mauro
