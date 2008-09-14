From: Pierre Ossman <drzeus@drzeus.cx>
Date: Sun, 14 Sep 2008 14:31:54 +0000
Subject: Re: [PATCH v2] sh7760mmc: Driver for SH7760 MMCIF interface.
Message-Id: <20080914163154.1e011a21@mjolnir.drzeus.cx>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_freyr.drzeus.cx-7426-1221402722-0001-2"
List-Id: <linux-sh.vger.kernel.org>
References: <20080911093718.GA8671@roarinelk.homelinux.net>
In-Reply-To: <20080911093718.GA8671@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-7426-1221402722-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2008 11:37:18 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> +
> +config MMC_SH7760
> +	tristate "Renesas SH7760 MMCIF Interface support  (EXPERIMENTAL)"
> +	depends on CPU_SUBTYPE_SH7760
> +	help
> +	  Say Y or M here to enable the SH7760 MMC Interface driver.

Is it really alpha quality (which is what EXPERIMENTAL means)? If so,
you should also modify the "depends on".

> +			/* longer timeout for long response */
> +			MMC_OUTB(host, CTOCR, 1);

Huh?

> +#ifdef CONFIG_CPU_SUBTYPE_SH7760
> +		/* SH7760: skip R2 CRC checks; these fail every time */
> +		if (mmc_resp_type(cmd) =3D=3D MMC_RSP_R2) {
> +			rsptyr &=3D ~RSPTYR_CRC;
> +			host->ien1 &=3D ~INTCR1_CRCERIE;
> +		}
> +#endif

The problem is probably CRC with long responses, not just R2.

> +	MMC_OUTB(host, CMDR0, (1 << 6) | (cmd->opcode & 0x3f));

The (1 << 6) could use a define.

> +	/* start MMC engine */
> +	shmmc_clock(host, 1);

Hmm... are you fiddling with the clock for each request?

> +	/* explicitly check for cmd->data (not host->data), because the
> +	 * completed command could be the data->stop/mrq->stop cmd!
> +	 */
> +	if (!(cmd->data)) {
> +		shmmc_done(host);
> +	} else if ((host->data) && (host->data->flags & MMC_DATA_WRITE)) {
> +		/* start write-data-engine */
> +		MMC_OUTB(host, OPCR, OPCR_DATAEN);
> +	} else {
> +		/* data read op starts automatically. just enable CRC irqs */
> +		host->ien1 |=3D INTCR1_CRCERIE;
> +		MMC_OUTB(host, INTCR1, host->ien1);
> +	}

This is probably wrong. Some data transfers are so short that they can
end before the response is sent.

> +static void shmmc_read_fifo(struct shmmc_host *host, size_t bytes)
> +{
> +	unsigned long flags;
> +	unsigned short *sg_ptr;
> +	size_t cnt;
> +
> +	host->xfered +=3D bytes;
> +	host->required -=3D bytes;
> +
> +	local_irq_save(flags);
> +
> +	while (bytes) {
> +		if (!sg_miter_next(&host->sg_miter))
> +			BUG();
> +
> +		cnt =3D min(host->sg_miter.length, bytes);
> +
> +		bytes -=3D cnt;
> +		host->sg_miter.consumed =3D cnt;
> +		sg_ptr =3D host->sg_miter.addr;
> +
> +		while (cnt > 1) {
> +			*sg_ptr++ =3D be16_to_cpu(MMC_INW(host, DR));
> +			cnt -=3D 2;

No alignment issues on this platform?

> +static void shmmc_write_fifo(struct shmmc_host *host, size_t bytes)
> +{
> +	unsigned long flags;
> +	unsigned short *sg_ptr;
> +	size_t cnt;
> +
> +	host->xfered +=3D bytes;

I hope this isn't written to bytes_xfered if a failure occurs as that
would be _very_ bad.

> +
> +	blksz_bits =3D ffs(data->blksz) - 1;
> +
> +	/* only power-of-two block sizes >=3D4 are allowed */
> +	if (((1 << blksz_bits) !=3D data->blksz) || (blksz_bits =3D=3D 1))
> +		return -EINVAL;
> +

is_power_of_2() in linux/log2.h.

> +	/* multiblock WRITES are badly broken.  Setting max_blk_count
> +	 * to 1 works around that but unfortunately it also reduces
> +	 * read performance by about 60% on my test system.
> +	 */

What's the issue?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-7426-1221402722-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjNIF8ACgkQ7b8eESbyJLivDgCggs0ijD90ZwpHTU+Jl0wDzIYa
LQwAnRJmuzMsMaTg6gDRqVdeLCNouVgh
=1gMq
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-7426-1221402722-0001-2--
