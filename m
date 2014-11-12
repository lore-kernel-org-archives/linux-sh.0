From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 12 Nov 2014 16:11:47 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141112161146.GE4031@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ep0oHQY+/Gbo/zt0"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <1415355104-2031-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1415355104-2031-3-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 07, 2014 at 11:11:41AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Make it possible to transfer i2c message buffers via DMA.
> Start/Stop/Sending_Slave_Adress is still handled using the old state
> machine, it is sending the actual data that is done via DMA. This is
> least intrusive and allows us to work with the message buffers directly
> instead of preparing a custom buffer which involves copying the data
> around.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

Applied to for-next, thanks!

One minor change:

-			i2c_op(pd, OP_TX_STOP, data);
+			i2c_op(pd, OP_TX_STOP, 0);

To prevent uninitialzed var usage.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUY4bCAAoJEBQN5MwUoCm2i4YP+wbsfz+IBdb6tdASw0SKkngI
QkR/vC5+uGdJXevFqV8s9U/1JaTKRioaLjCr5hhxl16axNDmNBkfDvg+puAsohRB
z3JIAfLiy8zAY7pVlYOBEHLWBmx9r6kiD9G3RGzdAIWfKyuzz+Auos9832mr7w6Z
ca3yeC2BHAKpC5+ScXVDD1LlqV6keUmgK8dyrb5JdKKgeFyRVc/aJ3G5VYAKsWgS
rg42UlYJEUQVEhl0ss7i51Jn0/bzHiFs97Gy7LRjH17H4Rb//sL4n9eyjhgFZLvh
thmLm6zhcSjSLsJc+/hVX2cu5oZILzE/d2FXA2i+0/YZYLbrjzvSN1oNJdSz4ox5
nFr5hpGusYyAvEHfnKL8gK5LYrdbTRPzCcJmLTsie6Ru6FqURol2Srcpmtc1H56y
D4bildpdj9UUs+YS3fWDhjx9pExZ5t1OKZLhxgUpN3Jls2ytlZeYAILjOayVcPjX
O+LDt1NOngXSW3jSQNlXQPp02dAedd1otTPv0IfdkPfBKoQrXlyHVJ7f3wbxF+Oe
TXEbIH7RzCgX306M6KHdhYqf/hfzJ+td7+Cw12iUdwkuirnE0RacB0/su7tPx97O
4TuW3I0eCcZvVt4bDgO/h2jG4vA06Dje/7Q0fEuMEJvNzEw/YRbzNm31UnFKtmJH
vplgtQP9BBbmWZPctPt3
=FP49
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
