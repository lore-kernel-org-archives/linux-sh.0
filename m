From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Apr 2014 07:53:01 +0000
Subject: Re: [ PATCH v2 00/17] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <20140416075301.GD12344@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 16, 2014 at 09:15:35AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Apr 16, 2014 at 2:18 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > This patchset enables the PM runtime code in drivers/sh/pm_runtime.c when
> >> > running a multi-platform ARM kernel including support for shmobile.
> >> > Before this code was only enabled for legacy shmobile kernels, leading to
> >> > disabled clocks in multiplatform kernels, depending on implicit reset state
> >> > or on the bootloader.
> >> > It also contains some related cleanups, and removals of workarounds.
> >
> > I am wondering what kind of overhead this introduces for non shmobile
> > platforms that use a kernel compiled with ARCH_SHMOBILE_MULTI enabled.
> 
> The only overhead for non-shmobile platforms is the compilation of the code,
> and the late_initcall(sh_pm_runtime_late_init), which will return immediately.
> It's not enabled unless called from a shmobile .init_machine.

Thanks, that sounds entirely reasonable to me.
