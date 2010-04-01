From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Apr 2010 10:11:51 +0000
Subject: Re: PFC of SCIF 1
Message-Id: <o2kaec7e5c31004010311y2b79adc4ke6ebf6761d48c206@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Thu, Apr 1, 2010 at 7:06 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Sorry Magnus, I do not understand.
> I have ttySC0 as default console and the system works; now I'm writing my
> application for managing teh ttySC1 port for my specif problem.

If the boot loader usually sets up the pinmux and if the kernel does
not touch it then it will work. On SH the proper way to do this is to
let the kernel use the GPIO framework to configure the pinmux using
request_irq().

> Where can I find the PFC initialization for ttySC0 Port into the kernel tree?

Have a look at this:

damm@t400s ~/git/linux-2.6 $ find arch/sh | xargs grep gpio_request | grep SCIF
arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_SCK, NULL);
arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_RXD, NULL);
arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_TXD, NULL);
arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_CTS, NULL);
arch/sh/boards/mach-se/7724/setup.c:	gpio_request(GPIO_FN_SCIF3_I_RTS, NULL);
arch/sh/boards/mach-ecovec24/setup.c:	gpio_request(GPIO_FN_SCIF0_TXD, NULL);
arch/sh/boards/mach-ecovec24/setup.c:	gpio_request(GPIO_FN_SCIF0_RXD, NULL);
arch/sh/boards/mach-kfr2r09/setup.c:	gpio_request(GPIO_FN_SCIF1_RXD, NULL);
arch/sh/boards/mach-kfr2r09/setup.c:	gpio_request(GPIO_FN_SCIF1_TXD, NULL);
arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_SCIF0_CTS,
NULL);
arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_SCIF0_RTS,
NULL);
arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_SCIF0_SCK,
NULL);
arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_SCIF0_RXD,
NULL);
arch/sh/boards/mach-highlander/pinmux-r7785rp.c:	gpio_request(GPIO_FN_SCIF0_TXD,
NULL);
damm@t400s ~/git/linux-2.6 $

Cheers,

/ magnus
