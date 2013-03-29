From: Simon Horman <horms@verge.net.au>
Date: Fri, 29 Mar 2013 04:03:44 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: move global functions to each header
Message-Id: <20130329040343.GG13429@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87zjxnlxlj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zjxnlxlj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 28, 2013 at 08:32:13PM +0900, Magnus Damm wrote:
> On Thu, Mar 28, 2013 at 5:47 PM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > These patches move each CPUs global functions from common.h to each header.
> > Latest APE6/M1/H2 already did it.
> > I didn't test these patches on real board,
> > but, did compile test
> >
> > Kuninori Morimoto (4):
> >       ARM: shmobile: sh7372: move global functions to sh7372.h
> >       ARM: shmobile: sh73a0: move global functions to sh73a0.h
> >       ARM: shmobile: r8a7740: move global functions to r8a7740.h
> >       ARM: shmobile: r8a7779: move global functions to r8a7779.h
> 
> Nice, I think these are definitely a step in the right direction. I
> have not compiled the code, but I hope that all boards and SoC code
> include the expected pre-soc header file where needed already.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks for the prompt ack!

I have queued these up for v3.10 in the soc branch.
