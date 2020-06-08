From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 08 Jun 2020 11:46:18 +0000
Subject: Re: Kernel doesn't boot on qemu-sh4
Message-Id: <f5075a4b-02b6-3496-82e0-fe0ec10c4b3c@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <364fae0d-6030-6741-d38a-3e6fd15fc4ca@physik.fu-berlin.de>
In-Reply-To: <364fae0d-6030-6741-d38a-3e6fd15fc4ca@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 6/8/20 1:51 PM, Rob Landley wrote:
> On 6/4/20 3:54 AM, John Paul Adrian Glaubitz wrote:
>> Hi!
>>
>> Has anyone had any success booting a current kernel on qemu-sh4?
> 
> Yup, just confirmed CROSS=sh4 target on
> https://landley.net/toybox/faq.html#mkroot works with linux commit af7b4801030c
> fromm yesterday evening. Config attached if you want to try to reproduce.
> (Probably yank the "quiet" from qemu-sh4.sh for testing, that's mostly there so
> the kernel doesn't randomly crap "the random pool did something!" and such over
> the command prompt. I should probably move it to the init script instead of the
> kernel command line...)

Thanks a known-to-work config was what I was looking for.

> I built it with the toolchain described here:
> 
>   http://lists.landley.net/pipermail/toybox-landley.net/2020-April/011667.html
> 
>> I have built a Debian kernel with both my patch to add __get_user_u64() as
>> well as the two patches by Romain Naour [1,2] but the kernel still doesn't
>> boot for me.
>>
>> Am I missing anything?
> 
> I'm building a vanilla kernel with no patches.
> 
> Current binutils gratuitously changed the ABI, so you need the two alignment
> patches I keep poking about on here (linked in the above toolchain build
> message) in order to build with something newer, but I just stuck with an older
> binutils until those get merged.

I do have those patches in as previously mentioned. But I think the kernel the
Debian kernel package builds may just be too big.

Does anyone remember what the upper limit for the kernel size is?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
