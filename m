From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Dec 2013 14:35:26 +0000
Subject: Re: [PATCH v2] sh_eth: add R8A7791 support
Message-Id: <20131225143519.GA29115@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201312080259.19163.sergei.shtylyov@cogentembedded.com>
 <20131210.214754.1553999236888329751.davem@davemloft.net>
 <20131225071449.GA27173@verge.net.au>
 <52BABC13.201@cogentembedded.com>
In-Reply-To: <52BABC13.201@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Dec 25, 2013 at 03:05:55PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 25-12-2013 11:14, Simon Horman wrote:
>=20
> >>>Add support for yet another ARM member of the R-Car family, R-Car M2, =
also known
> >>>as R8A7791 -- it will share the code and data with previously added R8=
A7790.
> >>>Despite the Ether devices in these SoCs are indistinguishable at least=
 from the
> >>>driver's point of view, we do introduce a new platform device ID "r8a7=
791-ether"
> >>>unlike the wildcard ID used for R8A7778/9 SoCs, due to newly establish=
ed policy
> >>>for the Renesas SoCs.
>=20
> >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> >>Applied, thank you.
>=20
> >Hi Sergei, Hi Dave,
>=20
> >I don't seem to be able to find this in net-next.
>=20
> http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit/?id=
=94a12b15e4c575e0aa0ba5e24a4f213163a823d0

Thanks
