From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Nov 2014 15:07:40 +0000
Subject: Re: [PATCH v4 0/6] sh73a0 common clock framework implementation
Message-Id: <CAO3366z9uu-f+QRizYWgxsFo8iq-1E_T6LLHie+-opWotDL=oA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 7, 2014 at 3:20 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulrich
>
> With this series applied (also with the previous version), kzm9g-multiplatform
> (with sh73a0-kzm9g-reference.dtb) locks up after initializing ttySC4, i.e.
> after printing
>
>     sh-sci e6c80000.serial: ttySC4 at MMIO 0xe6c80000 (irq = 110,
> base_baud = 0) is a scifa
>
> If I comment out the "clocks" property of scifa4 in the dtsi, it continues
> (without any serial output, of course).
>
> Do you have any clue?

You might have better luck with the div6 patch applied as well. The
upstream div6 driver resets the EXSRC bits when setting the divider,
and IIRC that switches the parent of sub from extal2 to pll1_div2 on
the kzm9g board. With the patch applied, the bits are preserved.

CU
Uli
