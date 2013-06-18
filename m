From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 18 Jun 2013 08:05:30 +0000
Subject: Re: [PATCH v7 0/3] SH pinctrl DT support
Message-Id: <CACRpkdZh709J3pFsfbReQ20LU5W0Q1HacE0ZpssWXofKTJJ6pQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1371495003-11185-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1371495003-11185-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, Jun 17, 2013 at 8:50 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Hello,
>
> Here's the seventh (and hopefully final) version of the SuperH and SH Mobile
> pin controllers (PFC) DT support patch set.
>
> The patches have been rebased on the for-next branch of the pinctrl
> repository. All ARM-specific patches have been dropped and will be pushed
> through to ARM SoC tree in v3.12. This series thus only contains DT support
> for the sh-pfc driver.
>
> I've tried merging Simon's latest tag (renesas-next-20130617v3) with these
> patches and no conflict occurred. Linus, would it finally be possible to get
> this applied for v3.11 ?
>
> Changes since v6:
>
> - Added generic pinconf support back
> - Dropped all ARM-specific patches

Thanks, this looks really nice and I've applied all three.

Heiko, James can you have a look from a generic pinconf
point of view so we are sure we get this right? (Looks right
to me atleast.)

Yours,
Linus Walleij
