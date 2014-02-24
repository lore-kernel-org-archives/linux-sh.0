From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Feb 2014 00:29:28 +0000
Subject: Re: [PATCH 1/3] clk: add clock-indices support
Message-Id: <1400141.lU4VofDlLi@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday 23 February 2014 15:46:04 Mike Turquette wrote:
> Quoting Laurent Pinchart (2014-02-23 14:40:46)
> > On Sunday 23 February 2014 13:00:24 Mike Turquette wrote:
> > > Quoting Ben Dooks (2014-02-13 10:02:49)
> > > 
> > > > Add a property called clock-indices to allow clock-output-names
> > > > to be used where the index used to lookup a clock is not a 1:1
> > > > mapping to the array position in the clock-output-names
> > > > 
> > > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > 
> > > Ben & Laurent,
> > > 
> > > The clock-indices stuff looks sane to me. I've taken Ben's patch #1 into
> > > clk-next. It seems patch #3 might be dropped and patch #2 didn't apply
> > > cleanly for me.
> > > 
> > > Can Laurent's patches and Ben's #2 be rebased and sent together as a PR?
> > 
> > Sure. I've pushed my pending patches to
> > 
> >         git://linuxtv.org/pinchartl/fbdev.git clocks/next/drivers
> > 
> > Ben, could you please rebase your patch on top of it and repost ? I'll
> > then send a pull request to Mike.
> 
> FYI, I've just pushed a new clk-next branch based on -rc3 out to my
> linaro remote. You don't need to rebase but it's there if you want to
> put your stuff on top of the latest.

Thanks. Rebased and pushed.

> > > I'll leave it up to you guys to figure out the backwards compatibility
> > > issue with Ben's patch #3.

-- 
Regards,

Laurent Pinchart

