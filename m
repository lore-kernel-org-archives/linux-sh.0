From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 09 Jul 2014 10:34:01 +0000
Subject: Re: [PATCH RESEND] gpio: rcar: Add support for DT IRQ flags
Message-Id: <CACRpkdbh+xb-bdUufGLVByNyO8RuD=ii0Mb4OCYuZdaaSDevig@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <12008900.rC4lq8SXRG@avalon>
In-Reply-To: <12008900.rC4lq8SXRG@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <damm@opensource.se>

On Tue, Jul 8, 2014 at 12:46 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The gpio-rcar driver has no IRQ domain OF xlate function and thus
> ignores IRQ flags specified in DT. Fix this by using the two-cell xlate
> function.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Patch applied.

Yours,
Linus Walleij
