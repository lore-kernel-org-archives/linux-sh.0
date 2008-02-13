From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 13 Feb 2008 00:04:07 +0000
Subject: Re: [PATCH] sm501: Add uart support
Message-Id: <20080212160407.2e2f64ce.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080208095742.2041.46016.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080208095742.2041.46016.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, ben@fluff.org, linux-sh@vger.kernel.org

On Fri, 08 Feb 2008 18:57:42 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

>  	smdev = kzalloc(sizeof(struct sm501_device) +
> -			sizeof(struct resource) * res_count, GFP_KERNEL);
> +			(sizeof(struct resource) * res_count) +
> +			platform_data_size, GFP_KERNEL);
>
> ...
>
> +		smdev->pdev.resource = (struct resource *)(smdev+1);

So this driver plays party tricks with memory allocation and the C type
system.

We could at least add

	struct resource resources[0];

to the end of `struct sm501_device' to avoid the type abuse.  Or we could
even get radical and splurge four bytes on a `struct resource *'.  But
please, not this.


Oh well. A pre-existing problem.
