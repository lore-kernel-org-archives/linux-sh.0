From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 25 Jan 2011 07:15:02 +0000
Subject: Re: DMA
Message-Id: <20110125071502.GH11673@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTimW-PT801BUL8QQkhVpezX_VNw-1qLNRpeeoQFU@mail.gmail.com> <AANLkTinQWLOOSMS_8LcFkSmRT2K_CbQ+v2pH7FiNxqGo@mail.gmail.com> <AANLkTimC=6TA8eF6jFYzm_3RzXkQo9BwCMexdjfPKtEC@mail.gmail.com> <AANLkTinFJ54dCJPLANOmwejrBrb=vw0m-BLtq9a7ys5s@mail.gmail.com> <AANLkTimiLJz-F3QMppVjh9ZaF8JbGeRawPgNme1dWjVJ@mail.gmail.com>
In-Reply-To: <AANLkTimiLJz-F3QMppVjh9ZaF8JbGeRawPgNme1dWjVJ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mahdi hamzeh <mahdy.hamzeh@gmail.com>
Cc: linux-sh@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org

On Mon, Jan 24, 2011 at 04:04:57PM -0700, mahdi hamzeh wrote:
> I am working on a research project for which I should be able to
> transfer data from memory to memory using DMA. I am working on a x86
> machine but I want my code to be architecture independent as much as
> possible. Please?accept?my?apology?if my question is too basic to be
> asked from this mailing list. Here is my problem:
> I?used "struct dma_chan" to define a channel structure but when I use
> "dma_request_channel" function to get a DMA channel, with all
> different possible masks including?DMA_MEMCPY,?DMA_PRIVATE,....
> anything, the function returns always NULL. This function is defined
> in "dmaengine.h".?I also tried a low level function to see dma channel
> availability?and "request_dma" function defined in "dma.h" works
> perfect.
> Any comment, help, document, program, reference anything that helps me
> to create a simple DMA transaction would really be appreciated.
> PS: There is a test program called dmatest.c is provided in the linux
> kernel files. I tried to get it compiled but I could not since the
> functions and structures used in this file has been changed in the
> kernel header files.
> 
I'm not sure how you selected the sh list as the best forum for this
inquiry (I assume it's because Guennadi has been doing a lot of dmaengine
driver work recently), but this is really something that's better suited
for l-k directly, with Dan CC'ed (as I've done here).

If you're looking for preliminary getting started information, then your
best bet is Documentation/crypto/async-tx-api.txt, as referenced in the
top-level MAINTAINERS.

The dmatest driver of course also provides you with some examples of how
to plug in to the API. In any event, I'm able to compile dmatest without
any difficulty, so I'm not sure what bitrot you are seeing, perhaps it's
something related to the driver you are using? You'll have to provide the
relevant bits from your .config or the errors you're seeing before anyone
will be able to point you in the right direction here.
