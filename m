From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 27 Aug 2009 02:39:39 +0000
Subject: Re: [BUG] arch/sh/include/mach-common/mach/sh7785lcr.h: PCA9564_ADDR is 29bit-only
Message-Id: <20090827023939.GB696@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A95800A.7020603@gentoo.org>
In-Reply-To: <4A95800A.7020603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 26, 2009 at 08:33:46PM +0200, Ra?l Porcel wrote:
> Since some months ago i noticed that with newer kernels the RTC on the
> SH7785LCR stopped working when running on 32bit mode. I just found out
> this is due to a commit that reverted the declaration of the
> PCA9564_ADDR address for both 29bit and 32bit mode. The current address
> only works on 29bit mode.
> 
> The bad commit is the following:
> 
> http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commitdiff;h{ce6c2740fab36708233e998a9e53115649b193
> 
> And it makes this error on 32bit mode:
> 
> rtc-rs5c372 0-0032: can't read registers
> rtc-rs5c372: probe of 0-0032 failed with error -5
> PCA9564/PCA9665 at 0x06000000 registered.

Shimoda-san?
