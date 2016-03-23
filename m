From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 23 Mar 2016 10:11:04 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <56F26BB8.4050708@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 03/23/2016 11:05 AM, Magnus Damm wrote:
> I have a couple of old SH boards that I can hook up to remote access
> for you if that would help. Probably sh775x-based ones and maybe also
> something with sh2a. Need to go through my old boxes in the attic to
> find more detail. =)

I think it would be much better for actual kernel development to have
physical access to the hardware. And if your SH boards are gaining
dust in your attic anyway, why not send them out to support the
new SH kernel maintainers?

> As for SH-X3, I recall seeing that board IRL at some point on the desk
> next to me, but it was pretty rare even at that time so I highly doubt
> you will have any luck finding it or any SMP capable SH SoC.

You can buy dual-core SH4 systems in Japan:

> http://www.apnet.co.jp/product/superh/ap-sh4ad-0a.html

With 460 USD a bit expensive though.

> In the mean time, does the sh4 target in QEMU work in system emulator
> mode? I recall user space emulation could run busybox at least.

Well, in that case qemu-system would actually the better choice as
it allows to boot the kernel. And, yeah, that should work, too.

But, again, Rich should have real SH hardware for kernel development
which is why I am donating him a LANDISK system which I am buying in
Japan. I have great interest to get kernel support for SH back
in shape and I am therefore happy to support anyone who wants to
work on that.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
