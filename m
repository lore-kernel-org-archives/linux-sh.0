From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Jan 2013 00:50:58 +0000
Subject: Re: [PATCH v2 0/8] Use gpio_request_one() in SH Mobile board code
Message-Id: <20130128005058.GG3423@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359029795-7871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1359029795-7871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 25, 2013 at 11:13:13AM +0100, Guennadi Liakhovetski wrote:
> Hi Laurent
> 
> On Thu, 24 Jan 2013, Laurent Pinchart wrote:
> 
> > Hello,
> > 
> > Here are the second version of the gpio_request_one() patches for all SH Mobile
> > board files.
> > 
> > Compared to v1 the patches have been rebased on top of "[PATCH v4 00/81] SH pin
> > control and GPIO rework", as the previous base isn't ready for mainline yet.
> > The patches are otherwise unchanged.
> > 
> > Simon, with the appropriate acks I think this series could go to v3.9. If you
> > would like a pull request, on which of your branches should I rebase the
> > patches ? I've tried to rebase them on top of your current next branch and they
> > apply fine, so picking them up from the mailing list shouldn't be an issue
> > either.
> > 
> > Laurent Pinchart (8):
> 
> All look good to me:
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, I'll apply this series.
