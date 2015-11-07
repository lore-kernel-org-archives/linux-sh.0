From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 07 Nov 2015 13:29:03 +0000
Subject: Re: [PATCH 1/3] PCI: pcie-rcar: Convert to DT resource parsing API
Message-Id: <20151107132902.GA21726@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-sh.vger.kernel.org>
References: <1446482175-26507-1-git-send-email-phil.edworthy@renesas.com>
 <1446482175-26507-2-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1446482175-26507-2-git-send-email-phil.edworthy@renesas.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2015 at 04:36:13PM +0000, Phil Edworthy wrote:
> The main purpose of this change is to avoid calling pci_ioremap_io() as
> this is not available on arm64. However, instead of doing the range passi=
ng
> in this driver we can utilise of_pci_get_host_bridge_resources().
>=20
> This is similar to changes made to the generic PCI host driver in commit
> dbf9826d "PCI: generic: Convert to DT resource parsing API".
>=20
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Works for me and my USB3 card. I also like going the global io_offset
variable away and the code readability improved, too, IMO.

One question:


> +		case IORESOURCE_MEM:
> +			parent =3D &iomem_resource;
> +			res_valid |=3D !(res->flags & IORESOURCE_PREFETCH);
> +			break;

res_valid doesn't seem to be actually used?


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWPfyeAAoJEBQN5MwUoCm2Hm8QAIQfPUjzR0nRxLaxZMAKS/jS
8QIxba4ap0SPfwuDrbk8/FzogTMY01WZVBdwImmyJKhJQmMqnZDo1AnF0s3My+qI
gEh41/yc9VssnroXRf6XMmVO5I1o5k9cwW71WT8Pz+juvk0zJYk0eSCG595fdegH
+U34cHvhX8raXiNhLujUncjaCutLMgcOrKS511eAZMIlCzaZrOJ44z42vFvYmIp3
YUfmhZ+8RAuvKRKPVJMhcuolkGNE+QhkVPl4S9QXTFb9xxnrdu2VyUmYF9LPps/K
z5lOxi85eu7f/IYq38ZoxYVxJfl4e1z9Vz5qKL5aVfF1hLOPzYb2rJt/eqyzCTFx
aUQnLet/hd6cyofNWKCQt1c18rdjpdjTI2iNgeLeFBW5QdYA2/gOxLlusDVj6fJz
vK3l35E9sUFbFRQz6jaFoymXc73/Pm6i8C47HIHUhLDkQHUapxmYjOu6naF8xaxb
sCf5gx7ggERqsApYShFUvQNh9zgUP41u8xY3EAiOy57m6r6fb9LaHSK7QHCO9Lb1
1khQnFSxz2iZh+WcbgGlguOLVB6lHsqFb0YRiaoK69N5v4Xsry7X6t3Yh/Zh8SkF
6Tt74ytzd0qF/3+nS2KONu50P7z1mIA8rntY4DYtcBtA0tf0dcdcnVx3RY59tJv2
04m3hJ3/7c2se7WLDnVh
=5cgu
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
