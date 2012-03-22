From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 22 Mar 2012 03:28:54 +0000
Subject: Re: Migo-R (SH7722) vs. NUMA
Message-Id: <20120322032854.GF26543@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8762egpvhn.fsf@schwinge.name>
In-Reply-To: <8762egpvhn.fsf@schwinge.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 08, 2012 at 03:22:08PM +0100, Thomas Schwinge wrote:
> Hi!
> 
> On Thu, 8 Mar 2012 00:04:28 -0800, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:
> > > > I forgot detail of MIGO-R.
> > > > But in my quick check,
> > > > my MIGO-R .config doesn't have CONFIG_NUMA since around v2.6.32-rc5
> > > 
> > > Hmm, where do you see/check that?
> > > 
> > >     $ git blame -L /^CONFIG_NUMA/,+1 v3.2 -- arch/sh/configs/migor_defconfig 
> > >     70f784ec (Magnus Damm 2008-02-07 00:38:24 +0900 16) CONFIG_NUMA=y
> > 
> > Ahh.. sorry for my confusion.
> > It was not migor_defconfig.
> > It is my local .config series which worked correctly on migo-r each linux version :)
> > unfortunately (?) defconfig sometimes doesn't work...
> 
> I'm not an expert on this, but here is what I think should be done: a)
> fix CONFIG_NUMA (apparently it used to work before the commit I
> referenced in my original email), or b) tag it as broken/unsupported and
> make sure it can't be enabled (and obviously don't enable it in the
> default configuration).  Which of the two is it?
> 
If memory serves, this is one of the things that was outstanding from the
memblock conversion, which then got put on hold again while the memblock
API refactorig was taking place. Now that things have settled we can take
a look at fixing up whats outstanding. We can flag it as broken in the
interim I suppose, although since most people enable broken
unconditionally anyways it doesn't make much of a functional difference.
