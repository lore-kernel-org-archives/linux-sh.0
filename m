From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 May 2012 23:34:41 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel
Message-Id: <CANqRtoRewJip+P6Oeay2SdMf2isT7kH__t+pGtuXQLw7mDTp5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Thu, May 24, 2012 at 10:18 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> SDHI0 card-detect GPIO IRQ on mackarel currently works, because it is the
> default configuration of IRQ26. However, we should not rely on this and
> should configure the function explicitly.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This looks like a regression fix. Can you please point out which
commit that caused this?

Thanks,

/ magnus
