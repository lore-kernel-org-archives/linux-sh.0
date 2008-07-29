From: Luca Santini <luca.santini@spesonline.com>
Date: Tue, 29 Jul 2008 10:11:43 +0000
Subject: Re: kernel (sometimes) boot
Message-Id: <488EECDF.9080208@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <488D864C.30808@spesonline.com>
In-Reply-To: <488D864C.30808@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



Manuel Lauss wrote:
> On Mon, Jul 28, 2008 at 06:50:48PM +0200, Luca Santini wrote:
>>
>> Manuel Lauss wrote:
>>> On Mon, Jul 28, 2008 at 04:38:26PM +0200, Luca Santini wrote:
>>>>>> . loading smc91c96 driver fails at probe()
>>>>> Check MMIO area (chip is at 0x02000000 - 0x0200001f according to the
>>>>> ESDOK7760 manual available from renesas website if you didn't change any 
>>>>> of
>>>>> the DIP switches on the board), and correct IRQ (9 if I interpret the
>>>>> schematics correctly)
> 
> Going over the schematics again:
> this is a 91c96: you should add a "smc91x-attrib" mem resource.  However I
> don't know which address to set it to; please check the NIC's manual.
> i.e.
> 
> struct resource smc91x_res[] = {
> 	...
> 	[1] = {
> 		.name = "smc91x-attrib",
> 		.start = ???,
> 		.endd = ???,
> 		.flags = IORESOURCE_MEM,
> 	},
> 	...
> };
>


i can't imagine where to find the addresses, i searched in edosk7760 and 
smc91c96 manuals; others implementations that use this NIC ...
someone knows? it's really necessary?


currently i have:

#define SMC_IOADDR 0xA2000000

static struct resource smc91x_res[] = {
         [0] = {
		.start  = SMC_IOADDR,
		.end    = SMC_IOADDR + 0x1f,
		.flags  = IORESOURCE_MEM,
         },
         [1] = {
		.start  = ETHERNET_IRQ,
		.end    = ETHERNET_IRQ,
		.flags  = IORESOURCE_IRQ,
         },

/*
		[2] = {
		.name = "smc91x-attrib",
		.start  = SMC_IOADDR + 0x02000000,
		.end    = SMC_IOADDR + 0x03ffffff,
		.flags = IORESOURCE_MEM,
		},
*/

};
