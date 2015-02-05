From: Mike Turquette <mturquette@linaro.org>
Date: Thu, 05 Feb 2015 17:46:10 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <20150205174610.421.31308@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
 <54D29760.4010009@cogentembedded.com> <54D299D6.7060809@cogentembedded.com>
 <4034374.lq5RZGeRAm@avalon>
In-Reply-To: <4034374.lq5RZGeRAm@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Quoting Laurent Pinchart (2015-02-05 09:19:14)
> Hi Sergei,
> 
> On Thursday 05 February 2015 01:14:46 Sergei Shtylyov wrote:
> > On 02/05/2015 01:04 AM, Sergei Shtylyov wrote:
> > >>>>> Anyone may call clk_round_rate() with a zero rate value, so we have to
> > >>>>> protect against that.
> > >>>>> 
> > >>>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >>>> 
> > >>>> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >>>> 
> > >>>> I agree that this should not be fixed in the core because the fixup is
> > >>>> really driver dependant.
> > >>>> 
> > >>> Dunno, zero frequency seems generally insane to me.
> > >> 
> > >> It is useful to find the lowest frequency a clock can support. Basically
> > >> it is a search for the floor frequency.
> > >> 
> > > Why not just use 1? Or are you assuming that some hardware could actually
> > > support 0 Hz?
> > 
> > Replying to myself: yes, this has happened to me, when I forgot to override
> > the EXTAL frequency in the board .dts file (default was 0).
> 
> So it was a good thing that the driver crashed, it let you find a bug ;-)
> 
> Jokes aside, a zero frequency is the usual way to find the lowest frequency, 
> but I agree that there aren't many integers between 0 and 1. Mike, do you have 
> an opinion ?

Yes, I think we should support passing a zero rate for two reasons:

1) it's crazy to not sanitize a value that is passed into a function and
used as a divisor. This is not really a shortcoming of the framework.

2) during the fractional divider discussion there was the idea of making
unsigned long rate into something like millihertz. E.g. rate = 1000 is
1Hz. If we start cheating by passing a rate of 1 into .round_rate, then
we've just created a bug for ourselves if we ever move to millihertz.

Regards,
Mike

> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
