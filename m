From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 19 Jun 2013 21:52:54 +0000
Subject: Re: [RFC] pinctrl: generic: Add DT bindings
Message-Id: <51C22836.9090909@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1370988237-30593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2555796.PtkImJGaK8@avalon>
 <CACRpkdaF7V3FGhNNj+N+Dc-NWhsfQ=bqh+ETx0wGBFbLmxfGTw@mail.gmail.com>
 <201306152216.14252.heiko@sntech.de>
In-Reply-To: <201306152216.14252.heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

On 06/15/2013 02:16 PM, Heiko St=FCbner wrote:
> Am Samstag, 15. Juni 2013, 21:56:05 schrieb Linus Walleij:
>> On Fri, Jun 14, 2013 at 12:39 AM, Laurent Pinchart
>>
>> <laurent.pinchart@ideasonboard.com> wrote:
>>>         mmcif_pins: mmcif {
>>>        =20
>>>                 mux {
>>>                =20
>>>                         renesas,groups =3D "mmc0_data8_0", "mmc0_ctrl_0=
";
>>>                         renesas,function =3D "mmc0";
>>>                =20
>>>                 };
>>>                 cfg {
>>>                =20
>>>                         renesas,groups =3D "mmc0_data8_0";
>>>                         renesas,pins =3D "PORT279";
>>>                         bias-pull-up =3D <1>;
>>
>> If I understood your code correctly that last statement can *optionally*
>> be written like just:
>>
>>  bias-pull-up;
>>
>> Without the parameter?
>>
>> I think that Heiko's implementation does this anyway.
>=20
> Yep, with the fixes-series from yesterday the bias-pull-* now have a bett=
er=20
> default value of <1>.
>=20
> so you can do
> 	bias-pull-up;
> which is then identical to the
> 	bias-pull-up =3D <1>;
> above (both are valid of course).

A property with a value is an integer. One without is a Boolean. The
same property shouldn't be both.

Regarding the value representing resistance: That feels pretty odd.
Enabling a pullup and selecting the pullup resistance feel like
orthogonal options which shouldn't be bound to each-other.

