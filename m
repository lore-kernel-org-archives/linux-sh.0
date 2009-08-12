From: "Nylund, Martin" <Martin.Nylund@emtrion.de>
Date: Wed, 12 Aug 2009 12:33:15 +0000
Subject: AW: kernel oopses on 7780 target with 2.6.25 kernel
Message-Id: <37C9A1F7C45F1F498E9CB8295E7B305C77F8F3@em-srv1-kaha.intern.emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


> On Wed, Aug 12, 2009 at 09:34:26AM +0200, Nylund, Martin wrote:
> >=20
> > > in 2.6.30
> > > set_pte(kmap_coherent_pte - (FIX_CMAP_END - idx), pte);
> > > is called after update_mmu_cache.
> > >=20
> > > So, you should better to update to the recent kernel.
> >=20
> > I was afraid of something like that. Do you happen to=20
> remember when or=20
> > in which kernel release this bug was fixed? Is it a total=20
> no-go to try=20
> > to backport this to 2.6.25? Updating the whole kernel takes=20
> time which=20
> > I currently don't have.
> >=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.g
it;a=3Dcommitdiff;h=ACca4f4d9bd657e8bc7e1665ba5077465138f133

I applied the changes and now the test runs stable. Thanks!
