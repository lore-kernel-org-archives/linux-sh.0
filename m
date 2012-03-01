From: Thomas Schwinge <thomas@codesourcery.com>
Date: Thu, 01 Mar 2012 15:50:46 +0000
Subject: Re: Single-stepping with UBC on SH7785
Message-Id: <87vcmo2ucp.fsf@schwinge.name>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <87sjidcrrn.fsf@schwinge.name>
In-Reply-To: <87sjidcrrn.fsf@schwinge.name>
To: linux-sh@vger.kernel.org

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paul!

Thanks for the detailed answer -- that was helpful.  Some further
comments.


On Fri, 24 Feb 2012 14:36:47 +0900, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Feb 14, 2012 at 05:18:52PM +0100, Thomas Schwinge wrote:
> > After learning from the SH7785 manual how to use and program the UBC, it
> > seemed obvious to me that what it implemented nowadays in
> > arch/sh/kernel/cpu/sh4a/ubc.c for programming the UBC does not match how
> > it used to be
> >=20
> That would be because we're using it differently. It was originally
> reworked in order to permit use of multiple UBC channels, and geared at
> the ksym tracer (subsequently superseded by generic perf hw_breakpoint
> API utilization). The intent was the model the same single-step behaviour
> as previously over top of the new API, but there are some caveats (ie,
> perf can have all of the available channels locked down, making
> set_single_step() fail).

The interface of user_enable_single_step assumes it cannot fail.  But in
there, set_single_step may in fact fail (as I understand it), but its
return value is currently ignored.  What should happen in this case?
Patch a breakpoint instruction into the code instead of using the UBC for
single stepping?

In set_single_step, currently only ptrace_bps[0] is considered for use --
which is not a problem for the moment, as single stepping is the only
user.


> > After several hours of grief, I came up with the additional
> > 0001-Wire-the-clock-of-the-SH7785-s-UBC-as-expected-in-ub.patch -- and =
it
> > worked!  (Meh, so simple...)
> >=20
> Sorry about that, I prototyped on 7786 and should have more diligently
> grepped for other UBC clock definitions!

At least I learned a lot about all this Linux kernel code.  :-|


> > ... and today I figured out that my first patch isn't even needed -- but
> > I don't understand how the current ubc.c implementation gets away with
> > not using the asid stuff, for example?  And shouldn't it respect the
> > reserved value UBC_CRR_RES as well as UBC_CRR_INIT and UBC_CBR_INIT that
> > I re-introduced?  Also the manual suggests a different order for
> > programming the registers.
> >=20
> The reserved bit is functionally immaterial. It's always wired to 1, so
> it makes no difference what is read/written to it. We can add a 1 write
> to it to line up with the manual if you like, but in general the UBC
> chapter has been cut-and-pasted from legacy parts for years, to the
> extent that the manual should really only be considered a loose guideline
> (for some CPUs the register map is nowhere near where the manual
> suggests, for example). Your CRR_INIT value is just setting CRR_RES
> anyways.

Huh, OK...  For me, the manual is the only reference I have.  (For
example, the manual says to always write reserved bits as they are
read/defined.)  This is why first worked a lot on aligning the
implementation with the manual.  Please tell which other documentation
should I be looking at?

> The CBR_INIT value relates to matching conditions for the given channel,
> and their values need to be derived from the channel being used rather
> than a fixed constant. You are correct that there is a bug here though,
> in that the CBR write forces a CCMFR.MF0 match, while we need to set the
> CBR.MFI relative to the channel index (you can tell this was only really
> tested one channel at a time!). This probably would have been caught
> earlier if we had set CBR.MFE, but we don't really need it for anything.
>=20
> > As soon as someone starts working on adding user-space controlled
> > hardware breakpoint and/or watchpoint support, this will need further
> > untangling/cleanup.
> >=20
> Now that the kernel uses the UBC alongside userspace it's quite possible
> that we'll have to adjust some of the settings, and I'm certainly
> interested in hearing about any troubles you encounter. I tested the
> single-step stuff with the utrace testsuite if I recall correctly, and it
> seemed to work alright (even with the ksym tracer tying down another
> channel for watchpoint use at the time).

For GDB, I have so far only needed one channel for single stepping.  We
are interested in adding user-space watchpoint support.


> I left the ASID stuff out initially to keep things simple (SH-X3 cores
> and later all have extended ASIDs, so we have an extra set of CBR
> registers to program for extended ASID matching -- this applies to
> anything with PTEAEX capabilities). We obviously don't require it on the
> kernel side, but you're right that we should add it back in for the
> userspace case. If you want to hack up some patches for that I'll
> certainly use them, otherwise I'll see about hacking something up for you
> to test.

I will have to learn more about ASIDs.  Is the manual the correct
document to read?


> It wasn't entirely obvious from your mail, but is the general conclusion
> from all this that with the clock properly registered for SH7785 that
> single-stepping works as you expected it to?

That is correct.  For convenience, I'm again attaching the patch here --
please push that one for the moment.


Gr=C3=BC=C3=9Fe,
 Thomas



--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-Wire-the-clock-of-the-SH7785-s-UBC-as-expected-in-ub.patch
Content-Transfer-Encoding: quoted-printable

From=20c6696f9fcffcce6739449ea681a38c30e4799017 Mon Sep 17 00:00:00 2001
From: Thomas Schwinge <thomas@codesourcery.com>
Date: Tue, 14 Feb 2012 16:19:49 +0100
Subject: [PATCH] Wire the clock of the SH7785's UBC as expected in ubc.c.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
=2D--
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh=
4a/clock-sh7785.c
index e5b420c..2b31443 100644
=2D-- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -156,7 +156,7 @@ static struct clk_lookup lookups[] =3D {
 	CLKDEV_CON_ID("siof_fck", &mstp_clks[MSTP003]),
 	CLKDEV_CON_ID("hspi_fck", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("hudi_fck", &mstp_clks[MSTP119]),
=2D	CLKDEV_CON_ID("ubc_fck", &mstp_clks[MSTP117]),
+	CLKDEV_CON_ID("ubc0", &mstp_clks[MSTP117]),
 	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
 	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
 	CLKDEV_CON_ID("gdta_fck", &mstp_clks[MSTP100]),
=2D-=20
1.7.5.4


--=-=-=--

--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPT5rWAAoJENuKOtuXzphJL/YH/j5nuFc3k1xerK03r3OumE4S
6MFAV6wzJjHvVMpL9hw8vouWK9y2SDdcPSI2TTp6LobyPkqrZjt4bRxgZhWE5xBD
AWEUrQfRz5cTnvbG3eMrrwleetCVjCM3KLWcxxIGxXFmrj0bZLi/lfZG2+olvd6+
9inpgETbyEErlGLG2lc5thFgWGep1KXaYXR1EjrYio1so/mrWPaNSPAsrY95dePI
Xyx5H7UuxIhXC4Zjzlp5qLVOdUuqjbGmwBwMDhvU1dcr2YK/MwWqtfsPL+hOf6N8
VuyMcseNvUzPHa/bqSa8jEYLLWfID4/OMD76fkmiSeDhuCLy9ZT49ZKOyKeSNHM=
=zo2O
-----END PGP SIGNATURE-----
--==-=-=--
