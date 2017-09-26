From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 26 Sep 2017 12:55:44 +0000
Subject: Re: Bug report: kernel BUG at arch/sh/kernel/dwarf.c:547!
Message-Id: <36a20075-d0ce-e52e-4b8d-9f737f51691c@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20170926142902.36e9539e@windsurf.lan>
In-Reply-To: <20170926142902.36e9539e@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/26/2017 02:52 PM, Thomas Petazzoni wrote:
>> May I ask what kind of hardware you are using? I'm still looking for
>> new/used SH4 boards to add additional buildd resources in Debian.
> 
> It's a custom platform using the SH7786 SoC. Sadly, this is clearly not
> a HW platform that I can provide to help Debian having more build
> resources.

I assume this is some custom hardware used for automotive or industrial
applications?

>> I think it might be a better idea to report this issue to the kernel
>> bugzilla [1] so your bug report doesn't get lost. SuperH can now be
>> selected as the target architecture, too.
> 
> I thought about this, but I'm not sure the SH maintainers are actively
> looking at the kernel bug tracker.
> 
> Let's see if Rich and/or Yoshinori have some feedback about my issue.

Yoshinori is currently not active in kernel development but from what
I have heard, he was planning to return soonish. In any case, I just
want to avoid that your issue gets lost on the mailing lists.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
