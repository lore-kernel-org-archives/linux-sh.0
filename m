From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jul 2020 12:49:46 +0000
Subject: Re: [PATCH] sh: clk: Fix assignment from incompatible pointer type for ioreadX()
Message-Id: <c77eb720-1ded-f9d4-fbe4-92429e81857f@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200723082017.24053-1-krzk@kernel.org>
In-Reply-To: <20200723082017.24053-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Hi Krzysztof!

On 7/23/20 10:20 AM, Krzysztof Kozlowski wrote:
> Maybe because it depends on commit 58c4d8659186 ("sh: clkfwk: remove
> r8/r16/r32") which landed later?  Anyway it should go through your tree,
> I think.
> ---
>  drivers/sh/clk/cpg.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
> index a5cacfe24a42..fd72d9088bdc 100644
> --- a/drivers/sh/clk/cpg.c
> +++ b/drivers/sh/clk/cpg.c
> @@ -40,7 +40,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
>  {
>  	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
>  	if (clk->status_reg) {
> -		unsigned int (*read)(void __iomem *addr);
> +		unsigned int (*read)(const void __iomem *addr);
>  		int i;
>  		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
>  			(phys_addr_t)clk->enable_reg + clk->mapped_reg;

Is that a reverted patch, by any chance? The patch does not apply for me and looking at
the sources, the qualifier is already "const" [1].

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/sh/clk/cpg.c#n58

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
