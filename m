From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 May 2012 17:12:49 +0000
Subject: Re: [Q] (intentionally) useless code in pinmux_config_gpio()
Message-Id: <CANqRtoTT6BBi9tij5JtQ+yPJC3b=k1fdc0mwLNJpHcn-iTWdsw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1205071836120.3564@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1205071836120.3564@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Tue, May 8, 2012 at 1:43 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi
>
> Looking at pinmux_config_gpio() in drivers/sh/pfc.c I came across code,
> that doesn't seem to have any effect:
>
> =A0 =A0 =A0 =A0while (1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (cfg_mode) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case GPIO_CFG_DRYRUN:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (condition)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> So, whether the condition in "if" above is true or false the loop just
> continues. Evaluation of the condition doesn't have any effect either. Is
> this really how it was intended?

I believe the break above is supposed to be an error condition.

So we are OK if the per-bitfield use counter is zero or if the
previously set value is same as we now request. Otherwise it's an
error.

If you can cook up a fix then that would be great. We probably want to
treat the fix as a feature to make sure it gets tested well instead of
blindly adding to -stable.

Thanks,

/ magnus
