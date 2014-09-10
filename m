From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Sep 2014 00:05:27 +0000
Subject: Re: [PATCH v2 01/10] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <20140910000527.GF16682@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 09, 2014 at 03:19:10PM -0700, Mike Turquette wrote:
> Quoting Simon Horman (2014-09-03 23:49:24)
> > On Wed, Sep 03, 2014 at 09:50:48AM +0200, Ulrich Hecht wrote:
> > > On Wed, Sep 3, 2014 at 7:40 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > > > Quoting Ulrich Hecht (2014-09-02 02:12:57)
> > > >> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> > > >> index 531d4f6..0c4fd11 100644
> > > >> --- a/drivers/clk/shmobile/Makefile
> > > >> +++ b/drivers/clk/shmobile/Makefile
> > > >> @@ -5,6 +5,7 @@ obj-$(CONFIG_ARCH_R8A7779)              += clk-r8a7779.o
> > > >>  obj-$(CONFIG_ARCH_R8A7790)             += clk-rcar-gen2.o
> > > >>  obj-$(CONFIG_ARCH_R8A7791)             += clk-rcar-gen2.o
> > > >>  obj-$(CONFIG_ARCH_R8A7794)             += clk-rcar-gen2.o
> > > >> +obj-$(CONFIG_ARCH_SH73A0)              += clk-sh73a0.o
> > > >>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-div6.o
> > > >>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += clk-mstp.o
> > > >>  # for emply built-in.o
> > > >
> > > > So I don't have any of the CONFIG_ARCH_R8A7794 stuff in my tree, per
> > > > this email thread [0].
> > > >
> > > > Do you want the clk patches in this series to go through Simon's tree
> > > > also?
> > > 
> > > That would probably work best.
> > 
> > Yes, I think so too.
> > 
> > Mike, could you provide an Ack?
> 
> Sure, you have my Ack for patch #1 and #8. I think #9 is still
> unresolved. Will that be converted to a mux clock?

Ulrich, please include Mike's ack when you repost this patch
to address Laurent's feedback (in other subthreads).
