From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 05 Nov 2012 02:34:50 +0000
Subject: Re: [v2 PATCH 1/2] Add new uio device for dynamic memory allocation
Message-Id: <509725CA.4030809@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1348553352-14334-1-git-send-email-dhobsong@igel.co.jp> <1348553352-14334-2-git-send-email-dhobsong@igel.co.jp> <CAMuHMdWKByLXR-2wkiej=F1WPf7xePf3nMkUqwSf_hEJNNZbvg@mail.gmail.com>
In-Reply-To: <CAMuHMdWKByLXR-2wkiej=F1WPf7xePf3nMkUqwSf_hEJNNZbvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, hdk@igel.co.jp, Linux-Next <linux-next@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Geert,

On 2012/11/04 22:20, Geert Uytterhoeven wrote:
> On Tue, Sep 25, 2012 at 8:09 AM, Damian Hobson-Garcia
> <dhobsong@igel.co.jp> wrote:
>> are holding the device file open, the address returned to userspace is
>> DMA_ERROR_CODE.
> 
> Only a small subset of the architectures
> (arm/ia64/microblaze/openrisc/powerpc/sparc/x86)
> seem to define DMA_ERROR_CODE, causing everywhere else:
> 
> drivers/uio/uio_dmem_genirq.c: In function ‘uio_dmem_genirq_release’:
> drivers/uio/uio_dmem_genirq.c:95: error: ‘DMA_ERROR_CODE’ undeclared
> (first use in this function)
> drivers/uio/uio_dmem_genirq.c:95: error: (Each undeclared identifier
> is reported only once
> drivers/uio/uio_dmem_genirq.c:95: error: for each function it appears in.)
> drivers/uio/uio_dmem_genirq.c: In function ‘uio_dmem_genirq_probe’:
> drivers/uio/uio_dmem_genirq.c:238: error: ‘DMA_ERROR_CODE’ undeclared
> (first use in this function)
> make[1]: *** [drivers/uio/uio_dmem_genirq.o] Error 1
> make: *** [drivers/uio/] Error 2
> 
> (e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/7462173/)
> 
> Furthermore, none of them define it in <uapi/...>, so DMA_ERROR_CODE is not
> part of the userspace API (yet), while it is architecture-specific (some use 0,
> others ~0).
> 
Good points, thank you.  In that case, does fixing the value to
something like ~0 sound like a better (more portable) solution?

Damian

-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
