From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 02:30:42 +0000
Subject: Re: [PATCH 2/6] serial8250-em: convert to clk_prepare/unprepare
Message-Id: <20131003023042.GB27371@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4895580.Leadr2OAf1@avalon>
In-Reply-To: <4895580.Leadr2OAf1@avalon>
 <20130924134113.GA7246-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Sep 24, 2013 at 06:41:13AM -0700, Greg Kroah-Hartman wrote:
> On Tue, Sep 24, 2013 at 01:44:32PM +0900, Simon Horman wrote:
> > [ CCed Greg Kroah-Hartman, the serial maintainer for his review ]
> > 
> > On Tue, Sep 24, 2013 at 01:10:39PM +0900, takasi-y@ops.dti.ne.jp wrote:
> > > From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > > 
> > > Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> > > migrate to the common clock framework.
> > > 
> > > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > > [takashi.yoshii.ze@renesas.com: edited for conflicts]
> > > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 

On Mon, Sep 30, 2013 at 05:25:40PM +0200, Laurent Pinchart wrote:
> Hi Yoshii-san,
> 
> Thank you for the patch.
> 
> On Tuesday 24 September 2013 13:10:39 takasi-y@ops.dti.ne.jp wrote:
> > From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > 
> > Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> > migrate to the common clock framework.
> > 
> > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > [takashi.yoshii.ze@renesas.com: edited for conflicts]
> > Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up in the serial branch of the renesas tree.
