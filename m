From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 17 Jan 2009 11:16:51 +0000
Subject: Re: [Qemu-devel] [PATCH 1/3] sh: SE7750 board definition
Message-Id: <20090117111651.GA3682@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4969B77E.7050206@juno.dti.ne.jp>
	<20090111130445.GA12080@game.jcrosoft.org>
	<496ABD72.20400@juno.dti.ne.jp>
	<20090112124949.GA14269@linux-sh.org>
	<496BFD30.30306@renesas.com> <496C98EB.5040309@juno.dti.ne.jp>
	<496E9570.2050306@renesas.com> <4971B6CE.4060009@juno.dti.ne.jp>
In-Reply-To: <4971B6CE.4060009@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Cc: Takashi Yoshii <yoshii.takashi@renesas.com>, qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

>>>
>>> Another reason for SE7750 is support for TOPPERS. TOPPERS is an open
>>> source realtime OS. I think QEMU will be a strong tool for TOPPERS
>>> developers.  They already utilizes SkyEye, the ARM dedicated CPU
>>> simulator for board-less development. Of course SkyEye cannot be
>>> used for the work for SuperH.
>>>
>>> Here's the list of the CPUs and boards which can run TOPPERS.
>>>  http://www.toppers.jp/en/jsp-kernel-e.html
>>> SE7750 is the only one board which has SuperH, can run TOPPERS, and
>>> has Linux kernel's default config.
>>>
>>> We should focus on completing SH-Linux emulation before thinking about
>>> other OSes.  But if I have to add new board emulation, I think SE7750
>>> is a good choice.
>>
>> I understood.
>> But this board can not get now and CPU is too old.
>> And you don't have this. How do you develop this board and IP?
>>
>> # Does the development of SH of Toppers still continue?
>
> Right, the board's not available. It is a problem, even though
> some amount of development can be done from SH-Linux source code
> and chip specifications.
>
> I posted a mail to TOPPERS users ML, and got an advice that
> the type of board is not so important to run TOPPERS kernel.
> So, now I think I should not stick to SE7750.
> # Development of SH Toppers seems going.
my the TOPPERS dev could help us to have a common board to use it as reference


>>> BTW, I have question about Qemu-sh board support.
>>>> Does the developer of Qemu-SH try to support all boards?
>>>> I think that it is good to make it the base of Qemu-SH by
>>>> thinking about one board as virtual as MIPS.
>>>>
>>>> Because first of all, I am not so interested in the support of the  
>>>> board.
>>>> I am interested in emulation of CPU and the userland.
>>>> In the current situation, the number of supported real boards increases
>>>> when the support of CPU increases. The code of the board enters whenever
>>>> CPU is supported.
>>>> I think that you should decide a virtual board of SH and switch CPU.
>>>>
>>>> How about you?
>>> Good idea.  I agree that virtual board is useful.
>>> I wonder how linux kernel config will be.
>>> Or on what kind of policy, its specs should be decided?
>> I think that the Qemu-sh developer talk about it.
>> # Though the talk might be not settled....
>> Or get from other architectures (ex. MIPS).
> I guess you mean "hw/mips_mipssim.c".  It seems emulate MIPSsim, the
> MIPS emulator.  In a same way, "hw/sh_virtual_board.c" or
> "hw/sh_pseudo_machine.c" can be implemented.  It will be useful to
> check how SH CPU cores and its SoC internal IPs work.
>
>> Or I thought create of configurable mechanism to be good. 
> Once machine config file was discussed on this ML.
> It will be useful for qemu-sh also, I think.
I've in mind to use fdt to describe the board
when implementating the qemu sh generic board

Best Regards,
J.
