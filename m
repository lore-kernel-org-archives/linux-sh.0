From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sat, 17 Jan 2009 10:45:34 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <4971B6CE.4060009@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>	<20090111130445.GA12080@game.jcrosoft.org>	<496ABD72.20400@juno.dti.ne.jp>	<20090112124949.GA14269@linux-sh.org>
	<496BFD30.30306@renesas.com>	<496C98EB.5040309@juno.dti.ne.jp>
	<496E9570.2050306@renesas.com>
In-Reply-To: <496E9570.2050306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Nobuhiro Iwamatsu wrote:
> Shin-ichiro KAWASAKI wrote:
>> Nobuhiro Iwamatsu wrote:
>>> Paul Mundt wrote:
>>>> On Mon, Jan 12, 2009 at 12:48:02PM +0900, Shin-ichiro KAWASAKI wrote:
>>>>>>> +    cpu_physical_memory_write(SH7750_BCR1_A7, (uint8_t *)&bcr1, 4);
>>>>>>> +    cpu_physical_memory_write(SH7750_BCR2_A7, (uint8_t *)&bcr2, 2);
>>>>>>> +
>>>>>>> +    /* Start from P2 area */
>>>>>>> +    env->pc = SDRAM_BASE | 0xa0000000;
>>>>>>> +
>>>>>>> +    /* pass kernel cmdline */
>>>>>>> +    if (kernel_cmdline) {
>>>>>>> +        pstrcpy((char *)phys_load_addr + ENTRY_OFFSET + 
>>>>>>> COMMAND_LINE_OFFSET,
>>>>>>> +                strlen(kernel_cmdline) + 1, kernel_cmdline);
>>>>>>> +        env->pc += 0x80000;
>>>>>>> +        phys_load_addr += 0x80000;
>>>>>>> +    }
>>>>>> do you known the flash model present on the real board?
>>>>> No, I don't.
>>>>> The patches for SE7750 are all implemented using informations in 
>>>>> linux source code.
>>>>> I visited Solution Engine site (in Japanese) but could not find 
>>>>> useful specs.
>>>>> http://www.hitachi-ul.co.jp/system/SH-SE/shiyou.html
>>>>>
>>>> I haven't seen one of these boards in at least 7 years, so I can't help
>>>> you with specifications. Yoshii-san or Iwamatsu-san might know, though?
>>>> SE7751 should have the same flash model and layout IIRC.
>>>>
>>> This board can not get from Hitachi-ULSI now and this is too old.
>>> I can send it later by examining the flash memory of this board.
>>> # I do not understand the meaning that supports this board ....
> 
> Flash model is 29lv160t.
>>
>> I should have explained it.  To avoid messy many board support,
>> board should be selected carefully.
>>
>> I wanted a board which can test SCI (not SCIF) console emulation.
>> I'm sure that SE7750 supports both SCI and SCIF, and it is suitable
>> to check SCI work.  For this purpose, any other board is OK if it
>> uses SCI for console.
>>
>> # The reason I stick to SCI is r2d+ board's RTC.  The r2d+ board uses
>> # SCI not for console but for SPI connection with RTC chip.  Before
>> # thinking about RTC emulation, SCI emulation should be done.
> 
> OK.
> 
>>
>> Another reason for SE7750 is support for TOPPERS. TOPPERS is an open
>> source realtime OS. I think QEMU will be a strong tool for TOPPERS
>> developers.  They already utilizes SkyEye, the ARM dedicated CPU
>> simulator for board-less development. Of course SkyEye cannot be
>> used for the work for SuperH.
>>
>> Here's the list of the CPUs and boards which can run TOPPERS.
>>  http://www.toppers.jp/en/jsp-kernel-e.html
>> SE7750 is the only one board which has SuperH, can run TOPPERS, and
>> has Linux kernel's default config.
>>
>> We should focus on completing SH-Linux emulation before thinking about
>> other OSes.  But if I have to add new board emulation, I think SE7750
>> is a good choice.
> 
> I understood.
> But this board can not get now and CPU is too old.
> And you don't have this. How do you develop this board and IP?
> 
> # Does the development of SH of Toppers still continue?

Right, the board's not available. It is a problem, even though
some amount of development can be done from SH-Linux source code
and chip specifications.

I posted a mail to TOPPERS users ML, and got an advice that
the type of board is not so important to run TOPPERS kernel.
So, now I think I should not stick to SE7750.
# Development of SH Toppers seems going.

But anyway, to check how SCI console works, qemu-sh should have
another board support which uses SCI.  Is there any suggestion
about board?  One idea is to let the virtual board have it.


>>> BTW, I have question about Qemu-sh board support.
>>> Does the developer of Qemu-SH try to support all boards?
>>> I think that it is good to make it the base of Qemu-SH by
>>> thinking about one board as virtual as MIPS.
>>>
>>> Because first of all, I am not so interested in the support of the 
>>> board.
>>> I am interested in emulation of CPU and the userland.
>>> In the current situation, the number of supported real boards increases
>>> when the support of CPU increases. The code of the board enters whenever
>>> CPU is supported.
>>> I think that you should decide a virtual board of SH and switch CPU.
>>>
>>> How about you?
>> Good idea.  I agree that virtual board is useful.
>> I wonder how linux kernel config will be.
>> Or on what kind of policy, its specs should be decided?
> I think that the Qemu-sh developer talk about it.
> # Though the talk might be not settled....
> Or get from other architectures (ex. MIPS).
I guess you mean "hw/mips_mipssim.c".  It seems emulate MIPSsim, the
MIPS emulator.  In a same way, "hw/sh_virtual_board.c" or
"hw/sh_pseudo_machine.c" can be implemented.  It will be useful to
check how SH CPU cores and its SoC internal IPs work.

> Or I thought create of configurable mechanism to be good. 
Once machine config file was discussed on this ML.
It will be useful for qemu-sh also, I think.


Regards,
Shin-ichiro KAWASAKI

