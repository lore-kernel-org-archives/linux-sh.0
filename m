From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 18 Dec 2008 19:36:19 +0000
Subject: Re: A patch got applied to v4l bypassing v4l lists
Message-Id: <20081218193619.GJ10620@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> Agree - breaking bisection is not something I'm looking into.
> 
> If you like, I can explain to you where this extra work comes from. That's 
> my current understanding of the work flow on v4l, it might still be not 
> quite right, so I'll be happy if anyone corrects me and tells me a better 
> way to handle this.
> 
> v4l uses mercurial repositories as primary dveelopment trees. These 
> repositories do not contain complete kernel trees, instead, they present a 
> directory with some tools, where linux is a subdirectory of, and that's 
> where a part of the kernel is reproduced.

so why do not you use git and git-modules it will save you time and will be
simplest to use and track the v4l tree

Best Regards,
J.
