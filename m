From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 23 Mar 2015 08:32:57 +0000
Subject: Re: [PATCH v2 4/4] i2c: slave-eeprom: add more info when to increase the pointer
Message-Id: <20150323083257.GK5664@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1427099199-3628-1-git-send-email-wsa@the-dreams.de>
 <1427099199-3628-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1427099199-3628-5-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

On Mon, Mar 23, 2015 at 09:26:39AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> It is a bit subtle when to correctly increase the buffer index when
> reading. Make this clearer by adding some more comments and pointers to
> the docs.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
