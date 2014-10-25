From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 25 Oct 2014 15:07:55 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <2196061.kROSgqD6Pm@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tuesday 22 July 2014 19:42:55 Kuninori Morimoto wrote:
> Hi Laurent
> 
> These are sound DMA support platform side patches.
> These worked well when it was based on shdma-base
> driver base.
> 
> These are including all sound DMA supports,
> but, it is too much for cyclic transfer test.

I'm trying to test cyclic DMA support in the rcar-dmac driver using this patch 
series.

I've applied all the patches on top of a merge of asoc/topic/rcar, renesas-
drivers-2014-10-23-v3.18-rc1 and Simon's latest master branch. The sound 
devices are not probed correctly:

[   10.720000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.730000] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 clock rate 
97 MHz
[   10.730000] i2c-sh_mobile e6510000.i2c: I2C adapter 5 with bus speed 100000 
Hz (L/H=0x145/0x118)
[   10.730000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.750000] rcar_sound ec500000.rcar_sound: Failed to create debugfs 
directory
[   10.750000] rcar_sound ec500000.rcar_sound: Failed to create debugfs 
directory
[   10.750000] rcar_sound ec500000.rcar_sound: Failed to create debugfs 
directory
[   10.760000] rcar_sound ec500000.rcar_sound: probed
[   10.760000] asoc-simple-card sound: ASoC: CPU DAI rsnd-dai.0 not registered
[   10.760000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.770000] i2c-sh_mobile e6520000.i2c: I2C adapter 6 with bus speed 100000 
Hz (L/H=0x145/0x118)
[   10.770000] asoc-simple-card sound: ASoC: CPU DAI rsnd-dai.0 not registered
[   10.770000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.800000] DA9210: 1000 mV at 4600 mA 
[   10.800000] i2c-sh_mobile e60b0000.i2c: I2C adapter 7 with bus speed 100000 
Hz (L/H=0x19/0x16)
[   10.800000] asoc-simple-card sound: ASoC: CPU DAI rsnd-dai.0 not registered
[   10.800000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.860000] asoc-simple-card sound: ASoC: CPU DAI rsnd-dai.0 not registered
[   10.870000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.880000] asoc-simple-card sound: ASoC: CPU DAI rsnd-dai.0 not registered
[   10.890000] platform sound: Driver asoc-simple-card requests probe deferral
[   10.910000] random: nonblocking pool is initialized
[   11.060000] sh_mobile_sdhi ee140000.sd: mmc2 base at 0xee140000 clock rate 
48 MHz
[   11.060000] asoc-simple-card sound: ASoC: CPU DAI rsnd-dai.0 not registered
[   11.070000] platform sound: Driver asoc-simple-card requests probe deferral

Am I missing something ? Is there a newer version of the Lager audio + DMA 
support patches ?

> I guess 1/3/5/6/10/11/ are enough.
> 
> Current rcar-dmac filter can't care "dma0" or "audma0" now.
> So, I disabled "dma0/1" as quick-hack.
> 
> 	&dmac0 {
> 			status = "disabled";
> 	};
> 
> 	&dmac1 {
> 			status = "disabled";
> 	};
> 
> I could get short sound if I modified driver as try-and-error.
> (and it dead after that, of course it is wrong fix)
> So, I guess, address/IRQ/MID-RID/MSTP/etc settings are correct.
> 
> If you have alsa command, you need this
> 
> 	> amixer set "LINEOUT Mixer DACL" on
> 	> aplay xxx.wav
> 
> I used...
> 
>   > git checkout renesas-drivers-2014-07-11-v3.16-rc4
>   > git merge asoc/topic/rcar
> 
>   # asoc = git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> 
> Kuninori Morimoto (11):
>        1) ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
>        2) ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
>        3) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
>        4) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry
> on DTSI
>        5) ARM: shmobile: lager: Sound PIO support on DTS
>        6) ARM: shmobile: lager: Sound DMA support on DTS
>        7) ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
>        8) ARM: shmobile: lager: Sound DMA support via SRC on DTS
>        9) ARM: shmobile: lager: Sound DMA support via DVC on DTS
>       10) ARM: shmobile: multiplatform: add Audo DMAC peri peri support on
> defconfig
>       11) ARM: shmobile: multiplatform: add R-Car DMAC support on
> defconfig
> 
>  arch/arm/boot/dts/r8a7790-lager.dts       |   66 ++++++++++
>  arch/arm/boot/dts/r8a7790.dtsi            |  203 +++++++++++++++++++++++++-
>  arch/arm/configs/shmobile_defconfig       |    2 +
>  arch/arm/mach-shmobile/Kconfig            |    1 +
>  include/dt-bindings/clock/r8a7790-clock.h |    2 +
>  5 files changed, 271 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

