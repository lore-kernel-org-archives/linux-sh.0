From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Aug 2015 00:52:18 +0000
Subject: Re: [PATCH 0/4 v3][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <20150804005217.GA16257@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <877fpdw3av.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fpdw3av.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Aug 03, 2015 at 06:56:59PM +0200, Geert Uytterhoeven wrote:
> Hi Simon et al,
>=20
> On Mon, Aug 3, 2015 at 8:59 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Aug 03, 2015 at 11:44:14AM +0900, Simon Horman wrote:
> >> I plan to queue these up in a topic branch, topic/arm64-rcar-gen3-v3,
> >> of the renesas tree. I plan for the base of the branch to be v4.2-rc1,
> >> currently the base for work I have queued up up for v4.2 (I am not
> >> queuing up this series for v4.2 at this time). Please let me know
> >> if a different base, e.g. v4.1, would be more appropriate.
> >
> > I have pushed the topic/arm64-rcar-gen3-v3 branch as described above.
>=20
> That branch is not included in renesas-devel-20150803-v4.2-rc5.
> Is that intentional?

Yes, at least for now.

My intention was that:

renesas-next: is for code targeted at the forthcoming release, currently v4=
.3
renesas-devel: is for code not appropriate for next _yet_.
               e.g.: Code for the release after the forthcoming one,
	             currently v4.4. Or code queued up while next is
		     closed: for us that basically means between rc6 and rc1.

If we would like a merge branch that pulls together more alpha code, such as
topic/arm64-rcar-gen3-v3, then I would like to create a new merge branch.

> Please note that arm-soc/for-next contains commits eed6b3eb20b97bef ("arm=
64:
> Split out platform options to separate Kconfig", [1]) and fbac1c81e2591c5d
> ("arm64: add Rockchip architecture entry", [2]), causing merge conflicts.
>=20
> Nothing I can't handle myself (for now), though...
>=20
> [1] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?=
h=3Dfor-next&id=EEd6b3eb20b97beff66ca59bb610ac73532278ee
> [2] https://git.kernel.org/cgit/linux/kernel/git/arm/arm-soc.git/commit/?=
h=3Dfor-next&id=FBac1c81e2591c5d1e5abd9a4477002f2afd0ab4

At this point I think it would best if you handled that.

I can start using different bases, or merging arm-soc/for-next etc.. into
a merge branch if it seems useful.
