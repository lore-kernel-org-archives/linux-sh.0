From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Dec 2011 15:50:53 +0000
Subject: Re: [PATCH/RFC] mmc: add a device PM QoS constraint when a host is
Message-Id: <CACRpkdavEN4Ht425a5P9JfLttCqZ94-yH11GbxgV+mhvwHzGLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1112121642080.10378@axis700.grange>
	<4EE865CA.8000407@stericsson.com>
	<CACRpkdZnmCUfk0h+wK=KUvrv5oCudEAdEc_TY6=yZg_3uTqkgw@mail.gmail.com>
	<201112141128.56029.rjw@sisk.pl>
In-Reply-To: <201112141128.56029.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Wed, Dec 14, 2011 at 11:28 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, December 14, 2011, Linus Walleij wrote:

>> But this delta is dependent on a lot of stuff that only the platform
>> knows, like nominal CPU frequency, bus speed etc, so certainly the
>> platform must be able to modify that number.
>
> You seem to be confusing things. =A0The exact meaning of this number is:
> "I may want to use the device 100 us from now (but not earlier), so please
> make it possible to do that". =A0[It roughly means "don't put the device =
into
> a low-power state that takes more than 100 us to resume from", but it's a=
 bit
> more complicated than that.] =A0It doesn't mean "don't suspend the device=
 for
> the next 100 us".

Yes you're right, I get it now!

Thanks for the explanation Rafael.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
