From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:29:24 +0000
Subject: Re: [PATCH 08/15] pinctrl: sh-pfc: sh7269: Add missing PCIOR0 field
Message-Id: <20181217142923.iuhs2a2b25xcnzoj@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-9-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-9-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:07PM +0100, Geert Uytterhoeven wrote:
> The Port C I/O Register 0 contains 7 reserved bits, but the descriptor
> contains only dummy configuration values for 6 reserved bits, thus
> breaking the configuration of all subsequent fields in the register.
> 
> Fix this by adding the two missing configuration values.
> 
> Fixes: f5e811f2a43117b2 ("sh-pfc: Add sh7269 pinmux support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
