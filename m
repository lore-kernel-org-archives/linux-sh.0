From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 27 Oct 2014 00:36:12 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <87mw8i1h8m.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for contacting me

> > These are sound DMA support platform side patches.
> > These worked well when it was based on shdma-base
> > driver base.
> > 
> > These are including all sound DMA supports,
> > but, it is too much for cyclic transfer test.
> 
> I'm trying to test cyclic DMA support in the rcar-dmac driver using this patch 
> series.
> 
> I've applied all the patches on top of a merge of asoc/topic/rcar, renesas-
> drivers-2014-10-23-v3.18-rc1 and Simon's latest master branch. The sound 
> devices are not probed correctly:
(snip)
> Am I missing something ? Is there a newer version of the Lager audio + DMA 
> support patches ?

Sorry, driver had a bug, and I fixed it on latest upstream.
Can you add below on my previous patch series ?
It should be probed.

------------------
diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 950a438..d6e7efd 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -166,7 +166,7 @@
                simple-audio-card,frame-master = <&sndcodec>;
 
                sndcpu: simple-audio-card,cpu {
-                       sound-dai = <&rcar_sound 0>;
+                       sound-dai = <&rcar_sound>;
                };
 
                sndcodec: simple-audio-card,codec {
@@ -474,6 +474,8 @@
        pinctrl-0 = <&sound_pins &sound_clk_pins>;
        pinctrl-names = "default";
 
+       #sound-dai-cells = <0>;
+
        status = "okay";
 
        rcar_sound,dai {
------------------

Best regards
---
Kuninori Morimoto
