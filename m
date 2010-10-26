From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 26 Oct 2010 00:19:55 +0000
Subject: Re: [RFC/PATCH] sh: Add 32bit cou mode to cpu_flags
Message-Id: <AANLkTikpaSsnkgOpJUvtaZ6PYsKhOFiaVq47LysHkmoQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1287452609-14530-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul.

2010/10/25 Paul Mundt <lethal@linux-sh.org>:
> On Wed, Oct 20, 2010 at 11:13:09AM +0900, Nobuhiro Iwamatsu wrote:
>> 2010/10/19 Paul Mundt <lethal@linux-sh.org>:
>> > On Tue, Oct 19, 2010 at 10:43:29AM +0900, Nobuhiro Iwamatsu wrote:
>> >> There is not method to confirm which of 32bit mode or 29bit mode Linux
>> >> kernel works.
>> >> This patch adds a mode to cpu_flags and can confirm it from auxv and proc
>> >> filesystem.
>> >>
>> > Is there some use you had in mind for this?
>>
>> First , I wanted these as information simply.
>>
>> And I am debuging kexec-toos for 32bit mode.
>> I need this information to use as __pa in kernel.
>> If there is a good method, please teach it.
>>
> While I agree that having this information exposed is useful, I don't
> think it really falls under a CPU  as such. 32-bit capable CPUs
> can be either in 29 or 32-bit physical mode, so the existence of the PMB
> is not sufficient for determining configuration.
>

I thought whether I might be able to be in auxv, because the mode of
the CPU was changed,
But I agree.

> The x86 approach for reporting the physical address space size seems like
> a pretty good fit for this though, so how about this instead?

Looks good to me, thanks for fixing it.

Best regards,
  Nobuhiro
-- 
Nobuhiro Iwamatsu
