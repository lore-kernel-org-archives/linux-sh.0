From: Mark Brown <broonie@kernel.org>
Date: Mon, 01 Sep 2014 15:13:56 +0000
Subject: Re: [PATCHv1 1/7] ASoC: simple-card: Merge single and muti DAI link code.
Message-Id: <20140901151356.GB29327@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WnjMQ0y5QpAQNNgT"
List-Id: <linux-sh.vger.kernel.org>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
 <20140901133412.GA11312@lunn.ch>
In-Reply-To: <20140901133412.GA11312@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, jsarha@ti.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, shawn.guo@freescale.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>


--WnjMQ0y5QpAQNNgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 03:34:12PM +0200, Andrew Lunn wrote:
> On Mon, Sep 01, 2014 at 12:29:35PM +0800, Xiubo Li wrote:
> > This patch merge single DAI link and muti-DAI links code together,
> > and simply the simple-card driver code.

> It would be good to note that this breaks the Binary API with DT
> blobs. Old blobs will not work with this new C code.

That's not on, we need to maintian compatibility with the old DTs unless
there's a very strong reason not to.  Revising the binding is one option
for doing this, keeping the old binding in place and making a v2 binding
with the new functionality.

--WnjMQ0y5QpAQNNgT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBI0xAAoJELSic+t+oim9z7IP/RoOAxgrSgXiS0mfFZwRC1Y0
WalauVxeKhP+mO36WOOxw9ZRx3u8BLIZQfKstRm+yypXmaOw9K6PF6Vde2KbhtL5
1ZtvVRHA1eLb07xKoPbZzlf3MmGxuKqjmS8j/vHLO2V0tb8iK0wGRAPrbl+/zSvw
DO10krrG/NlzGDw7ol6eM/WJFvDd7XdZbNStILVg+pVekoxMXwwYAZrJRI/HcHZf
9zu7dZcbNxRpadVh+/+0qhTHu9HhQ8Y6R1FJjRASTbs4sB0RPJ9iMF6iWDycXIsW
g7/OTg+lFiBxICEYQfxamfG0SDIPoDkWgnLOyU8Z6Xd1pWr0VCYCNICUOukYmIt6
SzDKj3QLvy0Q5VIi8l7kPw7j7BgWXxq0HQ2G22rl7Vs4JAf1txUcJkBBkgHjJyqy
BsWqcym7mU9Jt7ymLqsJvnsJxs2UkQ1yn8Y7kP7qvW3W8Rydqv6H527hSjSCkfZ6
ex21VZlKYGh/FraX7VLk0NTfqSK3E/qQ48K3eb43DGbOktnb48f8T17zqWRNlQeL
tkFIZILgzxSApuGlcbf5p8j6AXw8vebNFRT6xVKToKcwyemR58iVziHDnnXg3dHn
rjA3ExkOzAuSyuxM2K+s8oW2wZXHzMfXRvcTYsGjbB9N25bHln5jDpZV6voUMWs8
zeN1szFASOijgyUQimyh
=Zl56
-----END PGP SIGNATURE-----

--WnjMQ0y5QpAQNNgT--
