From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 04:05:57 +0000
Subject: Re: [PATCH v2 1/6] ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
Message-Id: <CANqRtoT-bLmfraxpLHpfmLcn2NDaMUo7iRLAnxY1DG2+xy7NQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373037932-19918-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373037932-19918-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Sat, Jul 6, 2013 at 12:25 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Add a DMAC platform device and clock definitions for it on r8a73a4.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
>
> v2: preserve the original coding style in r8a73a4_add_standard_devices():
>     use a macro to register a DMA device.
>
>  arch/arm/mach-shmobile/clock-r8a73a4.c        |    4 +-
>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |   15 +++
>  arch/arm/mach-shmobile/setup-r8a73a4.c        |  120 +++++++++++++++++++++++++
>  3 files changed, 138 insertions(+), 1 deletions(-)

I'm quite fine with this patch, but can you please explain why you add
SDHI information in this patch?

Your later patches in the series don't make use of them anyway, and if
so they must be untested. I'd rather not have untested code upstream.
Or do you have any code ready that can extend the SDHI drivers on
r8a73a4 to make use of DMA?

Thanks,

/ magnus
