From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 27 Jul 2010 00:46:37 +0000
Subject: Re: MMC slots on MS7724
Message-Id: <w3pocdt4uqf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Bill

> Can someone with an MS7724 ecovec board confirm something for me?  When 
> the board is powered on, are the two MMC slot LED power indicators lit?  
> The LEDs are right off the back left corner of the slots.  On my board 
> only one LED lights up and only blinks sporadically.  I can't get the 
> board to recognize any SD cards at all and I suspect the hardware may be 
> faulty.

I asked about this to Ecovec hardware engineer.

when power on, LED status are
LED13: right up
LED12: right off

To enable "eMMC boot" on CN12 slot,
card power are applied to LED13 by hardware.

# current ecovec user manual (table 3.4.5.1)
# show you wrong infomation. sorry.

You can control it by PTB[7] and PTB[6].

Best regards
--
Kuninori Morimoto
 
