From: Rich Felker <dalias@libc.org>
Date: Wed, 23 Mar 2016 16:09:51 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <20160323160951.GM21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 23, 2016 at 11:11:04AM +0100, John Paul Adrian Glaubitz wrote:
> On 03/23/2016 11:05 AM, Magnus Damm wrote:
> > I have a couple of old SH boards that I can hook up to remote access
> > for you if that would help. Probably sh775x-based ones and maybe also
> > something with sh2a. Need to go through my old boxes in the attic to
> > find more detail. =)
> 
> I think it would be much better for actual kernel development to have
> physical access to the hardware. And if your SH boards are gaining
> dust in your attic anyway, why not send them out to support the
> new SH kernel maintainers?

Indeed. I appreciate the offer, but I don't think there's much that
can be done in the way of kernel development with only remote access,
at least not without a fancy setup to facilitate remote reboot and
reset to a known-working state. Magnus, do you mind if I contact you
again some point later if I find there's something where remote
testing would be helpful?

> > As for SH-X3, I recall seeing that board IRL at some point on the desk
> > next to me, but it was pretty rare even at that time so I highly doubt
> > you will have any luck finding it or any SMP capable SH SoC.
> 
> You can buy dual-core SH4 systems in Japan:
> 
> > http://www.apnet.co.jp/product/superh/ap-sh4ad-0a.html
> 
> With 460 USD a bit expensive though.

Yes, I'll keep it in mind for the future, though. Thanks for finding
this.

> > In the mean time, does the sh4 target in QEMU work in system emulator
> > mode? I recall user space emulation could run busybox at least.
> 
> Well, in that case qemu-system would actually the better choice as
> it allows to boot the kernel. And, yeah, that should work, too.

I've used qemu userspace emulation a good deal already for testing the
initial sh3/4 port of musl libc and later extending it to sh2/j2.
Unfortunately it doesn't work for multi-threaded testing, however,
because the pre-sh4a atomics rely on kernel scheduler help, and the
emulation of the sh4a ones is wrong in qemu (not actually atomic).

I've also used qemu system-level for some minimal kernel smoke
testing, but I'd be hesitant to rely on it, and there doesn't even
seem to be good documentation of what boards/hardware are emulated. At
some point I'm hoping qemu will be extended (I might work on this, but
I don't have time right now) to emulate a user-provided device tree
rather than just a few hard-coded boards.

> But, again, Rich should have real SH hardware for kernel development
> which is why I am donating him a LANDISK system which I am buying in
> Japan. I have great interest to get kernel support for SH back
> in shape and I am therefore happy to support anyone who wants to
> work on that.

Thank you very much, both for the donation and for taking the time to
work out the logistics of getting one and getting it to me.

Rich
