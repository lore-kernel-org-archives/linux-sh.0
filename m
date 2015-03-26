From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 26 Mar 2015 00:53:38 +0000
Subject: Re: [PATCH] x86/vdso: Remove all generated files during clean
Message-Id: <CALCETrUBu2q5RvHFuGQoY2a+QmG==M6OTVru_ALh5orn8uLErg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150219021311.24366.75477.sendpatchset@little-apple> <54E78954.5070802@amacapital.net>
In-Reply-To: <54E78954.5070802@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Feb 20, 2015 at 11:21 AM, Andy Lutomirski <luto@amacapital.net> wrote:
> On 02/18/2015 06:13 PM, Magnus Damm wrote:
>>
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Make sure the following files are removed as expected during "make clean":
>>   + arch/x86/vdso/vdso-image-32-int80.c
>>   + arch/x86/vdso/vdso-image-32-syscall.c
>>   + arch/x86/vdso/vdso-image-32-sysenter.c
>>   + arch/x86/vdso/vdso-image-64.c
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>   arch/x86/vdso/Makefile |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> --- 0001/arch/x86/vdso/Makefile
>> +++ work/arch/x86/vdso/Makefile 2015-02-19 10:50:15.975470639 +0900
>> @@ -1,3 +1,4 @@
>> +
>>   #
>>   # Building vDSO images for x86.
>>   #
>> @@ -206,4 +207,5 @@ $(vdso_img_insttargets): install_%: $(ob
>>   PHONY += vdso_install $(vdso_img_insttargets)
>>   vdso_install: $(vdso_img_insttargets) FORCE
>>
>> -clean-files := vdso32-syscall* vdso32-sysenter* vdso32-int80* vdso64*
>> +clean-files := vdso32-syscall* vdso32-sysenter* vdso32-int80* vdso64* \
>> +               vdso-image-32* vdso-image-64*
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Applied, sans the extra newline.

Unapplied and replaced by a different patch that handles x32 correctly.

--Andy

>
> Thanks,
> Andy



-- 
Andy Lutomirski
AMA Capital Management, LLC
