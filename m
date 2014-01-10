From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 Jan 2014 01:08:04 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <20140110010801.GE22965@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 09, 2014 at 04:51:52PM -0800, Kuninori Morimoto wrote:
> 
> Hi Laurent
> 
> Thank you for your help
> 
> > 1. Add the old style clocks to Lager
> > 2. Add the new style clocks to BockW
> > 3. Add the new style clocks to Lager
> > 4. Modify the ADG driver to use the new style clocks
> > 5. Remove the old style clocks from BockW
> > 6. Remove the old style clocks from Lager
> 
> Yes it become clean.
> But hmm, 
> I guess #5, #6 (#4 too ?) are happen after merge anyway ?
> If so, this is more clean for me.
> 
> 1. Add the old style clocks to Lager
> 2. Modify the ADG driver to use the new style clocks.
>    BockW/Lager clocls are fixed in same patch.
> 
> Here, #2 will be done on ALSA branch side after merge,
> and I guess Simon can use it for topic branch for us ?

Sure, let me know what you need.

> # This kind of merge timing something
> # is headache for us :P

Yes!
