From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 28 Oct 2014 00:16:16 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <87wq7lqcaf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> That fixed the probe issue, thank you. Do you plan to push this change to 
> Simon's tree ?

Current Simon's tree doesn't have board support yet.
This means no one (= except you :) have trouble in upstream.
But, yes, I will fix it when I send sound board support patch-set.

> With this patch applied I've been able to test audio playback and get it to 
> fail :-) The first problem is caused by GFP_KERNEL allocation in the prep 
> cyclic handler in shdma-base.c. I've sent a patch to fix that and have CC'ed 
> you.
> 
> The next failure comes from the call to pm_runtime_get() in shdma_tx_submit():
> 
>   rcar-audmapp-engine ec740000.audio-dma-pp: shdma_tx_submit(): GET = -13
>   rcar_sound ec500000.rcar_sound: status check failed
>   rcar_sound ec500000.rcar_sound: status check failed

GET = -13 is because PeriPeri doesn't have MSTP bit,
but it is message/warning only.

status check failed seems DMA doesn't work (?)
it seems similar with my known issue which was this

   http://www.spinics.net/lists/dmaengine/msg01525.html

especially 1) issue ?

Kuninori Morimoto (11):
       1) ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
       2) ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
       3) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
       4) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
       5) ARM: shmobile: lager: Sound PIO support on DTS
       6) ARM: shmobile: lager: Sound DMA support on DTS
       7) ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
       8) ARM: shmobile: lager: Sound DMA support via SRC on DTS
       9) ARM: shmobile: lager: Sound DMA support via DVC on DTS
      10) ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
      11) ARM: shmobile: multiplatform: add R-Car DMAC support on defconfig

I'm sorry that I didn't explain about sound.
I guess you are using soud FULL feature now (= 1 to 11), and,
this means your kernel is using Audio DMAC + PeriPeri DMAC.
But, very basic sound doesn't need PeriPeri DMAC.

Can you use 1) - 6) patches (and previous fixup patch) ?
7) / 8) / 9) requests PeriPeri DMAC, and problem will be more complex.

Best regards
---
Kuninori Morimoto
