From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Thu, 21 Jan 2010 10:28:26 +0000
Subject: AW: [PATCH] spi_sh_msiof: Fixed data sampling on the correct edge
Message-Id: <95F51F4B902CAC40AF459205F6322F0171E8D495B9@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Magnus,

of course there are real world examples on the SH7723 ;-) And I'm happy tha=
t a driver is now available otherwise I had to write it on my own.

I'm using spidev to communicate with a samsung oled display S6E63D6. This d=
isplay requires the mode SPI_CPHA and SPI_CPOL.

Plain writing is fine with the old register setting (REDG=3D!TEDG). I can c=
onfigure the display. But when reading the chip identifier, the last byte (=
of the identified 0x63D6) is never stored in the FIFO. I always read 0x6363=
, so the FIFO returns the 2nd last byte as the last byte.

With a logical analyzer I can proof that the device is sending the correct =
data. So it must be an issue of the sampling. And changing REDG/TEDG to the=
 values recommended in the SH7723 HW Reference Manual fixed this issue.

Best regards,
Markus

> -----Urspr=FCngliche Nachricht-----
> Von: Magnus Damm [mailto:magnus.damm@gmail.com]
> Gesendet: Donnerstag, 21. Januar 2010 11:02
> An: Pietrek, Markus
> Cc: linux-sh@vger.kernel.org
> Betreff: Re: [PATCH] spi_sh_msiof: Fixed data sampling on the correct
> edge
>
> Hi Markus,
>
> On Thu, Jan 21, 2010 at 6:26 PM, Pietrek, Markus
> <Markus.Pietrek@emtrion.de> wrote:
> > it seems to me that the spi_sh_msiof.c driver configures REDG and
> TEDG wrongly. TEDG=3D0 outputs data at the **rising edge** of the clock
> and REDG=3D0 samples data at the **falling edge** of the clock.
> Therefore for SPI, TEDG must be equal to REDG, otherwise the last byte
> received is not sampled in the SPI mode 3
> >
> > The SH7723 HW Reference Manual explains the setting in Figure 20.20
> and Figure 20.21 ("SPI Clock and data timing")
>
> Nice to hear that someone is using the msiof driver! Your patch, is it
> for a theoretical data sheet mismatch issue only?
>
> I used your version of the register settings initially when hacked up
> the driver, but after testing on my sh7724 board and looking at the
> results in a scope I decided to use the inverted bit setting. I may be
> wrong though, so please back up your patch with some real world test
> results. =3D)
>
> / magnus

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or other=
wise confidential information.
- If you have received this e-mail in error, you are hereby notified that a=
ny review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
