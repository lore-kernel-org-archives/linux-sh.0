From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Fri, 13 Feb 2009 14:27:14 +0000
Subject: Re: [Qemu-devel] Status of SH4 support in repository
Message-Id: <49958342.4080803@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20090209172352.cae23097.kristoffer.ericson@gmail.com>
	<20090210182909.b0dcab10.kristoffer.ericson@gmail.com>
	<4992C455.8020707@juno.dti.ne.jp>
	<200902130245.53417.rob@landley.net>
In-Reply-To: <200902130245.53417.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: qemu-devel@nongnu.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Rob Landley wrote:
> On Wednesday 11 February 2009 06:28:05 Shin-ichiro KAWASAKI wrote:
>> Kristoffer Ericson wrote:
>>> On Wed, 11 Feb 2009 01:53:45 +0900
>>>
>>> Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp> wrote:
>>>> Hi, Kristoffer.
>>>>
>>>> Kristoffer Ericson wrote:
>>>>> Greetings,
>>>>>
>>>>> Just interested in an update of the current status. I built a fresh
>>>>> qemu from the repository today and Im currently I get no output.
>>>> I do not catch 'no output' mean.  Could you explain it more?
>>>>
>>>> FYI, here's the log how I built qemu-sh at Feb. 6th.
>>>>   http://www.assembla.com/wiki/show/qemu-sh4/BuildingEnvironment
>>> My mistake I did something wrong when I built it earlier, currently
>>> it works somewhat. What doesnt work is keyboard,mouse and booting
>>> from image file (seems like to bootstring isnt being aknowledged).
>> Current qemu sh4 system emulation does not support either usb host
>> or kernel boot command line.  You still need to apply some patches
>> to use those features.
>>
>> Please check qemu-sh patch staging repository, which holds patches
>> for qemu-sh. README in it explains how to apply.
>>   http://git.kernel.org/?p=virt/qemu/lethal/qemu-sh.git;a=summary
> 
> My blocker is the lack of a working -append.  You have a git tree for a
> collection of 5 patches, which then wants to invoke "quilt" to apply them. 
> (Seems like overkill.)
> 
> At a guess, this seems like the patch that implements it is
> staging/sh4-r2d-update-pci-usb-and-kernel-management.patch
> 
>> To apply all them, you need to role back qemu to rev 6215, for now.
> 
> No you don't, you just need a chainsaw and some duct tape...
> 
>> The patch for usb host is already posted to qemu-ml.  But I guess
>> patch for kernel boot command line for r2d is not yet posted.
> 
> I adjusted the above patch to apply to current qemu svn, and attached the 
> result, but it didn't make -append work.  It's still using the hardwired one.
> 
> Any suggestions?  (Do I need to look at the other patches?  This one looked 
> like it was _trying_ to fix the problem...)

Yoshii-san already turned on the chainsaw the day before yeterday. :)
  http://lists.gnu.org/archive/html/qemu-devel/2009-02/msg00727.html

And I guess, -append option is valid only if the kernel zImage does
not contain built in kernel arguments : the kernel in sh-test-0.1.tar.bz2
contains it. Here's the one without arguments, I hope it helps.
  http://www.assembla.com/spaces/qemu-sh4/documents/aVMOyC-DGr3y5PeJe5afGb/download?filename=r2d_nokernelarg_zImage


Regards,
Shin-ichiro KAWASAKI
