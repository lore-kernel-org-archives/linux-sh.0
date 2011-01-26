From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 26 Jan 2011 21:31:35 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <201101262231.35682.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Why in
arch/sh/kernel/cpu/sh2a/setup-sh7203.c

#define STBCR3 0xfffe0408
#define STBCR4 0xfffe040c

void __init plat_early_device_setup(void)
{
	/* enable CMT clock */
	__raw_writeb(__raw_readb(STBCR4) & ~0x04, STBCR4);

	/* enable MTU2 clock */
	__raw_writeb(__raw_readb(STBCR3) & ~0x20, STBCR3);

	early_platform_add_devices(sh7203_early_devices,
				   ARRAY_SIZE(sh7203_early_devices));
}

we put out from the stand-by CMt and MTU and not SCIF?

Tnahks


On Wednesday 26 January 2011 19:28:08 Fabio Giovagnini wrote:
> In which arch/sh/boards/ could I study hoe to setup the clock framework for
> my board?
> P.S.
> I tried to build RSK+ board, not for mine, and running on mine teh kernel
> does not work.
> 
> Thanks in advance
> 
> On Thursday 20 January 2011 10:01:23 Magnus Damm wrote:
> > On Thu, Jan 20, 2011 at 5:43 PM, Fabio Giovagnini
> > 
> > <fabio.giovagnini@aurion-tech.com> wrote:
> > > Can I be sure the BRR setting algorithm used is proper for my sh2a
> > > 7203?
> > 
> > The BRR setting depends on the clock framework. And the clock
> > framework settings may depend on your board.
> > 
> > > Do you know if anyone tested teh last linux version on rsk+ 7203?
> > 
> > Not sure. I recall hacking on timer code on rsk7203 in April 2009,
> > after that I have no idea about the status.
> > 
> > / magnus

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
