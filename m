From: Chen Gang <gang.chen@asianux.com>
Date: Wed, 31 Jul 2013 07:38:38 +0000
Subject: Re: [Suggestion] sh64: kernel: about the warning: "unexpected non-allocatable section".
Message-Id: <51F8BEFE.7000605@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51F721CD.3010006@asianux.com>
In-Reply-To: <51F721CD.3010006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/30/2013 02:11 PM, Chen Gang wrote:
> On 07/30/2013 02:09 PM, Chen Gang wrote:
>>
>> For sh, it will report error below:
>>
>>   [root@dhcp122 linux-next]# make ARCH=sh CROSS_COMPILE=sh-linux-gnu-
>>   CC      scripts/mod/empty.o
>>   as: unrecognized option '-little'
>>   make[2]: *** [scripts/mod/empty.o] Error 2
>>   make[1]: *** [scripts/mod] Error 2
>>   make: *** [scripts] Error 2
>>
>> The related binutils information:
>>
>>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh-linux-gnu-ld
>>   binutils-sh-linux-gnu-2.23.51.0.3-1.fc17.x86_64
>>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh-linux-gnu-as
>>   binutils-sh-linux-gnu-2.23.51.0.3-1.fc17.x86_64
>>
> 

It is really the original sh-linux-gnu- compiler's issue (not only for
allmodconfig, but also for sh own config files).

With my new build cross-compiler, It can work for sh architecture own
config files, but can not work with allmodconfig (I will analyze it).

The cross-tools which I build is:

[root@dhcp122 linux-next]# sh3-gchen-linux-gnu-ld -v
GNU ld (crosstool-NG hg+unknown-20130731.103227) 2.22
[root@dhcp122 linux-next]# sh3-gchen-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=sh3-gchen-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/home/gchen/x-tools/sh3-gchen-linux-gnu/bin/../libexec/gcc/sh3-gchen-linux-gnu/4.8.0/lto-wrapper
Target: sh3-gchen-linux-gnu
Configured with: /root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/src/gcc-4.8.0/configure --build=x86_64-build_unknown-linux-gnu --host=x86_64-build_unknown-linux-gnu --target=sh3-gchen-linux-gnu --prefix=/root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --with-local-prefix=/home/gchen/x-tools/sh3-gchen-linux-gnu/sh3-gchen-linux-gnu/sysroot --disable-libmudflap --with-sysroot=/home/gchen/x-tools/sh3-gchen-linux-gnu/sh3-gchen-linux-gnu/sysroot --enable-shared --with-pkgversion='crosstool-NG hg+unknown-20130731.103227' --enable-__cxa_atexit --with-gmp=/root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --with-mpfr=/root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --with-mpc=/root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --with-isl=/root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --with-c
 loog=/roo
t/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --with-libelf=/root/src/toolchain_sh/crosstool-ng-2685dfa9de14/.build/sh3-gchen-linux-gnu/buildtools --enable-lto --enable-target-optspace --disable-libgomp --disable-libmudflap --disable-nls --disable-multilib --enable-languages=c
Thread model: posix
gcc version 4.8.0 (crosstool-NG hg+unknown-20130731.103227) 


Next, I will make a confirmation for sh64 compiler whether is OK or not.

Welcome any members' suggestions or completions.

Thanks.

> OH, sorry, for sh64, the related information is
> 
>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh64-linux-gnu-as 
>   binutils-sh64-linux-gnu-2.23.51.0.3-1.fc17.x86_64
> 
> 
>>
>> Is it the binutils's issue ? is the warnings below is the binutils's
>> issue too? (now, I am downloading related tool chain source code of SH,
>> and will try again).
>>
>>
>> Thanks.
>>
>> On 07/30/2013 10:15 AM, Chen Gang wrote:
>>> Hello Maintainers:
>>>
>>> When I build sh64 with allmodconfig (without "EXTRA_CFLAGS=-W"), it
>>> report the warnings below:
>>>
>>>     LD      arch/sh/kernel/cpu/sh5/built-in.o
>>>   WARNING: arch/sh/kernel/cpu/sh5/built-in.o (.cranges): unexpected non-allocatable section.
>>>   Did you forget to use "ax"/"aw" in a .S file?
>>>   Note that for example <linux/init.h> contains
>>>   section definitions for use in .S files.
>>>
>>> Can it cause real world issue ?
>>>
>>> Welcome any members suggestions or completions.
>>>
>>>
>>> Thanks.
>>> --
>>> Chen Gang.
>>>
>>
>>
> 
> 


-- 
Chen Gang
