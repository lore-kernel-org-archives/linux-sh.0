From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jul 2020 12:34:31 +0000
Subject: Re: Suggested patches for merging
Message-Id: <a5df1180-d440-8157-18a5-0d35afda2a6a@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
In-Reply-To: <8538a950-8e21-29c7-dd0e-fa6e49e2bcef@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

On 7/17/20 9:11 AM, John Paul Adrian Glaubitz wrote:
> After updating my SH kernel to the latest git version and applying various proposed
> patches on top, my machines runs very stable. I suggest merging the following patches:

I have collected all patches that I am currently using on my SH-7785LCR in a repository
on github, see [1].

These contain all patches by Geert, Christoph, my patch, Michael's patches and the
two fixes by Peter Zijlstra and Matthew Wilcox.

One patch by Peter Zijlstra (sh_tlb: Fix __pmd_free_tlb()) did not apply, I assume
because it must be committed with the whole series [2].

Adrian

> [1] https://github.com/glaubitz/linux/commits/sh-queue
> [2] https://marc.info/?l=linux-mm&m9498447020445&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
