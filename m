From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 09 Mar 2015 16:37:30 +0000
Subject: Re: [PATCH 3/4] pinctrl: sh-pfc: Use u32 to store register data
Message-Id: <CACRpkdbDNu55E6Cd+w29koWiQQ=wpAkG_feg6ap2U_LuBgYueg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Feb 27, 2015 at 6:38 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> As PFC registers are either 8, 16, or 32 bits wide, use u32 (mostly
> replacing unsigned long) to store (parts of) register values and masks.
>
> Switch the shadow register operations from {set,clear}_bit() to plain C
> bit operations, as the former can operate on long data only.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
