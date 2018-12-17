From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:31:53 +0000
Subject: Re: [PATCH 09/15] pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
Message-Id: <20181217143152.g7vcs3gtphzm7dg6@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-10-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-10-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:08PM +0100, Geert Uytterhoeven wrote:
> The IP10[5:3] field in Peripheral Function Select Register 10 has a
> width of 3 bits, i.e. it allows programming one out of 8 different
> configurations.
> However, 9 values are provided instead of 8, overflowing into the
> subsequent field in the register, and thus breaking the configuration of
> the latter.
> 
> Fix this by dropping a bogus zero value.
> 
> Fixes: ac1ebc2190f575fc ("sh-pfc: Add sh7734 pinmux support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
