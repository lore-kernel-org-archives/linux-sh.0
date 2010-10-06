From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 06 Oct 2010 08:13:13 +0000
Subject: Re: [PATCH] sh: fix an ms7724se compile breakage
Message-Id: <Pine.LNX.4.64.1010061010460.9687@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1010030622230.15920@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010030622230.15920@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 6 Oct 2010, Paul Mundt wrote:

> On Sun, Oct 03, 2010 at 06:24:42AM +0200, Guennadi Liakhovetski wrote:
> > Fix a compile breakage, caused by my own careless copy-paste.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Hmm, I'm confused. This doesn't apply to my tree at present, so the
> breakage at least was not introduced there. Is there some patch that this
> is against that I've overlooked?

Strange, it's against next, and the patch, that introduces the breakage is 
http://marc.info/?l=linux-fbdev&m8349840517874&w=2 (44432407) and it's 
signed-off-by you, so, it went via one of your trees. Ah, I see, you 
pushed it via genesis.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
