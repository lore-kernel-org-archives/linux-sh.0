From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 21:47:23 +0000
Subject: Re: [PATCH] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <20140513214723.GC6784@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201405040219.30018.sergei.shtylyov@cogentembedded.com>
 <20140513013820.GC10973@verge.net.au>
 <53720B95.401@cogentembedded.com>
In-Reply-To: <53720B95.401@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, linux-sh@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org

On Tue, May 13, 2014 at 04:09:57PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/13/2014 05:38 AM, Simon Horman wrote:
> 
> >>I've spent a couple of days with the driver just hanging due to me forgetting
> >>to specify the external crystal frequency, so that clk_get_rate() returned 0
> >>and thus the loop in tmio_mmc_set_clock() never ended. I don't think that's an
> >>acceptable behavior, so I suggest that the minimum frequency is checked for 0
> >>in tmio_mmc_host_probe().
> 
> >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >My suggestion is to update tmio_mmc_host_probe() so that it always exits,
> >perhaps returning an error if appropriate.
> 
>    Did you mean tmio_mmc_set_clock()?

Sorry for the cut-and-paste error. Yes, that is what I meant.
