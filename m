From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 01 Aug 2013 05:58:54 +0000
Subject: Re: [Suggestion] sh64: kernel: about the warning: "unexpected non-allocatable section".
Message-Id: <51F9F91E.4060704@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51F721CD.3010006@asianux.com>
In-Reply-To: <51F721CD.3010006@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/31/2013 03:38 PM, Chen Gang wrote:
> On 07/30/2013 02:11 PM, Chen Gang wrote:
>> On 07/30/2013 02:09 PM, Chen Gang wrote:
>>>
>>> For sh, it will report error below:
>>>
>>>   [root@dhcp122 linux-next]# make ARCH=sh CROSS_COMPILE=sh-linux-gnu-
>>>   CC      scripts/mod/empty.o
>>>   as: unrecognized option '-little'
>>>   make[2]: *** [scripts/mod/empty.o] Error 2
>>>   make[1]: *** [scripts/mod] Error 2
>>>   make: *** [scripts] Error 2
>>>
>>> The related binutils information:
>>>
>>>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh-linux-gnu-ld
>>>   binutils-sh-linux-gnu-2.23.51.0.3-1.fc17.x86_64
>>>   [root@dhcp122 build-binutils-or32]# rpm -qf /usr/bin/sh-linux-gnu-as
>>>   binutils-sh-linux-gnu-2.23.51.0.3-1.fc17.x86_64
>>>
>>
> 
> It is really the original sh-linux-gnu- compiler's issue (not only for
> allmodconfig, but also for sh own config files).
> 
> With my new build cross-compiler, It can work for sh architecture own
> config files, but can not work with allmodconfig (I will analyze it).
> 

after delete "-m32" in "scripts/recordmcount.pl", it will be OK.

The related patch which I have sent:

----------------------------patch begin----------------------------------

diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 858966a..679218b 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -262,7 +262,6 @@ if ($arch eq "x86_64") {
     # force flags for this arch
     $ld .= " -m shlelf_linux";
     $objcopy .= " -O elf32-sh-linux";
-    $cc .= " -m32";
 
 } elsif ($arch eq "powerpc") {
     $local_regex = "^[0-9a-fA-F]+\\s+t\\s+(\\.?\\S+)";
-- 
1.7.7.6

----------------------------patch end------------------------------------

...
> 
> Next, I will make a confirmation for sh64 compiler whether is OK or not.
> 
> Welcome any members' suggestions or completions.
> 
> Thanks.
> 
...
>>>
>>> On 07/30/2013 10:15 AM, Chen Gang wrote:
>>>> Hello Maintainers:
>>>>
>>>> When I build sh64 with allmodconfig (without "EXTRA_CFLAGS=-W"), it
>>>> report the warnings below:
>>>>
>>>>     LD      arch/sh/kernel/cpu/sh5/built-in.o
>>>>   WARNING: arch/sh/kernel/cpu/sh5/built-in.o (.cranges): unexpected non-allocatable section.
>>>>   Did you forget to use "ax"/"aw" in a .S file?
>>>>   Note that for example <linux/init.h> contains
>>>>   section definitions for use in .S files.
>>>>
>>>> Can it cause real world issue ?
>>>>
>>>> Welcome any members suggestions or completions.
>>>>
>>>>

I have built sh64 cross compiler, it also reports the related warning.

It is not cross compiler's issue, need permit ".cranges' section for
sh64 architecture in "scripts/mod/modpost.c".

The related patch which I have sent:

----------------------------patch begin----------------------------------

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6216434..8247979 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -821,6 +821,7 @@ static const char *section_white_list[]  {
 	".comment*",
 	".debug*",
+	".cranges",		/* sh64 */
 	".zdebug*",		/* Compressed debug sections. */
 	".GCC-command-line",	/* mn10300 */
 	".GCC.command.line",	/* record-gcc-switches, non mn10300 */
-- 
1.7.7.6

----------------------------patch end------------------------------------

>>>> Thanks.
>>>> --
>>>> Chen Gang.
>>>>
>>>
>>>
>>
>>
> 
> 

Thanks.
-- 
Chen Gang
