From: Pierre Ossman <drzeus@drzeus.cx>
Date: Wed, 23 Jul 2008 23:24:23 +0000
Subject: Re: [PATCH] sh7760mmc: driver for SH7760 MMCIF interface.
Message-Id: <20080724012423.6f57fb28@mjolnir.drzeus.cx>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_freyr.drzeus.cx-31605-1216855467-0001-2"
List-Id: <linux-sh.vger.kernel.org>
References: <20080721055030.GA15474@roarinelk.homelinux.net>
In-Reply-To: <20080721055030.GA15474@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-31605-1216855467-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jul 2008 07:50:31 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

>=20
> Host driver for SH7760 on-chip MMCIF interface.
>=20
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---

*snip*

> +static inline void
> +shmmc_read_fifo(struct shmmc_host *host, unsigned long bytes)
> +{
> +	struct scatterlist *sg;
> +	unsigned short *sg_ptr;
> +	int sg_len, cnt;
> +
> +	host->xfered +=3D bytes;
> +	host->required -=3D bytes;
> +
> +	while (bytes) {
> +		sg =3D &host->data->sg[host->sg_idx];
> +		sg_ptr =3D sg_virt(sg) + host->sg_ofs;
> +		sg_len =3D sg->length - host->sg_ofs;
> +

This will not work with the modern chained sg lists. I suggest you have
a look at the sg list iterator helper that just got merged into Linus'
tree. The sdhci driver uses it for its PIO routines.

> +static inline void
> +shmmc_write_fifo(struct shmmc_host *host, unsigned long bytes)
> +{

Same thing here.

Btw, 'static' is generally sufficient. gcc will inline those when
efficient (e.g. when there's just one caller).

> +
> +	if (0 =3D=3D shmmc_card_inserted(mmc)) {

This reversal style is generally frowned upon in kernel code.

> +static void shmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
> +{
> +	struct shmmc_host *host =3D mmc_priv(mmc);
> +
> +	if (host->platdata && host->platdata->enable_sdio_irq)
> +		host->platdata->enable_sdio_irq(mmc, en);
> +}

This is a problem. The core assumes that this will always succeed. I
guess we need a return code for this and a fallback to the polling
method if it fails.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-31605-1216855467-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiHvakACgkQ7b8eESbyJLi52gCeJytSUcalPdjmzvbE6rEKSnY2
2sgAoNB93BYFudHupDb3/PplHfFjWGQ1
=ashA
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-31605-1216855467-0001-2--
