From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:07:24 +0000
Subject: Re: [PATCH 06/15] pinctrl: sh-pfc: r8a77995: Remove bogus SEL_PWM[0-3]_3 configurations
Message-Id: <20181217140723.l76nsznmu7exzqha@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-7-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-7-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:05PM +0100, Geert Uytterhoeven wrote:
> While the SEL_PWM[0-3] fields in the Module Select Register 0 support 4

s/support/supports

> possible configurations per PWM pin, only the first 3 are valid.
> 
> Replace the invalid and unused configurations for SEL_PWM[0-3]_3 by
> dummies.
> 
> Fixes: 794a6711764658a1 ("pinctrl: sh-pfc: Initial R8A77995 PFC support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
