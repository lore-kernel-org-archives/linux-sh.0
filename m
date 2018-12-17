From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 13:48:22 +0000
Subject: Re: [PATCH 03/15] pinctrl: sh-pfc: r8a779980: Add missing MOD_SEL0 field
Message-Id: <20181217134821.ha3cexmm2cw762ip@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-4-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-4-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:02PM +0100, Geert Uytterhoeven wrote:
> The Module Select Register 0 contains 20 (= 5 x 4) reserved bits, and 12
> single-bit fields, but the variable field descriptor lacks a field of 4
> reserved bits.
> 
> Fixes: f59125248a691dfe ("pinctrl: sh-pfc: Add R8A77980 PFC support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
