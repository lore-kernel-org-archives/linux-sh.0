From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 17 Dec 2013 22:16:31 +0000
Subject: Re: [PATCH 3/5] arm: shmobile: r7s72100: add nodes for i2c controllers to dtsi
Message-Id: <1626395.klZkGtWWeG@avalon>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2561529.evHK9WVSGK"
List-Id: <linux-sh.vger.kernel.org>
References: <1387316678-10174-1-git-send-email-wsa@the-dreams.de>
 <1632121.4oJZuIln5n@avalon> <20131217221309.GD1196@katana>
In-Reply-To: <20131217221309.GD1196@katana>
To: linux-arm-kernel@lists.infradead.org


--nextPart2561529.evHK9WVSGK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Wolfram,

On Tuesday 17 December 2013 23:13:09 Wolfram Sang wrote:
> On Tue, Dec 17, 2013 at 10:55:31PM +0100, Laurent Pinchart wrote:
> > On Tuesday 17 December 2013 22:44:36 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa@sang-engineering.com>
> > > 
> > > I decided to put the pinmuxing into the dtsi file since there is only
> > > one pinmux posiibility which one probably wants to have when using the
> > > bus.
> 
> I tried to explain here why the pin-groups are in the dtsi.
> 
> > > +		riic0_pins: i2c0 {
> > > +			renesas,groups = "riic0_scl_p1_0", "riic0_sda_p1_1";
> > > +			renesas,function = "riic0";
> > > +		};
> > > +
> > > +		riic1_pins: i2c1 {
> > > +			renesas,groups = "riic1_scl_p1_2", "riic1_sda_p1_3";
> > > +			renesas,function = "riic1";
> > > +		};
> > > +
> > > +		riic2_pins: i2c2 {
> > > +			renesas,groups = "riic2_scl_p1_4", "riic2_sda_p1_5";
> > > +			renesas,function = "riic2";
> > > +		};
> > > +
> > > +		riic3_pins: i2c3 {
> > > +			renesas,groups = "riic3_scl_p1_6", "riic3_sda_p1_7";
> > > +			renesas,function = "riic3";
> > > +		};
> > 
> > The SoC allows other options for the I2C pin groups. Instead of declaring
> > all possible groups here, I think we should thus only add the groups that
> > are really used to the board .dts files.
> 
> Really? Couldn't find any. This is why I included it here: since it is
> the only option, people probably want to use it when they activate the
> bus.

My bad, sorry, I've misread patch 1/5 and spoke too fast :-/ I thus makes 
sense to add the groups here.

> > > +		clock-frequency = <100000>;
> > 
> > Isn't that a board-specific property ?
> 
> It is meant as a sane default. Can be overridden.

OK.

-- 
Regards,

Laurent Pinchart

--nextPart2561529.evHK9WVSGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSsM1EAAoJEIkPb2GL7hl1nE4H/36Iv81tO/6ddmltjRmEkqb3
RiUBYRbadv2UCuAmHHFo3zNTt3IgSy0sHGGluGXVL6gLCFN86JrKC9KGmoX12lBU
dm8uX5r8kH4dmpXv9942/+qhM9BAYpc4COMaTENjJpt/MJ158iqv8LlDdPSi7Of3
dGHm8HoOpffPehtOLJPgHYTyRBTfEjZwCsdN+B+kGZNOKdaUa+iNIvbjTkwIsnx4
dXbLz4KCWO0gSSKiOMrAneRwLA0RuaTcDNiPD8WYEVa2ZeqJlEPHKIGbqqe/CKa6
tf70ShJEBpwTU3hTd0LpXMHpodY+lFCWxJ3+c80JBGLZLsvDsYgY7yOqoJ0zxIw=
=CrPs
-----END PGP SIGNATURE-----

--nextPart2561529.evHK9WVSGK--

