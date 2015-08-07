From: Thierry Reding <thierry.reding@gmail.com>
Date: Fri, 07 Aug 2015 12:53:22 +0000
Subject: Re: [PATCH] drm: rcar-du: Fix plane state free in plane reset handler
Message-Id: <20150807125321.GE25792@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="o0ZfoUVt4BxPQnbU"
List-Id: <linux-sh.vger.kernel.org>
References: <1438820580-14301-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1438820580-14301-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org


--o0ZfoUVt4BxPQnbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 03:23:00AM +0300, Laurent Pinchart wrote:
> The plane reset handler frees the plane state and allocates a new
> default state, but when doing so attempt to free the plane state using
> the base plane state pointer instead of casting it to the
> driver-specific state object that has been allocated. Fix it by using
> the rcar_du_plane_atomic_destroy_state() function to destroy the plane
> state instead of duplicating the code.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 45 ++++++++++++++++-----------=
------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>=20
> Should the DRM core free the atomic state before calling the reset operat=
ion ?
> That would simplify drivers.

The core can't do that because drivers might have subclassed the state.

Reviewed-by: Thierry Reding <treding@nvidia.com>

--o0ZfoUVt4BxPQnbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVxKo+AAoJEN0jrNd/PrOhrNYP/1BtTw5/VJF+HI4zxqVfjjHG
8fj5nLR5d3dsTFuDfqCXPxVohz39c428uIGKBFPZV8LD/b08ob+7TfqhPQEFB+nh
tOt3xveqxirp/W8UrVOSV7uK00MvOfay8QVYslEp4GSlb/0sd3bJ3DJ8IgBICrOq
0PBYhUEQgoL0GACqkGKqbg3pZHsJ3mYIdAcufsntYhBs0ZnNzwZI7ZAUNaJp57YZ
Y6L+rABb57soQjZGNT+oNtHLfPIh7ya+xWAQvz0bgaIrnoN67PtDe+ZAHVUoAama
CQVjE8pGcofu3sT4KNbz2tIkWtgmH7H5IkDPL6Q6HqDH9wuYu2vFMFkTPO+TxM8T
8vZv7FbtPQVTAx1FNgk67IPXASZCbtHICwsiaPqYE22wqqOUXXmE3M/JZkmp4qbF
Slyv58B+hLzsH4PYprkseDzVj6FCNYCpTlwxy1Pql1DyemUK3hmXYgIrygbbJPZK
2Ycc9rNIHT9CeDFGwG/v/MtDkgIVPuJkY6tqnFiaQF7U9HsWAY6Eqy79hX1hwjpm
CKl6zJy9kjxSfp+rmWmjQQbVJFXyOsYbrcrd+jhMxARGmza4Bj+c4XoRq/CyqpXl
vn749dGDUqPcauJhVoU8HTym68MmA2KG3B/vk3Q0r+d0SkCzo/13P/921uciwt2x
Kaojkp7vO0WyLrphkGUV
=kxLZ
-----END PGP SIGNATURE-----

--o0ZfoUVt4BxPQnbU--
