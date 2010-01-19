From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Jan 2010 08:37:00 +0000
Subject: Re: [PATCH] sh: support SIU sourcing from external clock on sh7722
Message-Id: <aec7e5c31001190037m1505b9f3o7b4b8d488cf0ea4e@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001150843570.4375@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001150843570.4375@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 15, 2010 at 4:49 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This is a preparation patch for upcoming SIU audio interface support
> patches. It implements switching between the PLL and the master clock,
> supplied from a codec over SIUMCK[AB] pins, as a clock source for SIU[AB]
> and setting of the divisor.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Thanks for the patch!

> In fact, the .set_rate() method can be easily extended to become suitable
> for all "div4" clocks, would this be preferred?

I think both .set_rate() and .set_parent() can be reused for all
"div4" clocks. Check if parent name is "pll_clk", if so clear bit 7
otherwise set bit 7. This way the external pin code will work for SIU
on both sh7722 and sh7723.

/ magnus
