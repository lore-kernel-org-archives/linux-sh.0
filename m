From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 23 Oct 2015 12:14:39 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <20151023121439.GK13380@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W2ydbIOJmkm74tJ2"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <2048622.tkxROUAu7P@avalon>
 <20151023094500.GD13380@katana>
 <36149610.Eic43bQLgJ@avalon>
In-Reply-To: <36149610.Eic43bQLgJ@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--W2ydbIOJmkm74tJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > :/ Let me know if I can send you debug output.
>=20
> What's the exact issue ?

Best report ever: I simply don't get a picture :) No warnings, no
messages. I think we want to make sure my HDMI->DVI converter is proper,
though.

> > > .config attached.
> >=20
> > That one also probes for me... I only disabled DHCP and added my initra=
mfs.
> > I patched the fbdev build error out and changed Lager dts to use i2c-rc=
ar
> > (instead of i2c-sh_mobile).

I made the ADV7180 and AK4642 built-in and this kernel still probes
rcar-du on my Lager and Magnus' Koelsch...

>           <idle>-0     [000] d.h1     1.498063: rcar_i2c_irq: msr 09090909
>           <idle>-0     [000] d.h1     1.498075: rcar_i2c_irq: msr 08080808
>           <idle>-0     [000] d.h1     1.498266: rcar_i2c_irq: msr 07070707
>           <idle>-0     [000] d.h1     1.498348: rcar_i2c_irq: msr 06060606
>           <idle>-0     [000] d.h1     1.498465: rcar_i2c_irq: msr 49494949

So, here is the NACK bit set. Which does not happen on my Lager and
Magnus' Koelsch. I am starting to wonder if you have a board with HW
issues? Could it be another I2C device interfering? Do you happen to
know if you have an earlier revision of Koelsch?

Thanks,

   Wolfram


--W2ydbIOJmkm74tJ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKiSvAAoJEBQN5MwUoCm2bdUQAIq1ZRAlZBs6jYSv11i9F1yO
cp82aYXyuXXPGQDZLBncDc9aWyFpG7uHTDe8L+/7fgtAvnRwIlY+vzOh1M8/6eS4
IjtAtk1o0XMhv8YE/7qRcOUBT64zQvpapYWcWCleih8CT0+EeuGNnyUWGKJXeyoM
JPT6vdlNU2fUdNf7qdhMwqqR5TjVDK+BQaovOD4IO+vRlrM1wPWypGPueFRm99xm
VyR9EqaYfBnx4W7Ip/K7ujOW2aejvM5+cAo/BCm+uLT5qbEOIaOsevy5GAJPw2p4
d9O/DjyhYczlum6tzDNo+8FfhRyDNft2qeLcjwuY2sfv0slpSjhLMguyOwcNHbL1
ibwxDrdxDrBqUXnD7XkKcJBWO+dvufWA+TGANBnOQ3qQiLxGtICMeGSbOdtSSaId
EVA/oEwK6KLmy5AbXUwnPCEREeRTG1mHSEUpEXyMp1Gi16UkSOQvCOIW2NJDwPa9
XFfez1BL7YyPnQtH3W0bxDs7v7nu6WHrmCDgRUuw2Jgs2J8x3jpAkdWQMVb7KzQo
OtY5coX4A7BsF2OUzSoTSg1sdC7GnbY/UtdPwAw/nxKNv7ZXKN/u06rwkE/6gESz
IwvEIhGsBGqvqHWpn/Ihn6En9bams9p1iQmLPNFu1UJCW12I4GZBKAqGJp6Vm5r0
Rc6gkD2WbhlHXMlGhYaz
=Yg2e
-----END PGP SIGNATURE-----

--W2ydbIOJmkm74tJ2--
