From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 29 Oct 2014 01:33:38 +0000
Subject: Re: [PATCH 0/11][RFC] sound DMA support patches
Message-Id: <87ioj3irrg.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874my8vlqq.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent again

Thank you for your DMA cyclic work

> > I've pushed my test branch to
> > 
> > 	git://linuxtv.org/pinchartl/fbdev.git dma/audio
> > 
> > It doesn't include support for DMA hardware descriptors yet, as I wanted to 
> > rule out any issue with them.

Unfortunately, it was patch applying magic.
ak4643 is needed under iic2, not iic1.
Can you add attached patch on your dma/audio branch ?

It works for me.
When you use sound on Lager board, you need amixer setting.
And you can use bottom jack of CN17 for sound output.

     / # amixer set "LINEOUT Mixer DACL" on

     /* start sound playback and check DMA interrupt */

     / # aplay /home/xxx.wav &
     / # grep dma /proc/interrupts 
     ...
     352:        103          0          0          0       GIC 352  ec700000.dma-contorller:0
     / # grep dma /proc/interrupts 
     ...
     352:        124          0          0          0       GIC 352  ec700000.dma-contorller:0
     / # grep dma /proc/interrupts 
     ...
     352:        146          0          0          0       GIC 352  ec700000.dma-contorller:0
     / # grep dma /proc/interrupts 
     ...
     352:        195          0          0          0       GIC 352  ec700000.dma-contorller:0
     / # grep dma /proc/interrupts 
     ...
     352:        216          0          0          0       GIC 352  ec700000.dma-contorller:0
     / # grep dma /proc/interrupts 
     ...
     352:        239          0          0          0       GIC 352  ec700000.dma-contorller:0

     /* stop sound playback and check DMA interrupt */

     / # fg
     aplay /home/Calm_16bit_48k.wav
     ^CAborted by signal Interrupt...
     / # grep dma /proc/interrupts 
     ...
     352:        280          0          0          0       GIC 352  ec700000.dma-contorller:0
     / # grep dma /proc/interrupts 
     ...
     352:        280          0          0          0       GIC 352  ec700000.dma-contorller:0

----------------------
diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index f891a00..03fe43a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -409,12 +409,6 @@
        status = "ok";
        pinctrl-0 = <&iic1_pins>;
        pinctrl-names = "default";
-
-       ak4643: sound_codec {
-               compatible = "asahi-kasei,ak4643";
-               #sound-dai-cells = <0>;
-               reg = <0x12>;
-       };
 };
 
 &iic2  {
@@ -434,6 +428,12 @@
                        };
                };
        };
+
+       ak4643: sound_codec {
+               compatible = "asahi-kasei,ak4643";
+               #sound-dai-cells = <0>;
+               reg = <0x12>;
+       };
 };
 
 &iic3 {
----------------------

Best regards
---
Kuninori Morimoto
