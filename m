From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 12 Jun 2013 09:24:38 +0000
Subject: Re: [PATCH v5 01/22] pinctrl: generic: Add DT bindings
Message-Id: <CACRpkdYev+hapkM075Sw7Yi0u+XpRvL74SwT39DV1aV1RtHC+Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370989371-30846-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1370989371-30846-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1370989371-30846-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, Jun 12, 2013 at 12:22 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> Document DT properties for the generic pinctrl parameters and add a
> parser function.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

It appears we have a race here, as something like three people,
or four, happened to do generic pinconf bindings at the same time.

Yesterday I applied Heiko St=FCbners patch
"pinctrl: add function to parse generic pinconfig properties from a dt node"
doing basically the same thing. With subtle differences...
but it already supports schmittrigging and some more.

It appears to be close to your idea though!

Would it be possible for you to look at what I have on my "devel" branch
now (same as submitted for -next), rebase on that and patch any problems?

> +               if (param->flag) {
> +                       ret =3D of_property_read_bool(np, param->property)
> +                           ? 0 : -EINVAL;
> +                       val =3D 1;
> +               } else {
> +                       ret =3D of_property_read_u32(np, param->property,=
 &val);
> +               }

This construct is done differently in Heiko's code, please
review it so we know we have a nice, efficient parser.

Yours,
Linus Walleij
