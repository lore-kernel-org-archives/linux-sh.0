From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 04 Feb 2015 08:40:48 +0000
Subject: Re: [RFC/PATCH] pinctrl: sh-pfc: Accept standard function, pins and groups properties
Message-Id: <CACRpkda6H7hbgXhmSbgtwOC_8PbHnES5syp-YEp1+V6s5Ym6Cw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CACRpkda4SBof0EaZVWtEYaeb6j_BGAVj39kje+mBz90eB3qAwQ@mail.gmail.com>
	<1422390694-12389-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422390694-12389-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sascha Hauer <kernel@pengutronix.de>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niso@kth.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

On Tue, Jan 27, 2015 at 9:31 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:

> The "function", "pins" and "groups" pinmux and pinctrl properties have
> been standardized. Support them in addition to the custom "renesas,*"
> properties. New-style and old-style properties can't be mixed in DT.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
(...)

>> Would be nice if the PFC driver could be augmented to also accept the
>> now standard bindings "groups" and "function" simply :) we're adding parse
>> functions for those to the core.
>
> Something like this ?

Yes :)

> Please note two differences between the Renesas PFC bindings and the standard
> bindings:
>
> - The standard bindings state that a pinctrl node must contain either a "pins"
>   property or a "groups" property, while the Renesas bindings allows for both
>   to coexist in the same node.

Sascha also says this makes sense for him so I guess I'm getting a bit
soft on the issue.

> - The standard bindings don't allow a pinmux node to contain a "pins" property,
>   while the Renesas bindings do.

Does that mean "pins" affect the muxing or that "pins" is about some per-pin
config shoveled into the same node?

The former is not OK, the latter is.

>                 mmcif_pins: mmcif {
>                         mux {
> -                               renesas,groups = "mmc0_data8_0", "mmc0_ctrl_0";
> -                               renesas,function = "mmc0";
> +                               groups = "mmc0_data8_0", "mmc0_ctrl_0";
> +                               function = "mmc0";
>                         };

So that looks just very nice.

>                         cfg {
> -                               renesas,groups = "mmc0_data8_0";
> -                               renesas,pins = "PORT279";
> +                               groups = "mmc0_data8_0";
> +                               pins = "PORT279";
>                                 bias-pull-up;

And here I can't see the use of "groups" in this node since it
doesn't match a function. It's a bit ambiguous what "groups"
mean when you run into it like this.

Yours,
Linus Walleij
