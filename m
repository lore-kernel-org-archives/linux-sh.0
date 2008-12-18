From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Dec 2008 20:12:58 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <Pine.LNX.4.64.0812182110470.8046@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
	<20081218160841.GA13851@linux-sh.org>
	<Pine.LNX.4.64.0812181717320.5510@axis700.grange>
	<20081218162439.GA27151@linux-sh.org>
	<Pine.LNX.4.64.0812181730080.5510@axis700.grange>
	<20081218193619.GJ10620@game.jcrosoft.org>
In-Reply-To: <20081218193619.GJ10620@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Magnus Damm <damm@igel.co.jp>, video4linux-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

On Thu, 18 Dec 2008, Jean-Christophe PLAGNIOL-VILLARD wrote:

> > Agree - breaking bisection is not something I'm looking into.
> > 
> > If you like, I can explain to you where this extra work comes from. That's 
> > my current understanding of the work flow on v4l, it might still be not 
> > quite right, so I'll be happy if anyone corrects me and tells me a better 
> > way to handle this.
> > 
> > v4l uses mercurial repositories as primary dveelopment trees. These 
> > repositories do not contain complete kernel trees, instead, they present a 
> > directory with some tools, where linux is a subdirectory of, and that's 
> > where a part of the kernel is reproduced.
> 
> so why do not you use git and git-modules it will save you time and will be
> simplest to use and track the v4l tree

I do use git, that's what I'm developing with, and then I have to export 
patches from git, import them in mercurial to prepare a pull request into 
the central v4l-dvb hg repository.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
