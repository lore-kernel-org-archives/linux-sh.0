From: "Jeremy Baker" <Jeremy.Baker@renesas.com>
Date: Wed, 28 Jul 2010 08:51:33 +0000
Subject: RE: MMC slots on MS7724
Message-Id: <AB12B32E73474741A2C5361C433A44DE01F994FE@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Morimoto - san, Bill,

> 
> 
> Dear Bill
> 
> > Thanks, after changing DS-2[6] to ON and DS-2[7] to OFF, dmesg reports
> > the following on insertion of a card in the SD/MMC slot (SDHI1):
> >
> > mmc1: new SDHC card at address 1234
> > mmcblk0: mmc1:1234 SA04G 3.68 GiB
> >   mmcblk0: p1
> >
> > Oddly, the Android demo still reports no SD card though.  I'll try a few
> > more things to try to get that working.
> 
> OK. I asked about Ecovec Android to expert.
> I guess you got Android demo from Renesas OSS site.
> correct ?
> 
> At first, we didn't check CN12 slot for Android demo.
> We used CN11 slot.
> 
> Please check "mount" command.
> Does your card mounted ?
> 
> If not, please check
> /system/etc/vold.conf
> 
> meybe your conf show you "mmc0"
> but your card is in "mmc1" now
> 
> > I'm using the latest ecovec24_defconfig in Paul's git tree.
> 
> Hmm..
> When you compile kernel for Android, above defconfig is not enough.
> Android setting is needed.
> 
> I wounder which kernel are you using ?
> Android needs special kernel patches.
> 
> Please check here
> https://oss.renesas.com/modules/download/index.php?cidf
> 
> Best regards
> --
> Kuninori Morimoto
> 
Don't forget that DS2:6 and DS2:7 are only associated with CN12 (and LED13),

If DS2:6 = ON and DS2:7 = Off, SDHI peripheral is connected to CN12, if
DS2:6 = OFF DS2:7 = ON, MMCIF peripheral is connected to CN12. DS2:4 has to
be on for the SDHI peripheral to be connected to CN11, if DS2:4 is off,
MSIOF peripheral is connected to CN11 (MSIOF is used for MMC via SPI).

LED 12 is associated with CN11.

Regards

Jeremy Baker


This message is intended only for the use of the addressee(s) and may
contain confidential and/or legally privileged information.
If you are not the intended recipient, you are hereby notified that
any dissemination of this email (including any attachments thereto)
is strictly prohibited. If you have received this email in
error, please notify the sender immediately by telephone or email
and permanently destroy the original without making any copy.
Please note that any material and advice from this mail is provided
free of charge and shall be used as an example for demonstration
purposes only.
RENESAS MAKES NO WARRANTIES THAT THEIR USAGE WILL NOT INFRINGE ANY
INTELLECTUAL PROPERTY RIGHTS (E.G. PATENTS, COPYRIGHTS).
RENESAS CANNOT GUARANTEE BUG FREE OPERATION AND THE RECIPIENT WILL USE
AND/OR DISTRIBUTE IT ONLY AT HIS OWN RISK. IN NO EVENT SHALL
RENESAS BE LIABLE FOR ANY DAMAGE.
This communication with Renesas Electronics Europe Ltd does not amend
any written agreement in place.
Thank you.
Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
