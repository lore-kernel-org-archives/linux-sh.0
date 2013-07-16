From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 16 Jul 2013 16:33:18 +0000
Subject: Re: EMMA/EMEV2 SDHCI driver
Message-Id: <51E575CE.9000601@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <51E5616A.70106@codethink.co.uk>
In-Reply-To: <51E5616A.70106@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 16/07/13 17:09, Ben Dooks wrote:
> On 16/07/13 16:06, Ben Dooks wrote:
>> I am currently trying to get a driver going for the SDIO0/1/2 blocks
>> in the EMEV2 device. Using the SDHCI platform driver I've added a
>> sub-driver to get the bus and sclks and then instantiate the sdhci
>> core.
>>
>> I have checked that the device is out of reset, and that all clocks
>> in to the block are enabled. I have a quick verification that all
>> SDHCI writes are making it to the registers.
>>
>> Has anyone tried this with any success? Is there something I have
>> missed doing this?
>
> I'm pretty sure we are somehow losing the interrupt from the SDIO0
> block to the gic, but can't see how as the interrupt seems to be
> appropriately unmasked.

Argh, this is my only silly fault for adding debug into the sdhci
core code and failing to notice i'd broken the irq claim. It is now
generating interrupts!

I am now looking in to what quirks may or may not be needed as I
am seeing ADMA errors returned.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
