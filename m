From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2014 21:31:47 +0000
Subject: Re: non-Multiplatform APE6EVM broken in v3.18-rc1
Message-Id: <CAMuHMdXH4+mprxbg+b9i0DhRXtG6uUw3M9xr9P=zzKHw69YL7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141028004131.GA8280@verge.net.au>
In-Reply-To: <20141028004131.GA8280@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Oct 29, 2014 at 3:08 AM, Simon Horman <horms@verge.net.au> wrote:
> rcar_thermal rcar_thermal: Runtime PM disabled, clock forced on.
> rcar_thermal rcar_thermal: 3 sensor probed
> sh_mobile_sdhi sh_mobile_sdhi.0: Runtime PM disabled, clock forced on.

BTW, any specific reason CONFIG_PM_RUNTIME is not enabled in
ape6evm_defconfig?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
