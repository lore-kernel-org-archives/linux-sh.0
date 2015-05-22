From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 22 May 2015 23:32:45 +0000
Subject: Re: [PATCH v2 0/2] Fix OF match for adxl34x driver
Message-Id: <20150522233245.GB20687@dtor-ws>
List-Id: <linux-sh.vger.kernel.org>
References: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, May 21, 2015 at 01:42:24PM +0200, Geert Uytterhoeven wrote:
> 	Hi Dmitry,
>=20
> This is a resent of a series by Laurent Pinchart to fix OF matching for
> the adxl34x driver.
>=20
> According to the discussion in response to that series, we were under
> the impression this was going in through the input tree
> (http://www.spinics.net/lists/linux-i2c/msg18293.html).
>=20
> In input patchwork, the series is still marked "Awaiting Upstream"
> (https://patchwork.ozlabs.org/project/linux-i2c/list/?state=3D*&q=ADxl),
> but actually we are waiting for you, as we can't update the affected DTS
> before the driver fix has gone in ;-)
>=20
> From Laurent's submission:
>=20
>     This patch set fixes OF matching for the adxl34x driver when the DT
>     node lists a device-specific "adi,adxl345" or "adi,adxl346"
>     compatible value first.
>=20
>     The first version (see
>     http://www.spinics.net/lists/linux-i2c/msg18107.html) added an OF
>     match entry for the "adi,adxl34x" compatible string. The discussion
>     that followed concluded that that compatible string should be
>     deprecated and that the driver should match the device-specific
>     strings instead.
>=20
>     The first patch thus deprecates the "adi,adxl34x" compatible string
>     by removing it the DT trivial devices list, and the second patch
>     then adds an OF match table to the adxl34x driver.
>=20
> Thanks for applying!

Applied and sorry for the delay.

--=20
Dmitry
