From: Samuel Ortiz <sameo@linux.intel.com>
Date: Sun, 29 Nov 2009 23:56:20 +0000
Subject: Re: [PATCH] mfd: Add power control platform data to SDHI driver
Message-Id: <20091129235620.GB4292@sortiz.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091127043127.13567.23641.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sat, Nov 28, 2009 at 08:10:49AM -0500, Magnus Damm wrote:
> Hi Samuel,
>=20
> On Fri, Nov 27, 2009 at 2:47 PM, Samuel Ortiz <sameo@linux.intel.com> wro=
te:
> > On Fri, Nov 27, 2009 at 01:31:27PM +0900, Magnus Damm wrote:
> >> This patch adds platform data with a function for power
> >> control to the SDHI driver. The idea is that board specific
> >> code can provide their own functions so power can be enabled
> >> and disabled for the sd-cards.
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >> =A0Needed by the Ecovec board.
> >> =A0Apply on top of the SDHI driver in the SuperH tree.
> > I wasnt cc'ed on that driver, right ? Just checking I didnt forget it...
>=20
> You are correct, my bad. I'll do my best to keep you CC:ed from now on!
No worries, I was mostly concerned about not having lost it in may mailbox.

Cheers,
Samuel.

=20
> / magnus

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
