From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 05 Sep 2008 08:14:34 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <aec7e5c30809050114je2ff5e9y3c19455dde169260@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 1, 2008 at 5:11 PM, Luca Santini
<luca.santini@spesonline.com> wrote:
> thanks for reply Magnus,
> in 2.6.26 everything works fine with irq 9;

I see that you install imask handlers for the flash and the ethernet:

+static int __init init_edosk7760_devices(void){
+       int ret = -1;
+
+       /* This is the Ethernet interrupt */
+       make_imask_irq(ETHERNET_IRQ);
+
+       /* This is the IntelStrata Flash interrupt */
+       make_imask_irq(0x0A);

Is the flash interrupt tested?

I suspect that the chips are connected straight to the IRL pins of the
processor. Using "individual interrupt mode" would make sense then. Do
you have access to schematics?

I recommend you to enable "individual interrupt mode" calling
plat_irq_setup_pins(IRQ_MODE_IRQ) from your board code. Try using
interrupt number 2 for IRL0 pin, 5 for IRL1, 8 for IRL2 and 11 for
IRL3. These values are calculated from vectors_irq[] in
setup-sh7760.c.

> trying to debug a little kernel/irq/manage.c i found that
> in 2.6.26 in function setup_irq()
>
>        compat_irq_chip_set_default_handler(desc);
>
> is called;
>
> otherwise in 2.6.27-rc4 :
>
>        __irq_set_trigger()
>
> is called with
>        chip->set_type = NULL
>
>
> i tried (for debug) to force in smc91x.h
>        #define SMC_IRQ_FLAGS           0
> to force using  compat_irq_chip_set_default_handler(desc);
> but what i get is a loop of
>
> "Unable to handle kernel NULL pointer dereference..."

This may be because the imask interrupt controller code doesn't
support interrupt type or something. I'm not sure.

/ magnus
