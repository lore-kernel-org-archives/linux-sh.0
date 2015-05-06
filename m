From: Luis Henriques <luis.henriques@canonical.com>
Date: Wed, 06 May 2015 10:35:25 +0000
Subject: Re: [3.16.y-ckt stable] Patch "ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names" h
Message-Id: <20150506103525.GB1691@ares.olymp>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUcXZZdof-OOowWJ9wuwQeD9Hu5qOp=CKvVO0KttbAdsw@mail.gmail.com>
In-Reply-To: <CAMuHMdUcXZZdof-OOowWJ9wuwQeD9Hu5qOp=CKvVO0KttbAdsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 06, 2015 at 12:28:34PM +0200, Geert Uytterhoeven wrote:
> Hi Luis,
>=20
> On Wed, May 6, 2015 at 11:52 AM, Luis Henriques
> <luis.henriques@canonical.com> wrote:
> > This is a note to let you know that I have just added a patch titled
> >
> >     ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names
> >
> > to the linux-3.16.y-queue branch of the 3.16.y-ckt extended stable tree
> > which can be found at:
> >
> >     http://kernel.ubuntu.com/git/ubuntu/linux.git/log/?h=3Dlinux-3.16.y=
-queue
> >
> > This patch is scheduled to be released in version 3.16.7-ckt11.
> >
> > If you, or anyone else, feels it should not be added to this tree, plea=
se
> > reply to this email.
>=20
> Unless you want to queue other patches that depend on this, I don't think
> there's a need to backport this to -stable:
>   - Changing the names of the labels doesn't have any visible effects,
>     as the phandles referring to them are changed, too,
>   - IIRC, nothing relies on the (changed) names of qclock-output-names.
>

Ok, that makes sense to me -- patch dropped from the 3.16 queue.
Thank you for you review.

Cheers,
--
Lu=EDs
