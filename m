From: Pierre Ossman <drzeus@drzeus.cx>
Date: Fri, 18 Jul 2008 23:49:33 +0000
Subject: Re: [PATCH] sh7760mmc: host driver for SH7760 MMC interface
Message-Id: <20080719014933.18b9eba4@mjolnir.drzeus.cx>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_freyr.drzeus.cx-24192-1216424977-0001-2"
List-Id: <linux-sh.vger.kernel.org>
References: <20080717110119.GA14949@roarinelk.homelinux.net>
In-Reply-To: <20080717110119.GA14949@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-24192-1216424977-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Jul 2008 13:03:53 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> From: Manuel Lauss <mano@roarinelk.homelinux.net>
>=20
> Host driver for SH7760 on-chip MMCIF interface.
>=20
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---

Just some minor things:

> +static void shmmc_cmd(struct shmmc_host *host, struct mmc_command *cmd)
> +{
> +	unsigned char cmdtyr, rsptyr, i;
> +
> +	shmmc_clock(host, 0);
> +	host->cmd =3D cmd;
> +
> +	/* enable MMCIF and "cmd xfer timeout" irqs */
> +	host->ien1 |=3D INTCR1_IRQEN | INTCR1_CTERIE;
> +
> +	/* setup command type */
> +	cmdtyr =3D 0;
> +	if (cmd->opcode =3D=3D 12)
> +		cmdtyr =3D CMDTYR_CMD12;
> +

Seems more likely that this flag should be set on any stop command.

> +
> +	blksz_bits =3D ffs(data->blksz) - 1;
> +	BUG_ON((1 << blksz_bits) !=3D data->blksz);

This is not a bug. You should fail the request with -EINVAL if you
cannot handle it.

> +static int __devexit shmmc_remove(struct platform_device *dev)
> +{
> +	struct mmc_host *mmc =3D platform_get_drvdata(dev);
> +	struct shmmc_host *host =3D mmc_priv(mmc);
> +	struct resource *r;
> +
> +	MMC_OUTB(host, INTCR0, 0);
> +	MMC_OUTB(host, INTCR1, 0);
> +	MMC_OUTB(host, INTCR2, 0);
> +	shmmc_clrirq(host);
> +	tasklet_disable(&host->done_task);
> +	mmc_remove_host(mmc);

Don't free up any resources needed to handle requests before
mmc_remove_host() has returned.

Also, remember to run the mmc_test test suite on the driver. It tends
to find a lot of problems.

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-24192-1216424977-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkiBLBAACgkQ7b8eESbyJLhwoACfaAJEaD5S7NeVi7dKp4ZJIhGM
/S0An38v2no0T3CPYfkq+uGXgTLjHKzx
=2dJj
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-24192-1216424977-0001-2--
