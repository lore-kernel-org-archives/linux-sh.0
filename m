From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 05:01:06 +0000
Subject: Re: [PATCH] sh: kfr2r09: add the reason to change PLL/FLL
Message-Id: <20090914050106.GD15078@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <utyz9kg1v.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2009 at 06:05:00PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  .../mach-kfr2r09/mach/partner-jet-setup.txt        |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
> index a19ac31..700e5ae 100644
> --- a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
> +++ b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
> @@ -27,6 +27,8 @@ ED 0xff800020, 0xa5a50001
>  ED 0xfec10000, 0x0000001b
>  
>  LIST "setup clocks"
> +LIST "To avoid the frequency of RF, PLL and FLL are changed"
> +LIST "This frequency influences the reception sensitivity"
>  ED 0xa4150004, 0x00000050
>  ED 0xa4150000, 0x91053508
>  WAIT 1

I'm not really sure what you mean here. Do you mean to say that PLL and
FLL are adjusted for optimal RF reception?
