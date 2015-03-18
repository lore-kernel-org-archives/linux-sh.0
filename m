From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 18 Mar 2015 01:14:15 +0000
Subject: Re: [PATCH v3 2/4] pinctrl: sh-pfc: Use unsigned int for register/field widths and offsets
Message-Id: <CACRpkdZxueV1uqbD1PabrwUsV=xfys+Gq=TN5bu47O3sgWjrZw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426154956-26583-1-git-send-email-geert+renesas@glider.be>
	<1426154956-26583-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426154956-26583-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Thu, Mar 12, 2015 at 11:09 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As register and field widths and offsets are in the range 1..32, use
> unsigned int (mostly replacing unsigned long) to store them in local
> variables and for passing them around.
>
> Move to one variable per line, move variables to the beginning of the
> block where they are used, and drop superfluous initializations while we
> are at it.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v3:
>   - Remove superfluous initializations of local variables,
>   - Add Acked-by,

Patch applied.

Yours,
Linus Walleij
