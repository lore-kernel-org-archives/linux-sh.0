From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 13:58:56 +0000
Subject: Re: [PATCH 05/15] pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 SEL_I2C1 field width
Message-Id: <20181217135856.ppxujqr3t2zak3pn@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-6-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-6-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:04PM +0100, Geert Uytterhoeven wrote:
> The SEL_I2C1 (MOD_SEL0[21:20]) field in Module Select Register 0 has a
> width of 2 bits, i.e. it allows programming one out of 4 different
> configurations.
> However, the MOD_SEL0_21_20 macro contains 8 values instead of 4,
> overflowing into the subsequent fields in the register, and thus breaking
> the configuration of the latter.
> 
> Fix this by dropping the bogus last 4 values, including the non-existent
> SEL_I2C1_4 configuration.
> 
> Fixes: 6d4036a1e3b3ac0f ("pinctrl: sh-pfc: Initial R8A77990 PFC support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
