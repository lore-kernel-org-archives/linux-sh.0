From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Oct 2013 03:40:12 +0000
Subject: Re: [PATCH v2 2/3] ARM: shmobile: emev2: Add clock tree description in DT
Message-Id: <20131009034011.GN15065@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131008143040.52f36df8edb7ab63224d8433@ops.dti.ne.jp>
 <20131008143307.9270bd3307a0524d89088c2a@ops.dti.ne.jp>
 <CANqRtoT0EYcn6U_-Zin7eryiYGwb0C16AyLXtnsQ0Srt1PTG=w@mail.gmail.com>
In-Reply-To: <CANqRtoT0EYcn6U_-Zin7eryiYGwb0C16AyLXtnsQ0Srt1PTG=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 08, 2013 at 02:54:26PM +0900, Magnus Damm wrote:
> On Tue, Oct 8, 2013 at 2:33 PM,  <takasi-y@ops.dti.ne.jp> wrote:
> > Add minimum clock tree description to .dts file.
> > This provides same set of clocks as current sh-clkfwk version .c
> > code does.
> >
> > Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Thanks.

I plan to add this patch to a new topic branch,
topic/emev2-common-clock, in the renesas tree and
queue it up from there for inclusion in mainline
if/when the first patch of this series is accepted
by Mike Turquette.
