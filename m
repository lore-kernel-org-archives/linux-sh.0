From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 13:38:08 +0000
Subject: Re: [PATCH 01/15] pinctrl: sh-pfc: r8a77994: Remove bogus IPSR9 field
Message-Id: <20181217133808.6pxaudvjh5y7u2vq@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-2-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:00PM +0100, Geert Uytterhoeven wrote:
> The Peripheral Function Select Register 9 contains 12 fields, but the
> variable field descriptor contains a 13th bogus field of 3 bits.
> 
> Fixes: 43c4436e2f1890a7 ("pinctrl: sh-pfc: add R8A7794 PFC support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
