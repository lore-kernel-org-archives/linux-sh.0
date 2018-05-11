From: Rich Felker <dalias@libc.org>
Date: Fri, 11 May 2018 02:06:34 +0000
Subject: Re: early alloc change broke sh
Message-Id: <20180511020634.GQ1392@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20180511000128.GA23149@brightrain.aerifal.cx>
In-Reply-To: <20180511000128.GA23149@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, May 10, 2018 at 08:01:28PM -0400, Rich Felker wrote:
> Since commit 0fa1c579349fdd90173381712ad78aa99c09d38b (of/fdt: use
> memblock_virt_alloc for early alloc), attempting to boot on sh (j2,
> nommu) fails with OOM:
> 
> [    0.000000] bootmem alloc of 7836 bytes failed!
> [    0.000000] Kernel panic - not syncing: Out of memory
> 
> I suspect there are significant differences in memblock_virt_alloc and
> memblock_alloc (perhaps specific to nommu?). It looks like microblaze
> was also affected:
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1801.1/02200.html
> 
> I'll continue looking for a solution but I wanted to let you know
> right away in case you might know what's wrong and have a fix. It
> would be nice if we could get a fix for this regression in 4.17 since
> multiple archs are broken.

The problem seems to be that a working memblock_virt_alloc depends on:

	#if defined(CONFIG_HAVE_MEMBLOCK) && defined(CONFIG_NO_BOOTMEM)

Otherwise, it's a thin wrapper around __alloc_bootmem, which is not
equivalent to the old memblock_alloc call.

Rich
