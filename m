From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Thu, 19 Mar 2015 20:17:51 +0000
Subject: Re: [PATCH 1/3] i2c: slave: rework the slave API
Message-Id: <20150319201751.GZ10068@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
 <1426164123-8853-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426164123-8853-2-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrey Danin <danindrey-JGs/UdohzUI@public.gmane.org>, Marc Dietrich <marvin24-Mmb7MZpHnFY@public.gmane.org>, Debora Grosse <debora-HRUOeNTICTI@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello Wolfram,

On Thu, Mar 12, 2015 at 01:42:01PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> After more discussion, brave users, and additional datasheet evaluation,
> some API updates for the new I2C slave framework became imminent. The
> slave events now get some easier to understand naming. Also, the event
> handling has been simplified to only send one event per interrupt.
what is an interrupt here? An event where the bus driver needs feedback
from the backend?

Other than that the patch looks fine. Thanks for working on my feedback!
Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
