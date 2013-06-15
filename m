From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 15 Jun 2013 23:51:32 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <CACRpkdYi=ekV8okmz68HZ8Ydv9hTrHnHvQh0HYMs5SfURd9mdA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CACRpkdaF7V3FGhNNj+N+Dc-NWhsfQ=bqh+ETx0wGBFbLmxfGTw@mail.gmail.com>
	<201306152216.14252.heiko@sntech.de>
	<1795038.rqcr6GWLdP@avalon>
In-Reply-To: <1795038.rqcr6GWLdP@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, James Hogan <james.hogan@imgtec.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Sun, Jun 16, 2013 at 1:35 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday 15 June 2013 22:16:13 Heiko St=FCbner wrote:
>> Am Samstag, 15. Juni 2013, 21:56:05 schrieb Linus Walleij:

>> Disable would the be either
>>       bias-disable;
>> or
>>       bias-pull-up =3D <0>;
>>
>> A driver should probably handle both, as both are valid pinconf options =
or
>> this.
>
> I feel a bit uneasy about that. Do we really need to support two different
> ways to achieve the same result ?

In this specific case I think yes, but not on all options.

As dicussed earlier this was designed for systems where
you could set the pull-up resistance, like

bias-pull-up =3D <600000>;

would give 600kOhm pull up.

In most existing systems that is silly, as they can't specify
it, so they should be able to do just:

bias-pull-up;

as that is all they can do. If we have to cut one way, we
should cut the former until such a system appears.

Yours,
Linus Walleij
