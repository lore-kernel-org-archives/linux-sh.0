From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 27 Jan 2009 21:48:31 +0000
Subject: Re: [PATCH] dma: fix up broken comparison in
Message-Id: <20090127134831.3dd04182.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com>
	<1232488507.6794.8.camel@localhost.localdomain>
	<20090121033951.GB14094@linux-sh.org>
	<20090121081118.GA14537@linux-sh.org>
In-Reply-To: <20090121081118.GA14537@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: adrian@newgolddream.dyndns.info, lkmladrian@gmail.com, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, penberg@cs.helsinki.fi, dbaryshkov@gmail.com, penguin-kernel@i-love.sakura.ne.jp, lg@denx.de, hannes@cmpxchg.org

On Wed, 21 Jan 2009 17:11:19 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> @@ -118,31 +118,32 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t size,
>  	mem = dev->dma_mem;
>  	if (!mem)
>  		return 0;
> -	if (unlikely(size > mem->size))
> - 		return 0;
> +
> +	*ret = NULL;
> +
> +	if (unlikely(size > (mem->size << PAGE_SHIFT)))
> +		goto err;

Looks a bit broken on 64-bit.

`size' is ssize_t (long).

`mem->size' is `int'.

The left shift can overflow and cause badnesses.

> +	*dma_handle = mem->device_base + (pageno << PAGE_SHIFT);
> +	*ret = mem->virt_base + (pageno << PAGE_SHIFT);

Ditto.


Maybe it's a can't-happen (why?), but...
