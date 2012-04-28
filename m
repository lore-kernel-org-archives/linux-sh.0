From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Sat, 28 Apr 2012 15:26:13 +0000
Subject: Re: [PATCH v2 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335626773.1917.3.camel@koala>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-towusb8ws+Ppq5y3yFMw"
List-Id: <linux-sh.vger.kernel.org>
References: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1335362618-4559-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-towusb8ws+Ppq5y3yFMw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-25 at 16:03 +0200, Bastian Hecht wrote:
> changelog:
>   - extract the iounmap calls from patch "Add support for error IRQ" into=
 a new patch.
>   - swapped patches "Add support for error IRQ" and "Add error IRQ resour=
ce"
>   - corrected an indentation mistake

Unfortunantely, I cannot build-test your patches because mackerel
defconfig still does not build (mackerel_defconfig). Any suggestions how
to work this around or any other defconfig to use?

--=20
Best Regards,
Artem Bityutskiy

--=-towusb8ws+Ppq5y3yFMw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPnAwVAAoJECmIfjd9wqK0CjoP/24SojzXorFYvJliSKyMJfwv
Xl5L8LsP98fu1A4xXVpa9wyIU3mxjXM1tWpDN0g/+rwrjjU4cKkgusfRHzQ3/+hp
Et4hKi5chXZ0+jWMJG2TSesFkYgsL5jxpU+b8g3603sZDiodoxP595/PItTZuVd9
mM7tT+9nxELgzZVfCf5cMyeC7Q0jk8h1guZZ25Q93NZX9D/TFR1bh5Q8c6JJDoUL
8CpJ1wc/7RdtvAEB8UsZyCLWXlBIjYd0p3JCyR/xtJwot8DH9TAlapvbXn4DuFfd
lOBzSmuzQOSD2wr7h8rvUtU67KDtU2evfq5FP8qiv08znZ9uT4azS7yUHRpL4Wld
Rz4YrlzDY1d4KFWGXZjTa75DwpFP/FNqp85Wh5ZocefjqbDzsoNUsmLT6D/qtsVL
XIe9Iek9PUVEqkeiHLsV9mliO7sup464mVbUPdr73+2kdWfv29SI/TaI7BwnO9ts
J0vkGXDSNhEm1kaiqaMcquOjugwDjaNM8jpujosa3IpzpOrIpFW51MyrhFNq9Fpv
c8xc+B4vkhpoLEWqbnQuGkNj2mBN0Viero3hdgRdfWbjnuPomltGsnZTRm+swBfF
54hc0mQHM6+0Z6AoMyT3sSJsvlpYeONnAhfN7R+ApCoyTOzOexzPjhW5QWWbkMHj
dLUdh+X/I6wsHhmTPK79
=4Ea0
-----END PGP SIGNATURE-----

--=-towusb8ws+Ppq5y3yFMw--

