From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 13 Jun 2014 13:24:12 +0000
Subject: Re: [PATCH v2] ARM: shmobile: koelsch: Add support HSCIF1
Message-Id: <1751840.oCdYe48VRu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <9058795.dyXpcFtuGJ@avalon>
 <CAMuHMdUd=E=TcSTPwy0xbpAcZH+voiEkjND=qzdSzG_zKdPe9g@mail.gmail.com>
In-Reply-To: <CAMuHMdUd=E=TcSTPwy0xbpAcZH+voiEkjND=qzdSzG_zKdPe9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

On Friday 13 June 2014 13:16:34 Geert Uytterhoeven wrote:
> On Fri, Jun 13, 2014 at 12:49 PM, Laurent Pinchart wrote:
> > On Friday 13 June 2014 16:43:07 Simon Horman wrote:
> >> On Fri, Jun 13, 2014 at 09:01:27AM +0200, Laurent Pinchart wrote:
> >> > On Tuesday 10 June 2014 16:00:48 Simon Horman wrote:
> >> > > On Tue, Jun 10, 2014 at 01:14:27PM +0900, Magnus Damm wrote:
> >> > > > On Tue, Jun 10, 2014 at 11:34 AM, Nobuhiro Iwamatsu wrote:
> >> > > > > Koelsch can use HSCIF1 insetead of SCIF1 as serial port. But if
> >> > > > > we want to use, we will need to disable the GPIO key and
> >> > > > > remodeling of the board. Therefore status of hscif1 does not s=
et
> >> > > > > the "okay".
> >> > > > >=20
> >> > > > > Signed-off-by: Nobuhiro Iwamatsu
> >> > > > > <nobuhiro.iwamatsu.yj@renesas.com>
> >> > > > > ---
> >> > > > >=20
> >> > > > >  V2: Remove hscif1_clk from renesas,groups. This pin does not
> >> > > > >  use.
> >> > > >=20
> >> > > > Thanks for updating the patch. This looks fine to me.
> >> > > >=20
> >> > > > Acked-by: Magnus Damm <damm+renesas@opensource.se>
> >> > >=20
> >> > > Thanks, I will queue this up.
> >> >=20
> >> > Sorry for the late reply, but I have some doubts about this. The HRX0
> >> > and HTX0 signals are connected to push buttons and used as GPIOs.
> >> > Beside, they're not routed to serial port transceiver. If we want to
> >> > use HSCIF0 on those pins on Koelsch and extension board must be
> >> > connected to the EXIO C connector, and two resistors and two capacit=
ors
> >> > should be unsoldered. I thus don't think the Koeslch DT should conta=
in
> >> > pinmux data for the HSCIF0 device. If an extension board is used and
> >> > HSCIF0 needed, then the DT file for the extension board should define
> >> > pinmuxing for the serial port.
>=20
> You mean HRX1, HTX1, and HSCIF1?

*sigh*... :-)

> HTX1 and HRX1 can be connected to the DEBUG1 transceiver by stuffing
> zero-Ohm resisters to R834 and R835.
>=20
> About your comment about the resistors and capacitors, which applies to
> both HSCIF0 and HSCIF1: probably the serial port will still work if
> these are present.

With a 4.7=B5F capacitive load on the transmission line, assuming a drive=20
strength of 40mA (which is pretty high), switching between 0V and 3.3V take=
s=20
388=B5s, corresponding to 2579 Hz. You'll have to reduce the baud rate :-)

> >> If you would like me to revert this patch I am happy to consider doing
> >> so.
> >=20
> > That's one option, but I'd like to get feedback on my point of view bef=
ore
> > reverting it. Who knows, I might be wrong ;-)
>=20
> Nevertheless, I agree with Laurent.
>=20
> HSCIF1 (and HSCIF0) cannot be used on the Koelsch board as-is, hence they
> should not be present in the plain Koelsch DTS.  They should be put in
> an overlay DTS instead.

--=20
Regards,

Laurent Pinchart

