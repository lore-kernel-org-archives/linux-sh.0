From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 29 Apr 2010 14:29:51 +0000
Subject: Re: [PATCH] sh: native_cpu_disable() build error when CONFIG_HOTPLUG_CPU=n
Message-Id: <20100429142951.GB9621@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <2055fb5d5b201eb36a3814cf0dc4658c33a33bcd.1272453051.git.matt@console-pimps.org>
In-Reply-To: <2055fb5d5b201eb36a3814cf0dc4658c33a33bcd.1272453051.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 28, 2010 at 12:11:30PM +0100, Matt Fleming wrote:
> arch/sh/kernel/smp.c:164: error: conflicting types for 'native_cpu_disable'
> /home/matt/src/kernels/sh-2.6/arch/sh/include/asm/smp.h:48: error: previous declaration of 'native_cpu_disable' was here
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Applied, thanks.
