From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 06 Oct 2014 05:59:15 +0000
Subject: Re: [PATCH] serial: sh-sci: submit rx dma the way the DMA driver can handle it
Message-Id: <20141006055914.GA1266@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
List-Id: <linux-sh.vger.kernel.org>
References: <1412266448-20266-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1412266448-20266-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2014 at 10:55:40AM +0900, Simon Horman wrote:
> On Thu, Oct 02, 2014 at 06:14:08PM +0200, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > The shdmac driver has a problem when one wants to submit two RX
> > descriptors and then use issue_pending on both (like this driver does):
> >=20
> > Submit first desc
> > -> channel state after: SHDMA_PM_ESTABLISHED
> >=20
> > Submit second desc
> > -> channel state after: SHDMA_PM_PENDING
> >=20
> > PENDING here means: "Oh, we will wait until the first desc is finished
> > and then the second desc will be grabbed from the list anyhow"
> >=20
> > However, because issue_pending does nothing for states !=3D
> > SHDMA_PM_ESTABLISHED, nothing ever gets active :(
> >=20
> > Since the DMA driver is probably replaced soon anyhow, I decided for the
> > least intrusive workaround which is to use issue_pending on every RX
> > desc. (Yes, setting s->active_rx twice is ugly).
> >=20
> > Probably not for upstream! However, this patch restores DMA capability
> > for SCIFA on my Lager board. Sadly, not for SCIF due to interrupt
> > problems still to be investigated.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> sh-sci patches usually go via linux-serial@vger.kernel.org and
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>. Could you repost this pa=
tch
> with those parties included?

I wanted to send this patch as RFC, but forgot to rename it :) I'd
really like some discussion about it, probably in D=C3=BCsseldorf even. I am
still not sure this patch should go upstream, but we should talk about
it.

Thanks,

   Wolfram


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMi+yAAoJEBQN5MwUoCm2TFUQAIZfTK/wf57SB4whfRfVoXm4
6h99ay3XzPiJYg6DiEmNx7t8bHyfYG0bPNNOKnNxRyn6jJu8yaLNUnEcN0Z1i4tS
3XOE3Lv0UtJkE8Wsu/MrAGDIjFHv1B2A9FYCfKfPLaZYcHL/j2mLuOd8OPBU64dW
2zuk4st9+ElkmpZ1rJkqUG6qlNibjRu/xbO774U2UAWN+81t2KPZMT7Eg+5g6MZj
qSJ6x4mMnshu2BTEdSsGIKTPWhGyfLuURoQrld1Ry/AT/ACbv6MpbA35E9BXq0eC
TDCUBfboGRYkvb2us1tIzDqzi8NNZvvrgWNkQzXCLS+J6nWy/dUkTFY72Mjp5gbV
/YwwjqE8DZ4oHk43KZj8/uZOqchKI58OrarBxAk7vEg/fUiLixrBqV9KY4QTcBTB
4o8LgGveQjwss3Ji7TPPN+9g0uOaLYaJRMlcyrdZ/Iu7DXQ3vf4BgcKe7F7xW2g5
kftFOPTxZ53hNFBgnAnIlg8USx9NB055EhxOFmfbNJLxDQ9KWu1q0izVrvV6saZO
qWvtU42wc2vWDbMgBoinPcZYruBlI8UMIQk8CbwqnzKk+xoiZBNQBd/scofsQYg6
JUaxPPtsFX3suVv4ccXLK5OJQ87AhJUiFy9P/ekg+zrofL8RhxkdfvDZ41E5RP0x
uBdvWas/nHbtjWRHXsxD
=9M5T
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
