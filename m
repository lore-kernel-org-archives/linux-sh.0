From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Jun 2014 12:46:47 +0000
Subject: Re: Koelsch on v3.16-rc1
Message-Id: <20140616124646.GC30357@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140616122903.GB30357@verge.net.au>
In-Reply-To: <20140616122903.GB30357@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 16, 2014 at 02:33:11PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Jun 16, 2014 at 2:29 PM, Simon Horman <horms@verge.net.au> wrote:
> > I have noticed that Koelsch does not appear to boot on v3.16-rc1.
> > This appears to affect both legacy C (koelsch_defconfig) and
> > multiplatform (shmobile_defconfig).
> >
> > I have not tested to see if this affects any other boards yet.
> >
> > I am currently bisecting the problem (using shmobile_defconfig).
> >
> > However, its a little late in the day and I may not get much further than
> > that today.
> 
> https://lkml.org/lkml/2014/6/11/750

Thanks!

I had just arrived at the end of my bisection which isolated that commit.
