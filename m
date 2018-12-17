From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:03:55 +0000
Subject: Re: [PATCH 04/15] pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
Message-Id: <20181217140355.rthk7ydbwskb5o7h@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-5-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:03PM +0100, Geert Uytterhoeven wrote:
> The Peripheral Function Select Register 11 contains 3 reserved bits and
> 15 variable-width fields, but the variable field descriptor does not
> contain the 3-bit field IP11[25:23].
> 
> Fixes: 856cb4bb337ee504 ("sh: Add support pinmux for SH7734")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
