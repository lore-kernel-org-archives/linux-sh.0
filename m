From: Pierre Ossman <drzeus@drzeus.cx>
Date: Sun, 14 Sep 2008 19:52:27 +0000
Subject: Re: [PATCH v2] sh7760mmc: Driver for SH7760 MMCIF interface.
Message-Id: <20080914215227.2824187a@mjolnir.drzeus.cx>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_freyr.drzeus.cx-9930-1221421964-0001-2"
List-Id: <linux-sh.vger.kernel.org>
References: <20080911093718.GA8671@roarinelk.homelinux.net>
In-Reply-To: <20080911093718.GA8671@roarinelk.homelinux.net>
To: linux-sh@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.drzeus.cx-9930-1221421964-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Sep 2008 18:26:48 +0200
Manuel Lauss <mano@roarinelk.homelinux.net> wrote:

> > > +			/* longer timeout for long response */
> > > +			MMC_OUTB(host, CTOCR, 1);
> >=20
> > Huh?
>=20
> Command timeout counter register: The manual states one should write
> '1' to this register for 136 bit responses and 0 for short/no
> response.
>=20

Hmm... There is nothing in either the MMC or SD spec where responses
might have a longer timeout. I don't suppose there is any deeper
explanation in the controller spec?

> > > +	MMC_OUTB(host, CMDR0, (1 << 6) | (cmd->opcode & 0x3f));
> >=20
> > The (1 << 6) could use a define.
>=20
> It's the "HOST" bit. I'll add a constant.
>=20

Ah, I see. That probably doesn't need a constant, but you should add a
comment explaining that the controller needs the entire first byte,
including start and data direction bits.

> > > +	/* start MMC engine */
> > > +	shmmc_clock(host, 1);
> >=20
> > Hmm... are you fiddling with the clock for each request?
>=20
> It's disabled when the request completion is called; so yes.
>=20

Please don't. This is a core responsibility, so work on patches there
if you want it.

> >=20
> > This is probably wrong. Some data transfers are so short that they can
> > end before the response is sent.
>=20
> Could be, yes. However this has worked for almost 4 years now ;-)
> Can the mmc_test driver generate a testcase where this situation occurs?
>=20

There's nothing in there right now, no, but it could probably be added.
It will be card dependent though so I'm not sure how well it will work
in practice.

> >=20
> > No alignment issues on this platform?
>=20
> Of courese, but I've never encountered unaligned data buffers so far
> (can't test SDIO because I don't have any hardware).  The MMC card
> block driver works fine so far.  Also, falling back on byte-sized
> reading roughly halves the transfer rate.
>=20

mmc_test should have thrown a couple of non-aligned buffers at you. And
you also just need to special case the first byte.

> > > +static void shmmc_write_fifo(struct shmmc_host *host, size_t bytes)
> > > +{
> > > +	unsigned long flags;
> > > +	unsigned short *sg_ptr;
> > > +	size_t cnt;
> > > +
> > > +	host->xfered +=3D bytes;
> >=20
> > I hope this isn't written to bytes_xfered if a failure occurs as that
> > would be _very_ bad.
>=20
> So in case of error, the driver should return 0?
>=20

The driver should return the number of bytes acked by the card. If you
cannot determine this then 0 is the correct value, yes.

> > > +	/* multiblock WRITES are badly broken.  Setting max_blk_count
> > > +	 * to 1 works around that but unfortunately it also reduces
> > > +	 * read performance by about 60% on my test system.
> > > +	 */
> >=20
> > What's the issue?
>=20
> While the card is the busy state, the controller continues to transfer
> data to it, resulting in a CRC error.
>=20

Ouch. Can't you work around this by feeding the controller one block at
a time and monitor the busy state manually?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.

--=_freyr.drzeus.cx-9930-1221421964-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkjNa4AACgkQ7b8eESbyJLhV/QCfXLBieZ11dBtrjRQu7f8ZVLIm
m4AAn2Bwd/GvgyNqbwjFSfrO1KZYF6J8
=Cnim
-----END PGP SIGNATURE-----

--=_freyr.drzeus.cx-9930-1221421964-0001-2--
