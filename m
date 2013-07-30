From: Chen Gang <gang.chen@asianux.com>
Date: Tue, 30 Jul 2013 06:11:33 +0000
Subject: Re: [Suggestion] sh64: kernel: about the warning: "unexpected non-allocatable section".
Message-Id: <51F75915.8060100@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51F721CD.3010006@asianux.com>
In-Reply-To: <51F721CD.3010006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/30/2013 02:09 PM, Chen Gang wrote:
> 
> For sh, it will report error below:
> 
>   [root@dhcp122 linux-next]# make ARCH=sh CROSS_COMPILE=sh-linux-gnu-
>   CC      scripts/mod/empty.o
>   as: unrecognized option '-little'
>   make[2]: *** [scripts/mod/empty.o] Error 2
>   make[1]: *** [scripts/mod] Error 2
>   make: *** [scripts] Error 2
> 
> The related binutils information:
> 
>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh-linux-gnu-ld
>   binutils-sh-linux-gnu-2.23.51.0.3-1.fc17.x86_64
>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh-linux-gnu-as
>   binutils-sh-linux-gnu-2.23.51.0.3-1.fc17.x86_64
> 

OH, sorry, for sh64, the related information is

  [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh64-linux-gnu-as 
  binutils-sh64-linux-gnu-2.23.51.0.3-1.fc17.x86_64


> 
> Is it the binutils's issue ? is the warnings below is the binutils's
> issue too? (now, I am downloading related tool chain source code of SH,
> and will try again).
> 
> 
> Thanks.
> 
> On 07/30/2013 10:15 AM, Chen Gang wrote:
>> Hello Maintainers:
>>
>> When I build sh64 with allmodconfig (without "EXTRA_CFLAGS=-W"), it
>> report the warnings below:
>>
>>     LD      arch/sh/kernel/cpu/sh5/built-in.o
>>   WARNING: arch/sh/kernel/cpu/sh5/built-in.o (.cranges): unexpected non-allocatable section.
>>   Did you forget to use "ax"/"aw" in a .S file?
>>   Note that for example <linux/init.h> contains
>>   section definitions for use in .S files.
>>
>> Can it cause real world issue ?
>>
>> Welcome any members suggestions or completions.
>>
>>
>> Thanks.
>> --
>> Chen Gang.
>>
> 
> 


-- 
Chen Gang
