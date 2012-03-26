From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 26 Mar 2012 10:38:54 +0000
Subject: Re: [PATCH] ARM: fixup section mismatch warning for alloc_init_pud()
Message-Id: <20120326103854.GG30455@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87398zswkj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87398zswkj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Mar 23, 2012 at 05:41:52AM +0000, Kuninori Morimoto wrote:
> This patch fixup below warning
> 
> WARNING: arch/arm/mm/built-in.o(.text+0x2320):
> Section mismatch in reference from the function alloc_init_pud()
> to the function .init.text:alloc_init_section()
> The function alloc_init_pud() references
> the function __init alloc_init_section().
> This is often because alloc_init_pud lacks a __init
> annotation or the annotation of alloc_init_section is wrong.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
