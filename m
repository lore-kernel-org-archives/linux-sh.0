From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Nov 2010 07:49:44 +0000
Subject: Re: [PATCH 0/2] GPIO support for sh73a0/ag5evm
Message-Id: <20101119074943.GA28165@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101119130656.8b8a50b9.takashi.yoshii.zj@renesas.com>
In-Reply-To: <20101119130656.8b8a50b9.takashi.yoshii.zj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 19, 2010 at 01:06:56PM +0900, Takashi Yoshii wrote:
> These patches add GPIO/Pin-multiplex support to sh73a0 CPU and ag5evm board.
> A few of them have been tested to work by using keysc, LEDs, switches and others.
> Most of others have been checked only by eyes, comparing with hardware manual.
> This system seems to be too big to do full test, sorry.
> 
> Takashi YOSHII (2):
>   ARM: mach-shmobile: Add sh73a0 pinmux support
>   ARM: mach-shmobile: ag5evm: use gpio.
> 
Applied now, thanks.
