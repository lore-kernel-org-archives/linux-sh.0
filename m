From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 28 Jul 2008 09:30:21 +0000
Subject: Re: kernel (sometimes) boot
Message-Id: <20080728093021.GA26494@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <488D864C.30808@spesonline.com>
In-Reply-To: <488D864C.30808@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Luca,

On Mon, Jul 28, 2008 at 10:41:48AM +0200, Luca Santini wrote:
> Hi Manuel,
> sorry for my continous s_p_a_m but i'm ignorant and i need a lot of 
> support...
>
> what currently i have:
> a  (sometimes) booting 2.6.26-rc8_edosk7760-00210-g35534ad-dirty kernel on 
> a edosk_sh7760 board, with compiled-in:
> SCIF console
> smc eth91x support
> i2c-sh7760
> SoC sound support for sh7760 (NOT AC97)
>
>
> what currently i miss:
>
> . enabling " kernel modules versioning support" results in unbootable 
> kernel

That seems strange..  (There are other features which result in ubootable
kernels, notably every cache mode other than the default "write-back").


> . enabling features as <M> results in unloadable modules: (insmod: couldn't 
> find the kernel version the module was compiled for)

modules installed into wrong directory?  incorrect modules in rootfs?


> . loading smc91c96 driver fails at probe()

Check MMIO area (chip is at 0x02000000 - 0x0200001f according to the
ESDOK7760 manual available from renesas website if you didn't change any of
the DIP switches on the board), and correct IRQ (9 if I interpret the
schematics correctly)

Also, you need to edit drivers/net/smc91x.h and add an entry for your board
to the jungle of ifdefs in there.
I.e. like this:

---- 8< ----
[...]
#elif defined(CONFIG_SH_EDOSK7760)

#define SMC_CAN_USE_8BIT        0
#define SMC_CAN_USE_16BIT       1
#define SMC_CAN_USE_32BIT       0
#define SMC_NOWAIT              1

#define SMC_IO_SHIFT            0

#define SMC_inw(a, r)           inw((unsigned long)((a) + (r)))
#define SMC_outw(v, a, r)       outw(v, (unsigned long)((a) + (r)))
#define SMC_insw(a, r, p, l)    insw( (unsigned long)((a) + (r)), p, l)
#define SMC_outsw(a, r, p, l)   outsw((unsigned long)((a) + (r)), p, l)

#define RPC_LSA_DEFAULT         RPC_LED_TX_RX
#define RPC_LSB_DEFAULT         RPC_LED_100_10

#define SMC_IRQ_FLAGS           (0)

#define set_irq_type(irq, type) do { } while (0)

#elif defined(....

---- 8< ----


> . alsa answer is "no soundcards found"

That's expected;  you need to write ASoC "machine" code (that is, code
which knows which codec and audio unit to use).  Use the "sh7760-ac97.c"
file as a template; replace the "ac97_dai" with something appropriate for
the wm8731, and don't forget to change IPSELR to enable the I2S pins.


> . every kernel option i enable often results in an unbootable kernel: 
> /dev/i2c support; sh7760_AC97; alsa debug, scsi support (needed by usb mass 
> storage): every of these i try to enable results in a kernel with  no 
> console output.

Do you get any output with early_printk and sh_bios enabled?


> . i need to communicate (via i2c and i2S) to a wm8731 codec (on my custom 
> board) ... i imagine i have to write a driver or something like to connect 
> the codec and the sh sound interface. where to start?

see above.


> Do you have some suggestions? my kernel seems very very delicate.....
> i attach my .config and my edosk7760/setup.c

Could you please post a complete patch of your edosk7760 against
vanilla-2.6.26?
What toolchain are you using?

	Manuel Lauss
