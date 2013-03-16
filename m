From: Simon Horman <horms@verge.net.au>
Date: Sat, 16 Mar 2013 08:54:44 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Add R-Car M1A Bock-W support
Message-Id: <20130316085438.GB4075@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 16, 2013 at 12:40:53PM +0900, Magnus Damm wrote:
> Hi Morimoto-san, Simon,
> 
> On Mon, Mar 4, 2013 at 4:17 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> >
> > Hi Simon
> >
> > These are R-Car M1A chip and Bock-W board support
> >
> > Bock-W board needs ${LINUX}/arch/arm/tools/mach-types
> >
> > bockw                  MACH_BOCKW              BOCKW                   3386
> >
> > ARM Web site already has Bock-W, mach-types will be updated
> > if upstream kernel has it.
> 
> Ok, I understand that Bock-W has been added via the wonderful web interface.
> 
> But does the mach-type file really get updated these days? When was
> the last time anyone updated that file with updates from the web
> interface?

The last commit to upstream that added anything to mach-type is
dated the 26th of April 2012 and was included in v3.4-rc4.

> I recall last year trying to use an already existing mach-type for
> KZM9D but that was removed and I was requested to use DT instead.

That is my recollection too.

Surely we need to initialise the board using DT.  Even if it is a very
minimal DT initialisation that hooks into C code. And even if
ARM_APPENDED_DTB is needed due to boot loader limitations.
