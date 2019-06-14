From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Jun 2019 08:35:20 +0000
Subject: Re: [PATCH 15/17] binfmt_flat: move the MAX_SHARED_LIBS definition to binfmt_flat.c
Message-Id: <e000b92e-a047-936e-c20a-9cc8b4f524bb@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
 <20190613070903.17214-16-hch@lst.de>
In-Reply-To: <20190613070903.17214-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hello!

On 13.06.2019 10:09, Christoph Hellwig wrote:

> MAX_SHARED_LIBS is an implementation detail of the kernel loader,
> and should be kept away from the file format definition.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/binfmt_flat.c     | 6 ++++++
>   include/linux/flat.h | 6 ------
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index 0ca65d51bb01..ccd9843e979e 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -68,6 +68,12 @@
>   #define RELOC_FAILED 0xff00ff01		/* Relocation incorrect somewhere */
>   #define UNLOADED_LIB 0x7ff000ff		/* Placeholder for unused library */
>   
> +#ifdef CONFIG_BINFMT_SHARED_FLAT
> +#define	MAX_SHARED_LIBS			(4)
> +#else
> +#define	MAX_SHARED_LIBS			(1)
> +#endif

    Perhaps the time to remove ()?

[...]

MBR, Sergei
