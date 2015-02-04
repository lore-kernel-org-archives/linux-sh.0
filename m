From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Feb 2015 13:31:29 +0000
Subject: Re: [PATCH] clk: shmobile: div6: Avoid division by zero in .round_rate()
Message-Id: <54D21F31.5080706@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423052841-15194-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa@sang-engineering.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 02/04/2015 03:27 PM, Geert Uytterhoeven wrote:

> Anyone may call clk_round_rate() with a zero rate value, so we have to
> protect against that.

    Shouldn't this be checked and fixed up in clk_round_rate() then?

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

WBR, Sergei

