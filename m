From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jun 2014 08:33:39 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: EMEV2 init delay update
Message-Id: <20140606083336.GB27546@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605053149.19066.90593.sendpatchset@w520>
In-Reply-To: <20140605053149.19066.90593.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 05, 2014 at 10:15:15AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Thu, Jun 5, 2014 at 7:31 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > ARM: shmobile: EMEV2 init delay update
> >
> > [PATCH 01/03] ARM: shmobile: Update EMEV2 DTS to include CPU frequency
> > [PATCH 02/03] ARM: shmobile: Use shmobile_init_delay() on EMEV2
> > [PATCH 03/03] ARM: shmobile: Get rid of redundant EMEV2 mach callbacks
> >
> > These patches clean up the EMEV2 SoC code. The CPU Frequency is put into
> > DTS, code is adjusted to read out the frequency from DTS, and the EMEV2
> > SoC callbacks are cleaned up slightly.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Thanks, looks fine to me.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, I will queue these up.
