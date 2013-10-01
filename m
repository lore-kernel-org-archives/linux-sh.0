From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 01 Oct 2013 09:05:50 +0000
Subject: Re: [PATCH 1/6] clocksource: em_sti: convert to clk_prepare/unprepare
Message-Id: <CANqRtoRUy=Fi3-YeMLpiCinOw+0bkVUbjUMYUo7Lv85+b8=UPg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
	<20130924130924.61d4ecedf3d4fca5952d55fc@ops.dti.ne.jp>
In-Reply-To: <20130924130924.61d4ecedf3d4fca5952d55fc-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Tue, Sep 24, 2013 at 1:09 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>
> Add calls to clk_prepare and unprepare so that EMMA Mobile EV2 can
> migrate to the common clock framework.
>
> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> ---
>  drivers/clocksource/em_sti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looking good, thanks!

Acked-by: Magnus Damm <damm@opensource.se>
