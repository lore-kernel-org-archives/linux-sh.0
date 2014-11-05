From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 05 Nov 2014 15:43:59 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <16651429.BGZ7UORT2h@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Geert,

On Thursday 30 October 2014 19:03:37 Geert Uytterhoeven wrote:
> On Thu, Oct 30, 2014 at 6:41 PM, Ulrich Hecht wrote:
> > On Wed, Oct 29, 2014 at 1:21 AM, Simon Horman <horms@verge.net.au> wrot=
e:
> >> On Tue, Oct 28, 2014 at 06:02:16PM +0100, Ulrich Hecht wrote:
> >>> Unlike the legacy stuff, CCF disables the ethernet controller's clock
> >>> unless it is used somewhere.
> >>=20
> >> This feels like it should come earlier in the series to avoid
> >> breaking then fixing ethernet support for kzm9g-reference.
> >=20
> > The CCF support, not being used yet, doesn't actually break anything.
> > The reason this patch is separated from the rest is that it works, but
> > it's not completely clear (to me) how.
> >=20
> > As Laurent has pointed out before, the LAN controller is not
> > (directly) hooked up to this clock, but to an external oscillator.
> > Nonetheless Ethernet won't work unless ZB is on, which I have
> > determined by trial and error. Maybe that should have been pointed out
> > in the description...
>=20
> I don't have the schematics for kzm9g, but I guess the LAN controller
> is hooked up to the BSC (Bus State Controller).

Yes it is. We should probably model the BSC in DT, and add the LAN controll=
er=20
as a child of the BSC node. With automatic clock management in runtime PM, =

could we do without a BSC driver entirely ?

> According to the sh73a0 datasheet, ZB=F8 is the clock for the BSC.

--=20
Regards,

Laurent Pinchart

