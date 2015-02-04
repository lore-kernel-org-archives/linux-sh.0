From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 04 Feb 2015 13:50:40 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <28464845.1OHBNvdFWi@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be> <54D21F31.5080706@cogentembedded.com>
In-Reply-To: <54D21F31.5080706@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Sergei,

On Wednesday 04 February 2015 16:31:29 Sergei Shtylyov wrote:
> On 02/04/2015 03:27 PM, Geert Uytterhoeven wrote:
> > Anyone may call clk_round_rate() with a zero rate value, so we have to
> > protect against that.
> 
> Shouldn't this be checked and fixed up in clk_round_rate() then?

Not all implementations need to divide by the requested rate, so I don't think 
a check in the core is the best solution.

> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

-- 
Regards,

Laurent Pinchart

