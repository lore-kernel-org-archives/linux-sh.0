From: Bill Traynor <wmat@naoi.ca>
Date: Tue, 27 Jul 2010 12:15:03 +0000
Subject: Re: MMC slots on MS7724
Message-Id: <4C4ECDC7.1010307@naoi.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10-07-26 08:46 PM, Kuninori Morimoto wrote:
> Dear Bill
>
>    
>> Can someone with an MS7724 ecovec board confirm something for me?  When
>> the board is powered on, are the two MMC slot LED power indicators lit?
>> The LEDs are right off the back left corner of the slots.  On my board
>> only one LED lights up and only blinks sporadically.  I can't get the
>> board to recognize any SD cards at all and I suspect the hardware may be
>> faulty.
>>      
> I asked about this to Ecovec hardware engineer.
>
> when power on, LED status are
> LED13: right up
> LED12: right off
>
> To enable "eMMC boot" on CN12 slot,
> card power are applied to LED13 by hardware.
>
> # current ecovec user manual (table 3.4.5.1)
> # show you wrong infomation. sorry.
>
> You can control it by PTB[7] and PTB[6].
>    

Thanks, after changing DS-2[6] to ON and DS-2[7] to OFF, dmesg reports 
the following on insertion of a card in the SD/MMC slot (SDHI1):

mmc1: new SDHC card at address 1234
mmcblk0: mmc1:1234 SA04G 3.68 GiB
  mmcblk0: p1

Oddly, the Android demo still reports no SD card though.  I'll try a few 
more things to try to get that working.

> Best regards
> --
> Kuninori Morimoto
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

