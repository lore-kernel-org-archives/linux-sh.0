From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 10 Jan 2014 01:55:29 +0000
Subject: Re: linux-next: manual merge of the sh tree with the tree
Message-Id: <20140110125529.9843f450bf79223164031b02@canb.auug.org.au>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__10_Jan_2014_12_55_29_+1100_SvavUGTAcUyLk69d"
List-Id: <linux-sh.vger.kernel.org>
References: <20140106121317.bada4233ec3fec40f79735cc@canb.auug.org.au>
 <CAOesGMgJe9KR2muA4F9EaXYpDFDLxVZsKOj-8qZFbDZTiRBuww@mail.gmail.com>
 <20140110004724.GA22965@verge.net.au>
In-Reply-To: <20140110004724.GA22965@verge.net.au>
To: linux-arm-kernel@lists.infradead.org

--Signature=_Fri__10_Jan_2014_12_55_29_+1100_SvavUGTAcUyLk69d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 10 Jan 2014 09:47:24 +0900 Simon Horman <horms@verge.net.au> wrote:
>
> On Wed, Jan 08, 2014 at 11:11:03PM -0800, Olof Johansson wrote:
> >
> > The request to merge the sh code came through Simon with claimed
> > agreement from SH maintainers to do so -- I didn't verify this since
> > they have in the past been well-coordinated. Simon?
>=20
> I spoke with Paul recently and my understanding is that
> he hasn't been actively working in this area for over a year now.
>=20
> I guess there are some stale patches in his tree.

That is certainly what it looks like.  So, do I remove the sh{,.-current)
trees (git://github.com/pmundt/linux-sh.git#sh-{latest,fixes-for-linus})
from linux-next permanently?  Will it be cleaned up any time soon?

Is anyone maintaining/supporting sh now?  Is it a candidate for pruning?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__10_Jan_2014_12_55_29_+1100_SvavUGTAcUyLk69d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJSz1MWAAoJEMDTa8Ir7ZwVnpIP/A+iKbAeswNZaczDSBECksLB
52GnN8weDyFm6xgh3TnlQVK5ud5PJZWN/bG3d8IQaPTNWNXnqF8GGEVNzeNQ5mFT
XPZ1voH143P3cFa8k9SYgRBuva8qWVlgaxAcM7dvoC2tUCOQ7FL9/pO0iMpDRjUk
xoKGJpzxsHcbxyb30c07q75KHO4Z135jep0kOzc+GMSi5z6xhrtsOhX3AqIsGRC7
8zu3OBsQmRHlEwRJhBR+mcXNdHn5dSOYj/HBC5LoqSj+3WWyvG2aoXslirzBe2P1
bZPXBnX8F4WtKGb2zliQ37rhBE/pzaPRkxlVwC7t1UE275P2PCXuea58SqTi3VD3
KluF2EfQNF3EDaukJ4s3nRjsLdJmCVwoiEAP2N6acI8WrmVxQUd8D5TJe+NVg9T9
TbXtGpIrP6O2ocAXWZ1v8QKotXmg9Rh09nSeMihbaDGY7vl37StD0OKlJ9u/FAZh
bPiZb9k3GG+E0WIBume0BKxFPnOEcnnMp/F6R0B/ZuM8w42NIg5tKtb6pYet/d6u
j5iyRlbqvKsYSnHo459IETP+zUXTHhcW45PdSC2hTKT90Iu38SORe4bFnXOLjO2R
9FUt9cNzZmGz0PMTYo/nV2jIl2V73EqZd1fI08q7bTr4CmtWvc34PfMcD7GpeUpC
MLjs4xlUrT8pFfkQ3jcJ
=KM7E
-----END PGP SIGNATURE-----

--Signature=_Fri__10_Jan_2014_12_55_29_+1100_SvavUGTAcUyLk69d--
