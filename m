From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Aug 2012 02:31:32 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87r4r1562n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Kobayashi-san

> After applying this patch on kzm9g board, I got this error regarding eMMC.
> I think this is another problem.

Hmm...
How can I reproduce it ?
It doesn't happen on my board.

I'm using
 linus/master + paul/sh-latest + sh73a0-irq-fixup-patch

# My kzm9g board is not mass-production board though


-------- log -------------------------------------------------
(snip)
rtc-rs5c372 0-0032: setting system clock to 2001-01-17 20:57:59 UTC (979765079) 
asoc-simple-card asoc-simple-card.0:  ak4642-hifi <-> fsia-dai mapping ok       
smsc911x smsc911x.0: eth0: SMSC911x/921x identified at 0xdf9e8000, IRQ: 419     
Sending DHCP requests .mmc0: SD Status: Invalid Allocation Unit size.           
mmc0: new SD card at address ee97                                               
mmcblk0: mmc0:ee97 S128B 122 MiB                                                
 mmcblk0: p1 p2                                                                 
mmc1: new high speed SDHC card at address b368                                  
mmcblk1: mmc1:b368 SD16G 14.4 GiB                                               
 mmcblk1: p1                                                                    
[sched_delayed] sched: RT throttling activated                                  
mmc2: new high speed MMC card at address 0001                                   
mmcblk2: mmc2:0001 M4G1EM 3.72 GiB                                              
 mmcblk2: unknown partition table                                               
., OK                                                                           
IP-Config: Got DHCP answer from 192.168.10.77, my address is 192.168.10.118     
IP-Config: Complete:                                                            
     device=eth0, addr2.168.10.118, mask%5.255.255.0, gw2.168.10.77     
     host2.168.10.118, domain=example.org, nis-domain=(none)                 


Best regards
---
Kuninori Morimoto
