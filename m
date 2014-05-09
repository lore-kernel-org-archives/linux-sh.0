From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 09 May 2014 05:06:10 +0000
Subject: Re: [PATCH V2 2/2] ARM: shmobile: r8a7791: add i2c2 bus to koelsch dt
Message-Id: <20140509050610.GB2624@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
List-Id: <linux-sh.vger.kernel.org>
References: <1392633882-12142-1-git-send-email-wsa@the-dreams.de>
 <1392633882-12142-2-git-send-email-wsa@the-dreams.de>
 <536C1945.1000601@cogentembedded.com>
In-Reply-To: <536C1945.1000601@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >+	eeprom@50 {
> >+		compatible =3D "renesas,24c02";
>=20
>    This is not quite right: Renesas' part is called differently, and
> you're carrying the other vendor's naming onto Renesas parts. I'd
> just say "24c02" (which I'll do in the Henninger board patch).

What about "generic"?


--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTbGJCAAoJEBQN5MwUoCm2i/QP/iaeXucXLG/+TAXh1ulpgFzw
70sef2Er/aE+CVfBWtFk1mdhCGKujB2cAUUQ+09PgdIbp4TaD76GawHL9c2hjpZx
bz4YeTg+LDjKubyhdo+FTRclUpoboARyq35PirVQCnNwatD9oTvaaL7RoPlQiYdT
K5inc/cIdD1GGitwjWAaxFeln3+jPBaXa6Dca5ZHL6HTNJ03l/vDtkC3Gex2a4Fy
ffxDrx6mkZ6far2GSc0G0MamLZrSQr/YWFE36EqKoDncfiXNZfSe+d1MyH8tbMJI
3o57bVsIhAPmtg9ehRs7CR8NzwX5qjeHqkFcugWr/4uBGyFQ3MeZD67/m9omQ/TF
4kzLo5H9vYbzZ0AfrJG4aKeFwxW9KsrE7rWbee5GusBC9PkzTFSSpubXha0ie0HT
jCybJZYrT7tA2akP9QcR28IMG30sdyUERhNeQUmOXQPF5Eeyw+1IMn8aftolcaju
3Db+puB2Mc6MCX07dRB1jDz8O6cWi/HnLpPij0KnnkZSRa4tLwHld+fqFLbwAoEN
Xjgik7xCZZYVfThCmy5SXG2mrrp1XRBwT+BbN3vR/K+9gr8uQXWTH4sOZ9wTIDwj
hAWMsG94Zo2RGHRT75cGomtSecgqTPt8zN+OzPCN6sER1/G5ReQyJyU5UNZgIA55
1PUyjBcA+P4XNxCKVblQ
=UuiL
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
