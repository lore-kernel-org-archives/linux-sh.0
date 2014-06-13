From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Jun 2014 07:51:33 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: rcar-gen2: rcar_gen2_scan_mem() updates
Message-Id: <20140613075130.GE15286@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1402562544-4527-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1402562544-4527-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 12, 2014 at 06:19:14PM +0900, Magnus Damm wrote:
> Hi Geert,
> 
> On Thu, Jun 12, 2014 at 5:42 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >         Hi Simon, Magnus,
> >
> > This is a small series with updates for rcar_gen2_scan_mem().
> >
> > The first one fixes compiler warnings due to commit
> > 9d0c4dfedd96ee54fc075b16d02f82499c8cc3a6 ("of/fdt:
> > update of_get_flat_dt_prop in prep for libfdt") landing in Linus' tree.
> > Note that this commit is not in renesas-devel-v3.15-20140612.
> >
> > The other two are fixes for the remaining review comments I had.
> > As I was touching the file anyway, I implemented them myself. Magnus, I
> > hope you don't mind.
> 
> No, I certainly don't mind. Actually, quite the opposite - thanks a
> lot for fixing up the code!
> 
> > Geert Uytterhoeven (3):
> >   [1/3] ARM: shmobile: rcar-gen2: Update for of_get_flat_dt_prop() update
> >   [2/3] ARM: shmobile: rcar-gen2: Use "1ULL" instead of "(u64)1"
> >   [3/3] ARM: shmobile: rcar-gen2: Remove useless copied section for LongTrail
> 
> Acked-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, I particularly enjoyed the use of the word evil
in one of the changelogs.

I will queue up all three patches.
