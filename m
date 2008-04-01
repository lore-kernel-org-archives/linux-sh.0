From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Date: Tue, 01 Apr 2008 23:26:14 +0000
Subject: Re: HugeTLB vs. SH3 cpu
Message-Id: <29495f1d0804011626n2399d69aj7566df7f78953458@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080401225809.GC32269@cs181133002.pp.htv.fi>
In-Reply-To: <20080401225809.GC32269@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: wli@holomorphy.com, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 4/1/08, Adrian Bunk <bunk@kernel.org> wrote:
> fs/Kconfig says:
>
>  config HUGETLBFS
>         bool "HugeTLB file system support"
>         depends on X86 || IA64 || PPC64 || SPARC64 || (SUPERH && MMU) || BROKEN
>
>
>  arch/sh/mm/Kconfig says:
>
>  choice
>         prompt "HugeTLB page size"
>         depends on HUGETLB_PAGE && (CPU_SH4 || CPU_SH5) && MMU

So the problem is that SH3 is allowed to enable
HUGETLB_PAGE/HUGETLBFS, but only SH4/5 define the HPAGE_SHIFT macro,
due to some #ifdeffery on the hugepage size. So either the choice
needs to be extended to include CPU_SH3 (which builds here, when
changed) or the HUGETLBFS conditional needs to depend more
specifically on SH4/5 and not just SUPERH. I think the arch maintainer
has to make that call, as I don't know the hardware to say if SH3
actually supports multiple hugepage sizes.

Thanks,
Nish
