From: Mike Turquette <mturquette@linaro.org>
Date: Wed, 04 Feb 2015 22:05:06 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <20150204220506.421.62346@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
 <20150204173233.GA30930@katana>
In-Reply-To: <20150204173233.GA30930@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2015-02-04 09:32:34)
> On Wed, Feb 04, 2015 at 01:27:21PM +0100, Geert Uytterhoeven wrote:
> > Anyone may call clk_round_rate() with a zero rate value, so we have to
> > protect against that.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> I agree that this should not be fixed in the core because the fixup is
> really driver dependant.
> 

Applied to clk-next.

Thanks,
Mike
