From: Mike Turquette <mturquette@linaro.org>
Date: Wed, 04 Feb 2015 22:01:52 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <20150204220152.421.38508@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
 <20150204173233.GA30930@katana> <54D25AAA.8070904@cogentembedded.com>
In-Reply-To: <54D25AAA.8070904@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Quoting Sergei Shtylyov (2015-02-04 09:45:14)
> Hello.
> 
> On 02/04/2015 08:32 PM, Wolfram Sang wrote:
> 
> >> Anyone may call clk_round_rate() with a zero rate value, so we have to
> >> protect against that.
> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> > I agree that this should not be fixed in the core because the fixup is
> > really driver dependant.
> 
>     Dunno, zero frequency seems generally insane to me.

It is useful to find the lowest frequency a clock can support. Basically
it is a search for the floor frequency.

Regards,
Mike

> 
> WBR, Sergei
> 
