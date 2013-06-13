From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Jun 2013 15:32:22 +0000
Subject: Re: [PATCH v2 04/11] pwm: Add Renesas TPU PWM driver
Message-Id: <6125284.6vELCtAL9N@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1658100.GTP1WANa2e"
List-Id: <linux-sh.vger.kernel.org>
References: <1366836616-21475-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <22098838.zqKo9eB0Jt@avalon> <20130612100647.GA30841@mithrandir>
In-Reply-To: <20130612100647.GA30841@mithrandir>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>


--nextPart1658100.GTP1WANa2e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Thierry,

On Wednesday 12 June 2013 12:06:49 Thierry Reding wrote:
> On Wed, May 29, 2013 at 05:48:50PM +0200, Laurent Pinchart wrote:
> > On Thursday 23 May 2013 23:45:17 Thierry Reding wrote:
> > > On Wed, Apr 24, 2013 at 10:50:09PM +0200, Laurent Pinchart wrote:
> [...]
> 
> > > > +struct tpu_device {
> > > > +	struct platform_device *pdev;
> > > > +	struct pwm_chip chip;
> > > > +	spinlock_t lock;
> > > > +
> > > > +	void __iomem *base;
> > > > +	struct clk *clk;
> > > > +
> > > > +	struct tpu_pwm_device pwms[TPU_CHANNEL_MAX];
> > > > +};
> > > 
> > > Can't you reuse the infrastructure built into the PWM subsystem? You can
> > > associate chip-specific data with each PWM device. You can look at the
> > > pwm-atmel-tcb and pwm-bfin drivers for usage examples. In a nutshell you
> > > hook the .request() function and setup the driver-specific structure and
> > > associate them with the PWM using pwm_set_chip_data().
> > > 
> > > This has the advantage that you don't need the pwms array in tpu_device
> > > and you also don't need TPU_CHANNEL_MAX because only the pwm_chip.npwm
> > > field needs to contain the number of channels.
> > 
> > I've actually thought about that, but decided not to do so. It looked
> > pretty weird to allocate PWM devices at .request() time, so I decided to
> > allocate the devices once only at probe time. Is it considered better to
> > allocate/free PWM devices every time they're requested/released ?
> 
> Well, I consider it better because it postpones memory allocation until
> it is actually used. Typically requesting a PWM device happens at probe
> time of other drivers so it isn't actually as bad as it may sound. Also
> allocating at request time allows you to easily associate the data with
> the PWM device using pwm_set_chip_data(), which was intended to be used
> for exactly this purpose.
> 
> Doing so will keep the driver-specific data in a well-defined location
> instead of putting it somewhere driver-specific.

OK, I'll try to fix that. For now I'll still need to expose TPU_CHANNEL_MAX to 
boards for polarity configuration in platform data. That will go away when all 
users will be converted to DT.

-- 
Regards,

Laurent Pinchart

--nextPart1658100.GTP1WANa2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQEcBAABAgAGBQJRueYMAAoJEIkPb2GL7hl1htUH/A1y2i0dPDNtwvUe+W/bcWGz
VhZKvt61tLcMcZzEpK/K0ovfGcoNVTihXgsboPMoCulhvaw8d1yUZKMrs45/gbQs
JU/OmgUPfrm9IvbSkYjoWGJHpeqNbLWkzFG2CkLSwK7S8WelfKYQXTK1obcRPmoa
aIrYPJ3j6qTsy6wN5Dbuq9ox+FHBpxRxWFuD2P1kCa7yqyBpn4Ui2kLcMVUVmZ/g
aFvzCOCClqydQudNoBrmAWaWAv829fiOfkruMTF2+amiXRZWulmh2PGbCEanzx93
/v8KdiK6dFYLc6Aadb74pTdjN8uTrNxSk6BUXRN0/pnS2fTE7dQMB0BvjXUSE84=
=GYhm
-----END PGP SIGNATURE-----

--nextPart1658100.GTP1WANa2e--

