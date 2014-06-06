From: Simon Horman <horms@verge.net.au>
Date: Fri, 06 Jun 2014 08:38:58 +0000
Subject: Re: [PATCH v2 00/03] ARM: shmobile: r7s72100 / Genmai init delay update (V2)
Message-Id: <20140606083857.GD27546@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606052841.17594.9846.sendpatchset@w520>
In-Reply-To: <20140606052841.17594.9846.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2014 at 08:39:55AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Fri, Jun 6, 2014 at 7:28 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > ARM: shmobile: r7s72100 / Genmai init delay update (V2)
> >
> > [PATCH v2 01/03] ARM: shmobile: Update r7s72100 DTS to include CPU frequency
> > [PATCH v2 02/03] ARM: shmobile: Use shmobile_init_delay() on Genmai boards
> > [PATCH v2 03/03] ARM: shmobile: Use shmobile_init_delay() on r7s72100
> >
> > These patches clean up the r7s72100 SoC and Genmai board code. The CPU
> > Frequency is put into DTS followed by SoC and board code that gets
> > adjusted to read out the frequency from DTS.
> 
> Thanks, now 03/03 looks fine, too!
> 
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Good morning :)

I have queued these up.
