From: Nicolas Pitre <nico@fluxnic.net>
Date: Wed, 18 Nov 2015 21:36:16 +0000
Subject: RE: [PATCH v3] ARM: xip: Use correct symbol for end of ROM marker
Message-Id: <alpine.LFD.2.20.1511181635180.22569@knanqh.ubzr>
List-Id: <linux-sh.vger.kernel.org>
References: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
 <HK2PR06MB05619FACB3725B6F5B2299718A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161605070.5826@knanqh.ubzr>
 <HK2PR06MB056142FFDA4E99A764DF9ECB8A1E0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511161730030.5826@knanqh.ubzr>
 <HK2PR06MB05614D47A9C35ECB4CA72D3F8A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511162127180.5826@knanqh.ubzr>
 <HK2PR06MB056175E6E4356DD8C3566D758A1D0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511172255410.22569@knanqh.ubzr>
 <CANqRtoTkHecGEsbi3EtM8dkHQ=V0RGm7iZcU_igMqLE7Od=xBA@mail.gmail.com>
 <alpine.LFD.2.20.1511180841000.22569@knanqh.ubzr>
 <alpine.LFD.2.20.1511181156250.22569@knanqh.ubzr>
 <HK2PR06MB0561CA7E856CEAA89D0752488A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <alpine.LFD.2.20.1511181445550.22569@knanqh.ubzr>
 <HK2PR06MB05610952B8DAE3C16E1ABC6E8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
In-Reply-To: <HK2PR06MB05610952B8DAE3C16E1ABC6E8A1C0@HK2PR06MB0561.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 18 Nov 2015, Chris Brandt wrote:

> > Probably the best way to fix it would be something like:
> >
> > in asm/memory.h or similar:
> >
> > #ifdef CONFIG_XIP_KERNEL
> > #define PHYS_OFFSET_FIXUP \
> >	( XIP_VIRT_ADDR(CONFIG_XIP_PHYS_ADDR) - PAGE_OFFSET + \
> >	  PLAT_PHYS_OFFSET - CONFIG_XIP_PHYS_ADDR ) #else #define
> > PHYS_OFFSET_FIXUP 0 #endif
> >
> > And then, after my patch is applied, changing:
> >
> > __v7_setup_stack_ptr:
> >        .word   __v7_setup_stack - .
> >
> > into:
> >
> > __v7_setup_stack_ptr:
> >        .word   __v7_setup_stack - . + PHYS_OFFSET_FIXUP
> >
> > should do the trick. This way it'll work for all those places where
> > the code is getting at the data area when the MMU is off with no XIP
> > conditionals in the code.
> 
> 
> Tested....it works!

Excellent.


Nicolas
