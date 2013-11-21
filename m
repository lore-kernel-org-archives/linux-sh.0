From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 21 Nov 2013 07:22:37 +0000
Subject: Re: [PATCH] sh-pfc: r8a7791: Fix DU pin groups organisation
Message-Id: <8605091.il2lGndhxZ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1384346777-888-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384346777-888-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 21 November 2013 14:34:41 Magnus Damm wrote:
> On Tue, Nov 19, 2013 at 5:16 PM, Linus Walleij wrote:
> > On Wed, Nov 13, 2013 at 1:46 PM, Laurent Pinchart
> >=20
> > <laurent.pinchart+renesas@ideasonboard.com> wrote:
> >> Rename the sync_1 group to sync as the device has a single sync pin
> >> group for the DU, move the cde_disp mux array right after the
> >> corresponding pins array, and split the clk_in pins in three separate
> >> groups as the pins can be used independently.
> >>=20
> >> Signed-off-by: Laurent Pinchart
> >> <laurent.pinchart+renesas@ideasonboard.com>
> >=20
> > Patch applied for v3.14.
>=20
> Thanks for your help!
>=20
> I realize that this patch depends on "[PATCH] sh-pfc: r8a7791 PFC
> support V2" which I assumed was targeted for v3.13, or do you plan to
> push that for v3.14?

That patch has been merged by Linus Torvald for v3.13-rc1.

> >> The patch is based on top of the latest pinctrl for-next branch and is=
 a
> >> candidate for v3.14. I've tested it with the DU driver on a Koelsch
> >> board.
> >=20
> > K=F6lsch! Who names a board after the sweetest dialect in Germany??
>=20
> Actually, I've heard that the R-Car series of boards are named after
> different types of beer. At least I am aware of Lager, but Koelsch and
> Marzen?

http://en.wikipedia.org/wiki/K=F6lsch_(beer)
http://en.wikipedia.org/wiki/M=E4rzen

:-)

--=20
Regards,

Laurent Pinchart

