From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 11 Mar 2015 10:35:31 +0000
Subject: Re: chosen/stdout-path and userland (Re: Can't boot kernel v4.0-rc2 on Koelsch)
Message-Id: <20150311103530.GA5491@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVSbYYGQyOjce87Q_dMHvh9du1EkgOgC+CBgrMys++mkA@mail.gmail.com>
In-Reply-To: <CAMuHMdVSbYYGQyOjce87Q_dMHvh9du1EkgOgC+CBgrMys++mkA@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Sakato Ryusuke <ryusuke.sakato.bx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Hence all pieces of the puzzle are available to userspace...
> Is there another way?

My hackish way is to parse dmesg, adapt inittab at runtime and make init reload
it. Not exactly production quality, though:

+       l=$(dmesg | sed -n '/console.*enabled/ s/.*\[\(tty[A-Z]\+[0-9]\+\)\].*/\1/; T; p; q')
+       sed -i s/ttyS0/$l/g /etc/inittab
+       kill -s SIGHUP 1


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVABpyAAoJEBQN5MwUoCm21FUP/ippJokK40piQ33oHxSR8isI
OBLb3irGY/JGfIHtgN7oqICeIjRyhEMS1H3epLhpozVLEMI3ubKSlWiRy+W2ABmh
6DOj0MY3/ijNCH5lIQuvdLA5vlBHFSL3lbzBK+Wkr04HuS5PfBuFu4woTJ0R6iX1
wsoII5XYu953xB/WdIwmRp5R2ILFOIenhCzR1DbpIWfSMzCInU3a2BGYRShx2q54
6wBdSGSGoY1d+hx9pONfgw3La17tQwW38wrz9exQdP8fY6wuvh8viL8IugWAAe0O
zDILSFYdMxGNlYztSBVzUimsdcBsB2Bse6mYlP97C/z7f/wCRV8fEexzldSKGZcr
XxmUAMxI26vE2H0SQLI7e6wjQQBGtSm5oZAb/PXJk5KlS8EQRTije7Yz6xT2WOet
K9Wfd4/fwz7lTxGua7oC1VECx/g97XchfqUqMMd6ZP9dcsSm/BG5IC0sC3UxUSDU
sApIJtoq0bJUzywTno5i321DjtgVVdJ0EBixY30yuGY0WbYK6LTUAQLuO/6lK4s+
NysG/GsdYDgwKEbGs5GiDVTMQrYqOwlb2A583h+JTimm/DYoqVgHjIvZyp3su4xF
CzrbxcqHkjqJSqi1Z4AmAeAwd1StoHtBW51RdYe2S0ZThIjLtlyM6swgiVX9bZ7B
g2Bw8TRTIQJEkg1soVKM
=zwOF
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
