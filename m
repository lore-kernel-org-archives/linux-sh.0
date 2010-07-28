From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Jul 2010 00:28:54 +0000
Subject: Re: MMC slots on MS7724
Message-Id: <w3piq40h2ke.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Bill

> Thanks, after changing DS-2[6] to ON and DS-2[7] to OFF, dmesg reports 
> the following on insertion of a card in the SD/MMC slot (SDHI1):
> 
> mmc1: new SDHC card at address 1234
> mmcblk0: mmc1:1234 SA04G 3.68 GiB
>   mmcblk0: p1
> 
> Oddly, the Android demo still reports no SD card though.  I'll try a few 
> more things to try to get that working.

OK. I asked about Ecovec Android to expert.
I guess you got Android demo from Renesas OSS site.
correct ?

At first, we didn't check CN12 slot for Android demo.
We used CN11 slot.

Please check "mount" command.
Does your card mounted ?

If not, please check
/system/etc/vold.conf

meybe your conf show you "mmc0"
but your card is in "mmc1" now

> I'm using the latest ecovec24_defconfig in Paul's git tree.

Hmm..
When you compile kernel for Android, above defconfig is not enough.
Android setting is needed.

I wounder which kernel are you using ?
Android needs special kernel patches.

Please check here
https://oss.renesas.com/modules/download/index.php?cidf

Best regards
--
Kuninori Morimoto
 
