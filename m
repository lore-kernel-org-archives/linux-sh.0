From: Rob Landley <rob@landley.net>
Date: Mon, 13 Apr 2020 02:24:05 +0000
Subject: Re: v5.6 is still throwing a stack trace on boot.
Message-Id: <06d2a875-1bdf-7748-41d1-50413e86ee8b@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
In-Reply-To: <24dbbbc2-644a-1f9e-4e82-b7b726a4ce42@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 4/7/20 10:21 AM, Rich Felker wrote:
> On Tue, Apr 07, 2020 at 09:21:26AM -0500, Rob Landley wrote:
>> On 4/3/20 7:51 PM, Rich Felker wrote:
>>> On Fri, Apr 03, 2020 at 07:28:27PM -0500, Rob Landley wrote:
>>>>>> ---[ end trace 76213c1325250d90 ]---
>>>>>
>>>>> Which hardware is this on? The qemu emulated board you're using?
>>>>
>>>> Yes, qemu -M r2d. Built with attached miniconf, and run via:
>>>>
>>>> qemu-system-sh4 -M r2d -serial null -serial mon:stdio -nographic -no-reboot \
>>>>   -m 256 -append "panic=1 HOST=sh4 console=ttySC1 noiotrap" -kernel zImage \
>>>>   -initrd sh4.cpio.gz
>>>
>>> OK. This is nbd, it's just some pedantry added in commit
>>> 128227e7fe4087b60f1bd31f762e61237eb23790. Essentially it's complaining
>>> that something requested zero-filled slab memory when it's about to
>>> run a constructor to fill in the memory. The backtrace is (as usual)
>>> somewhat bogus looking and grep isn't helping me find where it's being
>>> called from. I'll keep looking and see if I can track it down.
>>
>> Did you?

[crickets]

>> Also, https://marc.info/?l=linux-sh&m8544749818664&w=2 still doesn't seem to
>> be upstream?
> 
> See Geert's reply,
> 
> Message-ID: <CAMuHMdVm-871S5tOdQw0KbRao+L0Wg46Rk3yNRyW45zJf3qt4w@mail.gmail.com>

404 error from
https://lkml.kernel.org/lkml/CAMuHMdVm-871S5tOdQw0KbRao+L0Wg46Rk3yNRyW45zJf3qt4w@mail.gmail.com/

No idea what else I'm supposed to do with a message ID other than that. I tried
googling for the message ID string and there were zero hits.

Do you mean Geert's March 15 message forwarding the alignment issue to arnd and
linux-arch, which predated my message cc-ing Linus before rc6 came out (I.E. not
the memory dump issue)? Are you saying "Geert forwarded it to somebody else last
month, therefore there's nothing to follow up on?" Because I just checked and
still nobody's replied to it on linux-arch:

  https://www.spinics.net/lists/linux-arch/

I'm not sure anybody saw it. And he only forwarded them the 2/2 patch, not the
first one.

> I think the patch is correct but still don't thoroughly understand it
> (in terms of where these functions are used and whether it preserves
> the property that everything that needs zero-fill gets it).

Do you still mean the two added align directives? If so, how is zeroing
involved? (Because if Geert replied about the stack dump issue, it was either
before March 1, or neither I nor the list were cc'd.)

> Will follow up soon.

Ok, I'll wait until -rc1 closes to send this reply...

Rob
