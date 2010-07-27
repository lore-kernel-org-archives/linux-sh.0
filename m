From: Bill Traynor <wmat@naoi.ca>
Date: Tue, 27 Jul 2010 12:49:18 +0000
Subject: Re: MMC slots on MS7724
Message-Id: <4C4ED5CE.7090501@naoi.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10-07-27 12:50 AM, Magnus Damm wrote:
> On Tue, Jul 27, 2010 at 6:32 AM, Bill Traynor<wmat@naoi.ca>  wrote:
>    
>> Can someone with an MS7724 ecovec board confirm something for me?  When the
>> board is powered on, are the two MMC slot LED power indicators lit?  The
>> LEDs are right off the back left corner of the slots.  On my board only one
>> LED lights up and only blinks sporadically.  I can't get the board to
>> recognize any SD cards at all and I suspect the hardware may be faulty.
>>      
> I recognize the case with one LED blinking. For me I think it was
> caused by a mismatch in between the kernel configuration and the dip
> switch settings. If you still have problems then please post your
> kernel configure and I will give it a try.
>    
I'm using the latest ecovec24_defconfig in Paul's git tree.

The blinking LED has stopped when DP2[6] is set to ON, and DP2[7] is set 
to off.  This also enables the top SD slot on the board (CN12).

I've yet to get the bottom slot to show any life.  The user manual seems 
to indicate (Section 4.4) that slot usage is an OR situation setup with 
the DIP switches, that is one can use the MMC interface OR the SD 
interface but not both.

"MMC/ MMC plus/ SD card slot of CN12 is a multi slot that can insert MMC 
/MMC plus card and SD card. MMC/ MMC plus card or the SD card interface 
is selected by setting dip switch DS2-[7:6]."

dmesg does report the following:
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
mmc0 at 0xa4ce0000 irq 100
mmc1 at 0xa4cf0000 irq 23

So given that the top slot works now for me, getting the bottom slot to 
work isn't critical.  But I'll continue to poke at it.

> Cheers,
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>    

