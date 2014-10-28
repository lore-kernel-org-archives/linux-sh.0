From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 28 Oct 2014 20:59:48 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <1602179.i7BzQ7tAco@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Monday 27 October 2014 17:16:16 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > That fixed the probe issue, thank you. Do you plan to push this change to
> > Simon's tree ?
> 
> Current Simon's tree doesn't have board support yet.
> This means no one (= except you :) have trouble in upstream.

Indeed :-)

> But, yes, I will fix it when I send sound board support patch-set.

By the way, when you submit "ARM: shmobile: r8a7790: Add Audio DMAC devices to 
DT", you might want to s/contorller/controller/ in r8a7790.dts.

> > With this patch applied I've been able to test audio playback and get it
> > to fail :-) The first problem is caused by GFP_KERNEL allocation in the
> > prep cyclic handler in shdma-base.c. I've sent a patch to fix that and
> > have CC'ed you.
> > 
> > The next failure comes from the call to pm_runtime_get() in
> > shdma_tx_submit():
> >
> >   rcar-audmapp-engine ec740000.audio-dma-pp: shdma_tx_submit(): GET = -13
> >   rcar_sound ec500000.rcar_sound: status check failed
> >   rcar_sound ec500000.rcar_sound: status check failed
> 
> GET = -13 is because PeriPeri doesn't have MSTP bit,
> but it is message/warning only.
> 
> status check failed seems DMA doesn't work (?)
> it seems similar with my known issue which was this
> 
>    http://www.spinics.net/lists/dmaengine/msg01525.html
> 
> especially 1) issue ?
> 
> Kuninori Morimoto (11):
>        1) ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
>        2) ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
>        3) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
>        4) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry
> on DTSI 5) ARM: shmobile: lager: Sound PIO support on DTS
>        6) ARM: shmobile: lager: Sound DMA support on DTS
>        7) ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
>        8) ARM: shmobile: lager: Sound DMA support via SRC on DTS
>        9) ARM: shmobile: lager: Sound DMA support via DVC on DTS
>       10) ARM: shmobile: multiplatform: add Audo DMAC peri peri support on
> defconfig 11) ARM: shmobile: multiplatform: add R-Car DMAC support on
> defconfig
> 
> I'm sorry that I didn't explain about sound.
> I guess you are using soud FULL feature now (= 1 to 11), and,
> this means your kernel is using Audio DMAC + PeriPeri DMAC.
> But, very basic sound doesn't need PeriPeri DMAC.
> 
> Can you use 1) - 6) patches (and previous fixup patch) ?
> 7) / 8) / 9) requests PeriPeri DMAC, and problem will be more complex.

That gets rid of the runtime PM issue, but I then get a status check failed 
when trying to play audio and no audio or DMA interrupt seem to be generated:

root@arago:~# cat /proc/interrupts  > irq.1
root@arago:~# time aplay audiodump.wav 
Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Stereo
aplay: pcm_write:1528: write error: Input/output error
[   89.710000] rcar_sound ec500000.rcar_sound: status check failed
[   89.710000] rcar_sound ec500000.rcar_sound: status check failed

Command exited with non-zero status 1
real    0m 10.15s
user    0m 0.09s
sys     0m 0.04s
root@arago:~# cat /proc/interrupts  > irq.2

$ diff -u irq.1 irq.2
--- irq.1       2014-10-28 22:47:21.725420047 +0200
+++ irq.2       2014-10-28 22:47:37.143421188 +0200
@@ -1,5 +1,5 @@
            CPU0       CPU1       CPU2       CPU3       
- 27:       1127       3105        668        731       GIC  27  arch_timer
+ 27:       1216       3148        732        772       GIC  27  arch_timer
  32:          1          0          0          0       GIC  32  
e61c0000.interrupt-controller
  33:          0          0          0          0       GIC  33  
e61c0000.interrupt-controller
  34:          0          0          0          0       GIC  34  
e61c0000.interrupt-controller
@@ -11,11 +11,11 @@
  40:          0          0          0          0       GIC  40  e6054000.gpio
  41:          0          0          0          0       GIC  41  e6055000.gpio
 174:          0          0          0          0       GIC 174  
ffca0000.timer
-176:        716          0          0          0       GIC 176  
e6c40000.serial:mux
-194:      10459          0          0          0       GIC 194  eth0
+176:        795          0          0          0       GIC 176  
e6c40000.serial:mux
+194:      10788          0          0          0       GIC 194  eth0
 205:         28          0          0          0       GIC 205  e60b0000.i2c
 206:          0          0          0          0       GIC 206  e6500000.i2c
-207:        120          0          0          0       GIC 207  e6510000.i2c
+207:        199          0          0          0       GIC 207  e6510000.i2c
 208:          0          0          0          0       GIC 208  e6520000.i2c
 229:          0          0          0          0       GIC 229  e6700000.dma-
controller:error
 232:          0          0          0          0       GIC 232  e6700000.dma-
controller:0
@@ -84,7 +84,7 @@
 420:          0          0          0          0  e6051000.gpio  28  SW2-4
 IPI0:          0          0          0          0  CPU wakeup interrupts
 IPI1:          0          0          0          0  Timer broadcast interrupts
-IPI2:        774        886        834        901  Rescheduling interrupts
+IPI2:        776        904        860        915  Rescheduling interrupts
 IPI3:         23         13         25         13  Function call interrupts
 IPI4:          0          0          0          0  Single function call 
interrupts
 IPI5:          0          0          0          0  CPU stop interrupts

I can't hear any sound being output (just for confirmation, is the audio 
output port the bottom connector ?).

As I don't have amixer installed on my rootfs the problem might also be 
related to the output being muted. Do you know in which state it starts by 
default ?

I've pushed my test branch to

	git://linuxtv.org/pinchartl/fbdev.git dma/audio

It doesn't include support for DMA hardware descriptors yet, as I wanted to 
rule out any issue with them.

-- 
Regards,

Laurent Pinchart

