From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Dec 2015 13:30:58 +0000
Subject: Re: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Message-Id: <20151217133058.GA20372@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
List-Id: <linux-sh.vger.kernel.org>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
 <1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Phil,

> +		/* Wait until we are in L1 */
> +		while (!(val & L1FAEG))
> +			val = rcar_pci_read_reg(pcie, PMSR);

No timeout?

Regards,

   Wolfram


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcrkSAAoJEBQN5MwUoCm25gMP/0A7amB4URQTjWW/rjBaoXkk
J81Q7+DbRqKt4iXIbE8HJuzpN+8nT83UK+ooy3gL7bESFNRyeand2urBFAf3jVDY
wGH8ooj+mbFFRBFfvIO0cJITmzxpEaGtHXPU+r4XKEFZzrCBJcmYnIUL8h77tXX9
uF+lgc/1uQ0O/FK9wyJsoYtdZFqNOziQRfnnpKQWgo18amgi1Ux1XI93EjkX8sYy
EGI7X3aR+q2ytbRmp4jJoFMd7qwlfruNuStPTzkCQVYiks++YWWZ5Tq7x/GO8n7y
GNU/iLZLYKEr5loj802YSX70ayKJZ8xJEG2FwPgRf0uDrBkDeLz465o6srk4Dp3R
1w3sVYGSyXBM2K0RbEFz6b1O8agX/AFRgIp5z+1jLcUvZ+mLq5ZTEYZRtJcAeOcl
GaF96T01d3zakW3KC6hcOb6SmNoO4Bu1OWXQy0ajxLLhCOcK5k86shlIV+ojFu9z
+cT2lV44JYndACQ4Oybtv5YI3ugXCNGnrf4sJHymWFH9D3KXw1NxJbfW1AyfORHr
8cu6PR3rokNEfUK8yzILRigTVNBu1hwfex83QIgsWfeauwQM+MbBpescFyw8PlPq
31h0XsumYGjvgZXhKv2zdlf3AXSp8L4Xt96w4nEZS3fs+B4RbdkxlgZS07vHESQ8
ZRBs7xOYQtZxoRjh1smZ
=3ccK
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
