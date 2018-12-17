From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:24:07 +0000
Subject: Re: [PATCH 07/15] pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
Message-Id: <20181217142406.pjhk67feprbkvzgq@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-8-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-8-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:06PM +0100, Geert Uytterhoeven wrote:
> The Port F Control Register 3 (PFCR3) contains only a single field.
> However, counting from left to right, it is the fourth field, not the
> first field.
> Insert the missing dummy configuration values (3 fields of 16 values) to
> fix this.
> 
> The descriptor for the Port F Control Register 0 (PFCR0) lacks the
> description for the 4th field (PF0 Mode, PF0MD[2:0]).
> Add the missing configuration values to fix this.
> 
> Fixes: a8d42fc4217b1ea1 ("sh-pfc: Add sh7264 pinmux support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
