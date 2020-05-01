From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 01 May 2020 11:13:24 +0000
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
Message-Id: <87wo5vx60b.fsf@x220.int.ebiederm.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
 <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
 <87imhgyeqt.fsf@x220.int.ebiederm.org>
 <9dd76936-0009-31e4-d869-f64d01886642@linux-m68k.org>
In-Reply-To: <9dd76936-0009-31e4-d869-f64d01886642@linux-m68k.org> (Greg
 Ungerer's message of "Fri, 1 May 2020 15:44:03 +1000")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Mark Salter <msalter@redhat.com>, Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Nicolas Pitre <nico@fluxnic.net>, Linux-sh list <linux-sh@vger.kernel.org>, Jann Horn <jannh@google.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Greg Ungerer <gerg@linux-m68k.org> writes:

> On 1/5/20 5:07 am, Eric W. Biederman wrote:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>
>>> On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>>
>>>>> Most of that file goes back to pre-git days. And most of the commits
>>>>> since are not so much about binfmt_flat, as they are about cleanups or
>>>>> changes elsewhere where binfmt_flat was just a victim.
>>>>
>>>> I'll have a look at this.
>>>
>>> Thanks.
>>>
>>>> Quick hack test shows moving setup_new_exec(bprm) to be just before
>>>> install_exec_creds(bprm) works fine for the static binaries case.
>>>> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
>>>> dig into that to see why.
>>>
>>> Just moving setup_new_exec() would at least allow us to then join the
>>> two together, and just say "setup_new_exec() does the credential
>>> installation too".
>>
>> But it is only half a help if we allow failure points between
>> flush_old_exec and install_exec_creds.
>>
>> Greg do things work acceptably if install_exec_creds is moved to right
>> after setup_new_exec? (patch below)
>
> Yes, confirmed. Worked fine with that patch applied.

Good.  Thank you.

That is what we need for other cleanups.  All three of those together.

>> This is what I was thinking about applying.
>>
>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
>> index 831a2b25ba79..1a1d1fcb893f 100644
>> --- a/fs/binfmt_flat.c
>> +++ b/fs/binfmt_flat.c
>> @@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>   		/* OK, This is the point of no return */
>>   		set_personality(PER_LINUX_32BIT);
>>   		setup_new_exec(bprm);
>> +		install_exec_creds(bprm);
>>   	}
>>     	/*
>> @@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
>>   		}
>>   	}
>>   -	install_exec_creds(bprm);
>> -
>>   	set_binfmt(&flat_format);
>>     #ifdef CONFIG_MMU

Eric
