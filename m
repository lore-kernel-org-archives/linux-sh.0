From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Sep 2015 12:13:58 +0000
Subject: Re: [PATCH 07/14][RFC] arm64: renesas: salvator-x: enable I2C
Message-Id: <20150910121358.GA1672@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
List-Id: <linux-sh.vger.kernel.org>
References: <87h9n2n3x1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9n2n3x1.wl%kuninori.morimoto.gx@renesas.com>
To: linux-sh@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +&i2c2 {
> +	pinctrl-0 = <&i2c2_pins>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};

I think we should add the bus speed here explicitly and not rely on a
default:

	clock-frequency = <100000>;

Maybe 400000 if all connected devices support that.


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV8XQGAAoJEBQN5MwUoCm2ggsP/3N5dT736rnCNfMzns41OZnA
yQi9fqruasHVMH6RIW/9AdWbx8sBGuBH7y6saALEzhdBSoAMct7YI9iodcGomjye
I6IZj1ZEPzng+qlRrx1tcrsjT5XlhM0T4jYxSajTn+pREaRX2k5EfUdUPvov+WGI
Bv8bBI3XRaj42G5SFvovHveO8/0DHgRG5YfRSljbeMYHaJkjp80BxQ7tJWeJkM6I
uWvyLVRSNOlMJ+n32z8Y4wpxY6jKaLNcy1C9X0mU52RhlGKVDve7mkmBzz6h/uga
jQLnDIhPWQ4R7MObSeHPK2sf4MyzH967s/sVmKQ1pnSzTvOjn6JHwFTWK9oZI5hK
+EtPDfK9bapxC8T/dxrZsF18I+yMI+d2nuK6Q/FzMF/P7S/9ZEPCmYOcs55Wnc4t
OMhxBor2NtZN1nBcwa7UOMO5ZKUxGHDfBZlhd3tuFAOc1Pze5Rhrd9nRRq5ytjIX
OS6cG1vrfWyub2f8zI2qM7zIbfG48D6LzNx1dgldbIy7iPQoRKKxr0QaBWVEE6Gs
K6TzpPxwxGSBQWAhZE68XgXmy58y0/WGZu9znd0iYAGznd8jZWickHl9tVmEgruJ
SiYkAUJScPbsaLhaq9h0OSxA9/Fy6pYD/HO1rLk839PHG3dTWbimN7aRnXPA7MVn
f+rJZazwpaqWn0JAbSiV
=Jc2W
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
