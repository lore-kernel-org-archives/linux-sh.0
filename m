From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 05 Sep 2008 08:33:40 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080905083339.GA22135@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Fri, Sep 05, 2008 at 05:14:34PM +0900, Magnus Damm wrote:
> On Mon, Sep 1, 2008 at 5:11 PM, Luca Santini
> <luca.santini@spesonline.com> wrote:
> > thanks for reply Magnus,
> > in 2.6.26 everything works fine with irq 9;
> 
> I see that you install imask handlers for the flash and the ethernet:
> 
> +static int __init init_edosk7760_devices(void){
> +       int ret = -1;
> +
> +       /* This is the Ethernet interrupt */
> +       make_imask_irq(ETHERNET_IRQ);
> +
> +       /* This is the IntelStrata Flash interrupt */
> +       make_imask_irq(0x0A);
> 
> Is the flash interrupt tested?
> 
> I suspect that the chips are connected straight to the IRL pins of the
> processor. Using "individual interrupt mode" would make sense then. Do
> you have access to schematics?

According to the schematics, 15 irqs are connected to a CPLD which creates
the 4bit IRL value. Unfortunately there is no way to individually mask them
in the CPLD itself (it has no databus connection).

MfG,
	Manuel Lauss
