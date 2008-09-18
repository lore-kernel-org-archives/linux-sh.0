From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Sep 2008 11:28:53 +0000
Subject: Re: [PATCH] edosk7760 physmap
Message-Id: <20080918112853.GA2621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48D22444.90802@spesonline.com>
In-Reply-To: <48D22444.90802@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 18, 2008 at 11:49:56AM +0200, Luca Santini wrote:
> The default bootloader (ETS) partition is 256KB.
> Sorry for previous mistake,
> 
> 
> 
> diff --git a/arch/sh/boards/board-edosk7760.c 
> b/arch/sh/boards/board-edosk7760.c
> index 4890ba7..9b1ec68 100644
> --- a/arch/sh/boards/board-edosk7760.c
> +++ b/arch/sh/boards/board-edosk7760.c
> @@ -46,7 +46,7 @@ static struct mtd_partition 
> edosk7760_nor_flash_partitions[] = {
>        {
>                .name = "bootloader",
>                .offset = 0,
> -               .size = (1 * 1024 * 1024), /*1MB*/
> +               .size = (256 * 1024), /*256KB*/
>                .mask_flags = MTD_WRITEABLE,    /* Read-only */
>        }, {
>                .name = "kernel",
> 
More whitespace damage. Please read Documentation/email-clients.txt

I'll apply it by hand this time.
