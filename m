From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jun 2014 08:13:56 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Get rid of redundant EMEV2 mach callbacks
Message-Id: <CAMuHMdU=B7K2nWx281zK7w6K7cPRFFaWtkrDKMza8pUQLkhUUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140213082628.30630.3186.sendpatchset@w520>
In-Reply-To: <20140213082628.30630.3186.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Jun 5, 2014 at 7:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0003/arch/arm/mach-shmobile/setup-emev2.c
> +++ work/arch/arm/mach-shmobile/setup-emev2.c   2014-05-29 17:15:54.000000000 +0900
> @@ -16,10 +16,9 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>   */
> -#include <linux/clk-provider.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
> -#include <linux/of_platform.h>
> +#include <linux/mm.h>

Why is <linux/mm.h> needed?

Ah, arch/arm/mach-shmobile/include/mach/common.h lacks a forward
declaration of "struct task_struct;".

And then you still need to add "#include <asm/page.h>" for PAGE_SHIFT,
as <asm/memory.h> uses that in __phys_to_pfn().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
