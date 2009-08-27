From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Thu, 27 Aug 2009 14:20:47 +0000
Subject: Re: [BUG] arch/sh/include/mach-common/mach/sh7785lcr.h: PCA9564_ADDR
Message-Id: <4A96963F.9000403@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A95800A.7020603@gentoo.org>
In-Reply-To: <4A95800A.7020603@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Yoshihiro Shimoda wrote:
> Paul Mundt wrote:
>> On Thu, Aug 27, 2009 at 12:01:03PM +0900, yoshii.takashi@renesas.com wrote:
>>> Oh, sorry.
>>> This might be because the board I sent you was a special version.
>>> You (and possibly others who use this version) should revert that commit.
>>> I'm really sorry for inconvenient.
>>>
>>> Paul, are there any good way to support this kind of small differences?
>>> Is it ok to add configuration menu item like below?
>>>
>> Presumably we can figure the version out from the FPGA? If so, we can
>> just figure out which devices to register, and have different devices for
>> different versions.
>>
>> If we can't figure it out from the FPGA, then the next best bet is to use
>> the mach types, the version information can be encoded in a new
>> mach-type, and we can simply have a mach_is_xxx() check for determining
>> the board version and doing the appropriate fixups. We already do this
>> today for some boards (highlander, r2d, etc.).
> 
> Thank you very much for your comment.
> Unfortunately, this board don't have version register in FPGA.
> So I made a patch that it adds mach_is_sh7785lcr_pt().
> Would you check this patch?
> 
> Thanks,
> Yoshihiro Shimoda
> 
>[patch]

I can confirm it works perfectly:
Linux superh 2.6.31-rc7-00224-gea15edb-dirty #3 Thu Aug 27 14:12:21 GMT
2009 sh4a SH7785 SH7785LCR GNU/Linux


Thanks!

