From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 03 Feb 2015 08:52:04 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <1803320.jWEVcQJxer@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Monday 02 February 2015 14:24:44 Wolfram Sang wrote:
> >> +	sh_wdt_start(&priv->wdev);
> >> +	sh_wdt_write(priv, 0xfff0, RWTCNT);
> >=20
> > Is there a reason to set the counter to 0xfff0 instead of 0xffff ?
>=20
> Giving serial console some time to push out FIFOs. But yeah, it is an
> arbitrary value.

16 cycles as 32.768 kHz would be 488=B5s. Assuming a 115200 serial baud rat=
e=20
that would allow transmission of a bit less than 6 characters. I wonder if =

it's worth it. Shouldn't the restart core code instead flush the serial FIF=
Os=20
explicitly before calling the restart handler if that behaviour is desired ?

> >> +	priv->restart_handler.notifier_call =3D sh_mobile_wdt_restart_handle=
r;
> >> +	priv->restart_handler.priority =3D 192;
> >=20
> > Just for my information, how did you choose 192 for the priority ?
>=20
> Assuming DA9063 is 128, then I wanted to give this priority since it
> doesn't need I2C access which might be stalled.

--=20
Regards,

Laurent Pinchart

