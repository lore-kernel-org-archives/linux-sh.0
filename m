From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:47:50 +0000
Subject: Re: [PATCH 12/15] pinctrl: sh-pfc: Make pinmux_cfg_reg.var_field_width[] variable-length
Message-Id: <20181217144749.abhi7rwc65vijlhs@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
 <20181213182714.26094-13-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-13-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

On Thu, Dec 13, 2018 at 07:27:11PM +0100, Geert Uytterhoeven wrote:
> pinmux_cfg_reg.var_field_width[] is actually a variable-length array,
> terminated by a zero, and counting at most r_width entries.
> Usually the number of entries is much smaller than r_width, so the
> ability to catch bugs at compile time through an "excess elements in
> array initializer" warning is fairly limited.
> 
> Hence make the array variable-length, decreasing kernel size slightly.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
