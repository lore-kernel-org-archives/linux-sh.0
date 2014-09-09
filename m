From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 09 Sep 2014 16:34:15 +0000
Subject: Re: [RFC 2/4] i2c: slave: add eeprom simulator driver
Message-Id: <20140909163415.GA1781@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
List-Id: <linux-sh.vger.kernel.org>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
 <1410274470-12712-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410274470-12712-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +config I2C_SLAVE_EEPROM
> +	bool "I2C eeprom slave driver"

This should be "tristate". Fixed in my branch.


--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUDywHAAoJEBQN5MwUoCm2AkQP+wXcw+8bfng9AY654kJpP2f4
l2rpU2Dy1TUlXeNJnLQc8g5NnB55vTxamBYsLLBVWOC2n6d5Dmd0HvyoPXzAjCPl
ecUzBxmUtGk9zbDvFRzSpsJB6LbHqmUSrBL6J/7dFpc8FVOI/piURwCdom9uVStw
67f687huNm2s580A8niRqryWKeSH+dpF85kGhCLF4VYvGgNQhB3fcHvrRkxU5FYy
qUGTs+kdVRjwn8gSLS1kOiovyRHir/Db8OwlAl7KSW2XZDea8ZNb6w5tuUK4UfKP
h3Vymbes8k8q5Oguekbbi+ZAWj4EwGydNKdxmeSSv4Cf5IhBXf9O4XdliyfNs06P
dwWlQvyF9LF0Uy25K8DxjzzeJ4UdV13BljYhxQr99PJDMYvjtEAbmKmYkQiMIxii
sUgB23AZKl9b8eOGtLB5J2NmMegSZg8uNDGLVfasJ8Qdn8FEETga5dGqQUith7ta
tht4u0+KGRn8eK6MKoU8o4X5r3jY4U+22OEYKtnVxoZzVnOMvfj0tV4rxwrJIwGB
7mBAsrO85oFG8EXxZrevnn3y0uXzJq84LpHswfamWvC871o7grQs8djXowc/FfYa
9p0hS3OZS4ha2tYIA/MtCGARxtDlRAuw5tCSW9K7rMNRh7MP7qq54W8YUyla0MGP
E1qf9XH5l3B41zkIyMZN
=Of2l
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
