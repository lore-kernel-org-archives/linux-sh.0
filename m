From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 06 Mar 2014 13:06:55 +0000
Subject: Re: [PATCH V2 01/12] clk: shmobile: add CPG driver for rz-platforms
Message-Id: <20140306130655.GA10657@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
List-Id: <linux-sh.vger.kernel.org>
References: <1394105552-9744-1-git-send-email-wsa@the-dreams.de>
 <1394105552-9744-2-git-send-email-wsa@the-dreams.de>
 <1434755.d9svPEINg5@avalon>
In-Reply-To: <1434755.d9svPEINg5@avalon>
To: linux-arm-kernel@lists.infradead.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +  - clocks: References to possible parent clocks. Order must match clo=
ck
> > modes
> > +    in the datasheet.
>=20
> I believe the order should be documented explicitly instead of referring =
to=20
> the datasheet.

I wanted to keep it generic in case future SoCs want to use the driver.

> > +	num_clks =3D of_property_count_strings(np, "clock-output-names");
> > +	if (WARN(num_clks <=3D 0, "can't count CPG clocks\n"))
> > +		goto out;
>=20
> You can return directly instead of goto out.

I personally don't prefer the mixture of goto and direct return. Please
say if you insist on that.


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGHLvAAoJEBQN5MwUoCm2SjYP/3TXkB67HLeWTWEKbjW4ZH34
ixpmPTiRzneVICzxt06EkSBi5BdXTb34oRp9/MlCAiKvyjiIoj4rogIUPquDPMR9
UUaQVXfCDNPRGw24qQwmX15/+D/fSSpfSbjlc0nBbNLhdSukGanBU7itH50Wilu9
K0GgXaZGkqqE+ckQlkPLuBlz+UYeVPmkNoop/kpnYHU5wZDTwCH5ru01blfksxhN
8EWzNUuU9q5FE0DbEdV9K9S6brpN7FQMCQPYi55LONR3pdfHc5m6VWcvD6yAs4pQ
kzhbC4TnYwogdFRt7Kmh6LMqNU30KQu0slEOZ1oyCgPT7hR8Q2+TJVVcx+5H0fFp
8GjQzJeqxYRNIiW/ByIJAZvScX4P36d4IbxGiXlYtfuJSm+tbUg6TwrCqV4DKXZp
NEBb5CtgHMByDN7r783TJOmNWsNQsnEKZXRzFEtyLRc8VzF04sMxiWffGxsgIU0f
IiAf7/I2q1EKM4h3bFipozMXa7Mgxb+WIs/Feqagy90IT2FWsFdw9YUd033wNbTw
CBN2kWOVdWaFV5It2seZDHu8WNNryIjYqlXZsTQ/9BHbvrm+pbe6EQKNNl9RABZ3
hXA3fwMqWn0Ok40kWwhe4tds4wgZxidkdieKAqWuJicT7FZ27AH4AJRf43adh8mn
4fNSZTNBovg2f+bONbri
=jDEV
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
