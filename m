From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Feb 2009 02:04:10 +0000
Subject: Re: [PATCH] sh: Update dma-sh api
Message-Id: <aec7e5c30902261804w2853c085p1d35036b6c37e6a2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49A668C4.2020608@renesas.com>
In-Reply-To: <49A668C4.2020608@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Iwamatsu-san,

On Thu, Feb 26, 2009 at 7:02 PM, Nobuhiro Iwamatsu
<iwamatsu.nobuhiro@renesas.com> wrote:
> Add DMA support of new SH CPU and the change of definition.
>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Thanks for your work on this. I have one main question and a few
nitpicking comments on your patch.

Question:

Does this patch build on top of the reworked sh775x, sh7780 and sh7785
interrupt vectors? The patchset pointed out below modifies the DMAC
interrupt to only use a single linux interrupt instead of multiple
with broken masking:

http://patchwork.kernel.org/patch/8592/

> --- /dev/null
> +++ b/arch/sh/include/asm/dma-sh.h
> @@ -0,0 +1,151 @@
> +/*
> + * arch/sh/drivers/dma/dma-sh.h

Header comment mismatch. =)

Cheers,

/ magnus
