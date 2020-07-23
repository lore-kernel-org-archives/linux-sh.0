From: Rich Felker <dalias@libc.org>
Date: Thu, 23 Jul 2020 17:52:11 +0000
Subject: Re: Suggested patches for merging
Message-Id: <20200723175210.GA6949@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
In-Reply-To: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 23, 2020 at 02:34:31PM +0200, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 7/17/20 9:11 AM, John Paul Adrian Glaubitz wrote:
> > After updating my SH kernel to the latest git version and applying various proposed
> > patches on top, my machines runs very stable. I suggest merging the following patches:
> 
> I have collected all patches that I am currently using on my SH-7785LCR in a repository
> on github, see [1].
> 
> These contain all patches by Geert, Christoph, my patch, Michael's patches and the
> two fixes by Peter Zijlstra and Matthew Wilcox.
> 
> One patch by Peter Zijlstra (sh_tlb: Fix __pmd_free_tlb()) did not apply, I assume
> because it must be committed with the whole series [2].
> 
> Adrian
> 
> > [1] https://github.com/glaubitz/linux/commits/sh-queue
> > [2] https://marc.info/?l=linux-mm&m9498447020445&w=2

Have you checked my for-next? It already has all of these except the
new seccomp series.

Rich
