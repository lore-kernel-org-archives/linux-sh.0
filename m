From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 20 Jul 2020 13:42:38 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <661f7d56-bffc-f688-54e3-291cd5e7e18d@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <20200720133800.GA3084@lst.de>
In-Reply-To: <20200720133800.GA3084@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Christoph!

On 7/20/20 3:38 PM, Christoph Hellwig wrote:
> On Wed, Jul 15, 2020 at 01:12:33AM +0200, John Paul Adrian Glaubitz wrote:
>> Hello!
>>
>> I have applied Christoph's full series on top of Linus' tree and I can confirm that
>> the kernel boots fine on my SH-7785LCR board.
>>
>> Thus, for the whole series of patches:
>>
>> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> Any chance we get the patches queue up while you're all sorting out
> totally independent issues?

I would love to buy only Rich can do that. I'm fine with your patches
and would much appreciate if Rich could queue them up.

I'm also still waiting for my patch to be queued as well.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
