From: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Date: Mon, 25 Feb 2013 06:59:12 +0000
Subject: Re:
Message-Id: <20130225155109.F15B.KIYOSHI.ISHIYAMA.WG@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san

> < LTSI3.4.25 >
> Calibrating delay loop... 1654.30 BogoMIPS (lpjd63488)
> 
> < 3.8.rc7 >
> Calibrating delay loop... 827.65 BogoMIPS (lpj231744)

I have checked bogo mips problem but could not find 
the root cause of the problem.

Let me report my situation although I cannot explain why 
below situation happens....
Please let me know if you know something.

---------------------------------------------------------
(1) use __loop_delay 

BogoMIPS on 3.8 becomes 1654.30 BogoMIPS if we use __loop_delay
instead of arm_delay_ops.delay(n).

arch/arm/include/asm/delay.h 

/* original bogoMIPS =  827.65 */
#define __delay(n)              arm_delay_ops.delay(n)

/* test1 bogoMPIS = 1654.30 */
#define __delay(n)              __loop_delay(n)


I have checked the address of arm_delay_ops.delay and __loop_delay.
Both are the same.....

---------------------------------------------------------
(2) insert printk in calibrate_delay_converge()

BogoMIPS on 3.8 becomes 1654.30 BogoMIPS if we insert 
printk in calibrate_delay_converge().

BR
Ishi





> Hi Morimoto-san
> 
> Thank you for handling patches.
> 
> I sent "Acked-by" for three patches.
> 
> L2 cache/NEON/Arm branch prediction are handled correctly with three 
> patches.
> 
> But I found one strbange thing....
> 
> I'm using LTSI3.4.25 kernel on my Armadillo board for development.
> I have tested three patches with linux 3.8.rc7.
> 
> The prbolem I faced is that the value of BogoMIPS is different.
> Please find attched log.
> 
> < LTSI3.4.25 >
> Calibrating delay loop... 1654.30 BogoMIPS (lpjd63488)
> 
> < 3.8.rc7 >
> Calibrating delay loop... 827.65 BogoMIPS (lpj231744)
> 
> I will check why this difference occurs and come back to you
> once I find something.
> 
> BR
> Ishi
> 
> 
> > 
> > Hi Simon, Ishiyama-san, and all
> > 
> > These patches update Armaddilo800eva defconfig.
> > 
> > >> Ishiyama-san
> > 
> > Could you please give your Acked-by to these patches,
> > if you can agree these ?
> > 
> > >> Simon
> > 
> > Could you please back-port these patches to LTSI
> > if we got Acked-by ?
> > 
> > Kuninori Morimoto (3):
> >       ARM: shmobile: armadillo800eva: enable all errata for cache on defconfig
> >       ARM: shmobile: armadillo800eva: enable branch prediction on defconfig
> >       ARM: shmobile: armadillo800eva: enable NEON on defconfig
> > 
> >  arch/arm/configs/armadillo800eva_defconfig |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > Best regards
> > ---
> > Kuninori Morimoto
> 
> -- 
> Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>

-- 
Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>

