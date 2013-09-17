From: Mark Brown <broonie@kernel.org>
Date: Tue, 17 Sep 2013 16:41:48 +0000
Subject: Re: [PATCH] SPI: EMMA Mobile SPI master driver
Message-Id: <20130917164148.GH21013@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Eb2dXAwtBqAM4EkP"
List-Id: <linux-sh.vger.kernel.org>
References: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
In-Reply-To: <1378386669-9920-2-git-send-email-ian.molton@codethink.co.uk>
To: linux-sh@vger.kernel.org


--Eb2dXAwtBqAM4EkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 03:30:48PM +0100, Ian Molton wrote:
> On 17/09/13 14:23, Mark Brown wrote:

> >>+		/*
> >>+		 * We're abusing the chip a bit so that we can do
> >>+		 * multi-byte operations in PIO mode.
> >>+		 * As a result we need to spin until the START bit drops here.
> >>+		 *
> >>+		 * This only works with GPIO based chipselects, unless the
> >>+		 * transfer size is 4 bytes or less. Verified on a scope.
> >>+		 *
> >>+		 * DMA mode appears not to have this restriction.
> >>+		 */

> >>+		while (readl(em_spi->addr + EMXX_SPI_CTL) & 1)
> >>+			;

> >The comment leaves me none the wiser as to what this is actually doing.
> >As Simon noted some sort of timeout would seem to be in order too.

> Hm, how much more is appropriate to comment within the driver?

> What we're doing, is setting a GPIO CS just before the transfer and
> resetting it after.

Expanding the "this" would be a big help here, there's a lot of text
there but it doesn't say anything about what the operation being done
is.

> >>+	em_spi_set_cs(em_spi, em_spi->chip_select, 0);

> >This is ignoring any /CS fiddling options in the transfer.  We really
> >ought to be factoring this GPIO bashing out of the drivers...

> Perhaps, but how?

Implementing the /CS fiddling options is fairly straightforward.  For
the factoring out I'm mostly waiting for the Samsung guys to respin the
patch series they have pending for their driver since that is my primary
development platform and I don't want to collide with that work.

Most transfer_one_message() functions are very similar, especially those
where the /CS is done with a GPIO - the iteration and /CS fiddling is
all common, it's just the data transfer that varies.

> >>+	if (em_spi->cs_gpio)
> >>+		actual_cs = em_spi->hard_chip_select;
> >>+	else
> >>+		actual_cs = spi->chip_select;

> >This test looks the wrong way round or hard_chip_select seems misnamed?
> >Or some comments might be in order.

> No, its correct. When using GPIO lines, even if the real CS lines
> arent used, you still must program them properly, or the chip does
> not respect polarity/phase options.

> hard_chip_select is used to choose which "real" chipselect is being
> used to back the GPIO based CS.

> the idea is that chip_select is always used to refer to the CS as
> seen from the attached devices perspective. when not using GPIOs, it
> is == hard_chip_select.

> perhaps s/hard/underlying/ ?
> or s/hard/real/ ?

Something explaining that you still need to control the controller /CS
even without it being connected to the device would be a start.

> >>+	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE_SWITCH_EN);
> >>+	writel(0x1, em_spi->addr + EMXX_SPI_BLOCK_MODE);

> >>+	/* Reset, int off */
> >>+	em_spi_soft_reset(em_spi);

> >We initialise some registers and then we do a soft reset - that looks
> >odd?

> But correct. Those registers control function of the block as either
> SPI or IIS.

Again a comment would be in order - one would expect that resetting the
block would reset the selection.

--Eb2dXAwtBqAM4EkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOIZJAAoJELSic+t+oim907kQAIb1NWuhjs008UfIPxDaOQWu
8K8yooldmJ1sBKkY6ckWL6+swCVgLpoWczNPyPgzK82hwaOrIU95gUu2zET0Yi0M
Z3gVeeuoOhWLvcEvuRNoNnPLts+dFNjFSXe1IXYAOJt7QxkmHy8gjc8RCt30Kykd
HVxvCV9VWH8sqDqX4WQX9N3kLRKz2D5hoF47AU8FuEQ1oOBMHHKBTYRfwmK78ol/
dCsNU6/9bGgNqSmtSVDvSPH7yneOpTFrCePiYrpEkdMPFfCJUMfHunoyOGgcfQys
sO1V0Uh9afOds39j23eiH9OJhiJHYV8hcJ8i5lGJd3fkPuWrITUqWza8bNgPsLD2
T0RbA7RSjoLy+jzZD/TPp0jtDuWhdswRRyvMARC6CH4OsKLfsqR1nE83z4yMDt2k
tYSzxaecNIF2FsMPfAmifIzDaChABB8DhuvdB1LSp187AteBvHQ3HSZIaMkT80LS
GwG/lqr/Ik5xpYjfPdC0HU9nI4WZEjDDu5Cef5zRGgs+mj6AHYjJQQNHeWTLy4mT
UB72RpDVmb/YYeZCR5jt6PF5S879DnXGD/Kf+5j3AE6egolNDbgxxva8I4DyATGW
3PkPyPn9mVlP/0VJu/oORnuodY0ueq3l3bJOaG0bONJCb3C7NlsPjiFiAoSkw2QZ
gaC+iahv0I6mk7qb5/mW
=pTb8
-----END PGP SIGNATURE-----

--Eb2dXAwtBqAM4EkP--
