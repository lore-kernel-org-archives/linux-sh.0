From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 01 Dec 2015 10:13:35 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: sh7734: Add missing cfg macro parameter to fix build
Message-Id: <CACRpkdawUfss2NDwLfEPEJQZ+YifqtbHg+xOX7qsYkrNmBZjUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448455933-20276-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448455933-20276-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Nov 25, 2015 at 1:52 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> When building for SH7734:
>
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:1: error: macro "_GP_DATA" passed 5 arguments, but takes just 4
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:2: error: '_GP_DATA' undeclared here (not in a function)
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:1: error: macro "_GP_DATA" passed 5 arguments, but takes just 4
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:586:1: error: macro "_GP_DATA" passed 5 arguments, but takes just 4
>     ...
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:1: error: macro "_GP_INOUTSEL" passed 5 arguments, but takes just 4
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:53: error: '_GP_INOUTSEL' undeclared here (not in a function)
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:2: warning: initialization makes integer from pointer without a cast [enabled by default]
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2389:2: warning: (near initialization for '(anonymous)[0]') [enabled by default]
>     ...
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:1: error: macro "_GP_INDT" passed 5 arguments, but takes just 4
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:47: error: '_GP_INDT' undeclared here (not in a function)
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:2: warning: initialization makes integer from pointer without a cast [enabled by default]
>     drivers/pinctrl/sh-pfc/pfc-sh7734.c:2416:2: warning: (near initialization for '(anonymous)[0]') [enabled by default]
>     ...
>
> Add the missing "cfg" macro parameters to the sh7734-specific
> _GP_DATA(), _GP_INOUTSEL(), and _GP_INDT() macros to fix this.
>
> Fixes: 22768fc60abbf58b ("pinctrl: sh-pfc: Add macros defining GP ports with config flags")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied for fixes.

Yours,
Linus Walleij
