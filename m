From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 13 Jan 2009 06:28:27 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <20090113062827.GF26923@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090111130445.GA12080@game.jcrosoft.org>
	<496ABD72.20400@juno.dti.ne.jp>
	<20090112124949.GA14269@linux-sh.org> <496BFD30.30306@renesas.com>
In-Reply-To: <496BFD30.30306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>, qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On 11:32 Tue 13 Jan     , Nobuhiro Iwamatsu wrote:
> Paul Mundt wrote:
>> On Mon, Jan 12, 2009 at 12:48:02PM +0900, Shin-ichiro KAWASAKI wrote:
>>>>> +    cpu_physical_memory_write(SH7750_BCR1_A7, (uint8_t *)&bcr1, 4);
>>>>> +    cpu_physical_memory_write(SH7750_BCR2_A7, (uint8_t *)&bcr2, 2);
>>>>> +
>>>>> +    /* Start from P2 area */
>>>>> +    env->pc = SDRAM_BASE | 0xa0000000;
>>>>> +
>>>>> +    /* pass kernel cmdline */
>>>>> +    if (kernel_cmdline) {
>>>>> +        pstrcpy((char *)phys_load_addr + ENTRY_OFFSET +  
>>>>> COMMAND_LINE_OFFSET,
>>>>> +                strlen(kernel_cmdline) + 1, kernel_cmdline);
>>>>> +        env->pc += 0x80000;
>>>>> +        phys_load_addr += 0x80000;
>>>>> +    }
>>>> do you known the flash model present on the real board?
>>> No, I don't.
>>> The patches for SE7750 are all implemented using informations in 
>>> linux source code.
>>> I visited Solution Engine site (in Japanese) but could not find 
>>> useful specs.
>>> http://www.hitachi-ul.co.jp/system/SH-SE/shiyou.html
>>>
>> I haven't seen one of these boards in at least 7 years, so I can't help
>> you with specifications. Yoshii-san or Iwamatsu-san might know, though?
>> SE7751 should have the same flash model and layout IIRC.
>>
> This board can not get from Hitachi-ULSI now and this is too old.
> I can send it later by examining the flash memory of this board.
> # I do not understand the meaning that supports this board ....
>
> BTW, I have question about Qemu-sh board support.
> Does the developer of Qemu-SH try to support all boards?
> I think that it is good to make it the base of Qemu-SH by
> thinking about one board as virtual as MIPS.
>
> Because first of all, I am not so interested in the support of the board.
> I am interested in emulation of CPU and the userland.
> In the current situation, the number of supported real boards increases
> when the support of CPU increases. The code of the board enters whenever
> CPU is supported.
> I think that you should decide a virtual board of SH and switch CPU.
A virtual board is good to test CPU and different IPs, but you can not compare
the comportment of qemu against the real hard. IMHO, this is the more
important part for supporting new boards.

Best Regards,
J.
