From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 08:31:01 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <CAMuHMdWsUkQN-+h07Zf2snbD9bEw49_+rasY4zS8QcvqA+aXUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
	<2462101.Er8OZg9N24@avalon>
	<20141211214732.GC21482@katana>
	<1729516.HWbfnj3Cpn@avalon>
	<20141215064306.GN16827@intel.com>
In-Reply-To: <20141215064306.GN16827@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org

Hi Vinod,

On Mon, Dec 15, 2014 at 7:43 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Dec 11, 2014 at 11:52:10PM +0200, Laurent Pinchart wrote:
>> On Thursday 11 December 2014 22:47:32 Wolfram Sang wrote:
>> > > > Note that the I2C drives uses subsys_initcall() for historic reasons,
>> > > > while the DMA driver uses module_init(). This is hard to revert without
>> > > > introducing potential regressions on older boards. So, the I2C DMA
>> > > > support needs to handle deferred probe definately. I am with Laurent, I
>> > > > don't see any other way, but I'd be glad to be enlightened...
>> > >
>> > > While I believe that requesting the channel at transfer time is the good
>> > > solution, I think we should still try to move to module initcalls where
>> > > possible. The risk of regressions is real so proper testing is needed. My
>> > > question is, have you tried it ?
>> >
>> > I would need to test all boards using this driver to not fail booting.
>> > Usually I2C drivers are moved to subsys_initcall because they need
>> > access to something critical (PMIC, GPIOs...) early. I don't see a sane
>> > way to do that testing.
>>
>> Still, I would like to get a better view on the problems we should expect, by
>> testing this on the latest boards for instance.
>>
>> > Other than that, even if we move to module_init, we reduce the chance of
>> > getting a deferred probe, but we do not eliminate it...
>>
>> Sure, but reducing the chance of deferred probe is a good idea in my opinion
>> :-)
> Okay so what is the issue here, this statement is a bit worrying. Why do
> you guys want to reduce the chance of deferred probe? I assumed that issue was
> the channels availability...

Please let me summarize...

During probe of a DMA client driver, the DMA engine driver may not be available,
causing dma_request_slave_channel*() to return -EPROBE-DEFER.
There are actually two different reasons that the DMA engine driver may not
be available:
  1. The DMA engine driver hasn't been initialized yet, due to probe order.
     This is more likely to happen with i2c client drivers, as they
are initialized
     from subsys_initcall() instead of module_init() (E.g. I never saw
it with the
     spi-rspi driver).
     => The DMA client driver wants to return -EPROBE_DEFER too, and
       retry later.
  2. The DMA engine driver is not included in the kernel build.
     => The DMA client driver wants to fall back to PIO.

Now, how to distinguish between the two cases above?

Currently, e.g. i2c-sh_mobile always returns -EPROBE_DEFER, never falling
back to PIO, breaking case 2. While e.g. spi-rspi always falls back to PIO,
which is suboptimal in case 1 (but I never encountered that case with spi).

Solutions under consideration:
  1. Wolfram posted a patch to make i2c-sh_mobile fall back to PIO, and retry
     DMA initialization in every request, so it will switch to DMA
when it becomes
     available. But this is suboptimal, as it adds overhead to every
request (and
     DMA may never become available in case 2).

  2. Delay i2c initialization, by moving from subsys_initcall() to
module_init(),
      in the hope the i2c client driver will be initialized after the
DMA engine.
     This is being discussed in the thread you quoted above.

I hope this explains the problem well.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
