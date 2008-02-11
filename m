From: Jeff Garzik <jgarzik@pobox.com>
Date: Mon, 11 Feb 2008 15:31:02 +0000
Subject: Re: [PATCH] 8139too fix for Dreamcast
Message-Id: <47B06A36.5030201@pobox.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60802080321o6f6c8ca7x768d911a6f1fba0b@mail.gmail.com>
In-Reply-To: <8b67d60802080321o6f6c8ca7x768d911a6f1fba0b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian McMenamin <lkmladrian@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

Adrian McMenamin wrote:
> Updates the 8139too driver to work with recently added
> (a724605cb7a66d423a494a395f9a8ba871b8a1eb) declared coherent memory
> patch for the Dreamcast.
> 
> Jeff - I am assuming you are still the maintainer and I guess Paul
> should also ack this as it is SH related.
> 
> Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
> 
> -----
> 
> 
> diff --git a/drivers/net/8139too.c b/drivers/net/8139too.c
> index d373545..80f1cce 100644
> --- a/drivers/net/8139too.c
> +++ b/drivers/net/8139too.c
> @@ -168,7 +168,7 @@ static int debug = -1;
>   * Warning: 64K ring has hardware issues and may lock up.
>   */
>  #if defined(CONFIG_SH_DREAMCAST)
> -#define RX_BUF_IDX	1	/* 16K ring */
> +#define RX_BUF_IDX 0	/* 8K ring */
>  #else
>  #define RX_BUF_IDX	2	/* 32K ring */
>  #endif

applied...  yell if that's a problem Paul



