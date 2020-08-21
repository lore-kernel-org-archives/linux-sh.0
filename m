From: Rob Landley <rob@landley.net>
Date: Fri, 21 Aug 2020 20:46:11 +0000
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
Message-Id: <d78cbae7-30c1-245a-84f6-8f1518d99340@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819030511.1114-1-liambeguin@gmail.com>
In-Reply-To: <20200819030511.1114-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On 8/19/20 8:50 AM, Geert Uytterhoeven wrote:
> Hi Liam,
> 
> On Wed, Aug 19, 2020 at 3:34 PM Liam Beguin <liambeguin@gmail.com> wrote:
>> On Wed Aug 19, 2020 at 5:09 AM EDT, Geert Uytterhoeven wrote:
>>> On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com>
>>> wrote:
>>>> The kernel test bot reported[1] that using set_mask_bits on a u8 causes
>>>> the following issue on SuperH:
>>>>
>>>>     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!
>>>>
>>>> Add support for cmpxchg on u8 and u16 pointers.
>>>>
>>>> [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
>>>> ---
>>>>
>>>> Hi,
>>>>
>>>> This was reported by the kernel test bot on an architecture I can't
>>>> really test on. I was only able to make sure the build succeeds, but
>>>> nothing more.
>>>> This patch is based on the __cmpxchg_u32 impletmentation and seems
>>>> incomplete based on the different cmpxchg headers I can find.
>>>
>>> Indeed. This version is suitable for non-SMP machines only.
>>> BTW, it looks like this version can be replaced by the one in
>>> asm-generic?
>>>
>>
>> Thanks for your feedback I'll have a look at the asm-generic functions
>> and try to use those instead.

Does using the asm-generic one automatically use the architecture version for
j-core? (Technically we're compare-and-swap rather than cmpxchg but eh, close
enough: CAS.L Rm, Rn, @R0 opcode 0010-nnnn-mmmm-0011, based on the IBM 360
instruction. Not sure how the #include plumbing winds up selecting the version
here, if there's an extra thing we have to do we should do it.)

>> Okay, I'll look into that. Would you recommend a good way to test these
>> changes?
> 
> That's gonna be harder, I'm afraid.
> Who has suitable hardware?

Define suitable? (Not familiar with testbot? In addition to a raspberry pi form
factor j-core board that runs off my laptop's usb power pretty much with me at
all times, I have a johnson controls sh4 board in a box, a little blue board
that runs an st kernel fork in the same box, and an sh2 board from the dawn of
time in another box. I generally use the j-core board as my hardware and
regression test sh4 on qemu unless I'm checking a specific hardware thing.)

Rob
