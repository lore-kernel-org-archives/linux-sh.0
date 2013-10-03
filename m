From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 02:30:00 +0000
Subject: Re: [PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
Message-Id: <20131003023000.GA27371@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1504961.3u9y73MgII@avalon>
In-Reply-To: <1504961.3u9y73MgII@avalon>
 <52440A07.4050101-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Thu, Sep 26, 2013 at 12:18:47PM +0200, Daniel Lezcano wrote:
> On 09/24/2013 06:42 AM, Simon Horman wrote:
> >[ CCed Daniel Lezcano and Thomas Gleixner, the clocksource maintainers ]
> >
> >On Tue, Sep 24, 2013 at 01:09:24PM +0900, takasi-y@ops.dti.ne.jp wrote:
> >>From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> >>
> >>Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> >>migrate to the common clock framework.
> >>
> >>Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> I am not a clk framework expert but at the first glance sounds correct.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

On Mon, Sep 30, 2013 at 05:25:41PM +0200, Laurent Pinchart wrote:
> Hi Yoshii-san,
> 
> Thank you for the patch.
> 
> On Tuesday 24 September 2013 13:09:24 takasi-y@ops.dti.ne.jp wrote:
> > From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > 
> > Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> > migrate to the common clock framework.
> > 
> > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up in the clocksource branch of the renesas
tree. I'll send a pull request to Daniel in the not to distant future.
