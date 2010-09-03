From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 03 Sep 2010 10:32:44 +0000
Subject: Re: [PATCH V3] arm & sh: factorised duplicated clkdev.c
Message-Id: <20100903103244.GF21449@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 19:18 Fri 03 Sep     , Magnus Damm wrote:
> On Thu, Sep 2, 2010 at 10:39 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > factorise some generic infrastructure to assist looking up struct clks
> > for the ARM & SH architecture.
> >
> > as the code is identical at 99%
> >
> > put the arch specific code for allocation as example in asm/clkdev.h
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > ---
> > v3:
> > =A0 =A0 =A0 =A0wrong comment removed
> > =A0 =A0 =A0 =A0headers fixed
>=20
> [snip]
>=20
> I can't apply this patch using GNU patch. I've tested 2.5.9 and 2.6.1
> from Gentoo.
>=20
> Using --dry-run is fine, but omitting dry-run gives me:
>=20
> ...
> patching file arch/arm/common/clkdev.c
> patching file arch/sh/include/asm/clkdev.h
> Hunk #1 FAILED at 1.
> Hunk #2 FAILED at 11.
> 2 out of 2 hunks FAILED -- saving rejects to file
> arch/sh/include/asm/clkdev.h.rej
>=20
> I guess this is caused by the last "renaming" hunk, see below.
>=20
> I thought these things were supposed to work out of the box...
I generate it as usual with git (1.7.1)

with the following options git format-patch -M -B -C

and I agree it's supposed to work out of the box

Best Regards,
J.
