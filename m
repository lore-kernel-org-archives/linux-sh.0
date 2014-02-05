From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 07:13:04 +0000
Subject: Re: [PATCH 1/3] arm: shmobile: lager: Add USBHS support
Message-Id: <CANqRtoSBVNvXrxA2w1a7CgGccRn3dO5VwZn+AmxJ766dLU7=aA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon, Valentine,

On Tue, Feb 4, 2014 at 9:44 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jan 29, 2014 at 01:21:49PM +0400, Valentine wrote:
>> On 01/29/2014 10:11 AM, Simon Horman wrote:
>> >On Mon, Jan 27, 2014 at 07:26:53PM +0900, Magnus Damm wrote:
>> >>On Sat, Jan 25, 2014 at 8:05 AM, Valentine
>> >><valentine.barshak@cogentembedded.com> wrote:
>> >>>On 01/24/2014 08:40 AM, Magnus Damm wrote:
>> >>>>On Sat, Jan 18, 2014 at 3:31 AM, Valentine
>> >>>><valentine.barshak@cogentembedded.com> wrote:
>> >>>I've sent a couple of patches that enable modules for lager and koelsch.
>> >>>I think this is useful even if we decide to go with composite gadget.
>> >>
>> >>Ok, thanks, I will duck and let Simon decide about this!
>> >
>> >I think it would be better to wait until we need modules
>> >before turning them on.
>> >
>>
>> Well, you may never need them and have everything built-in.
>>
>> Thought you might want modules for USB gadgets.
>> What configuration do you propose for the USBHS gadget?
>> Do you want me to add composite gadget built-in?
>
> I had assumed that they needed to be modules if there was to be
> more than one of them. Is there an alternate approach?

In older kernels there were limitations which kind of software support
you wanted to support in case of USB Function/Gadget. So historically
modules were used to handle that. Also, independently of modules it is
and has been possible to use sysfs and bind to perform similar things,
but I'm not sure if that will work with USB Function.

For USB Function there is CONFIG_USB_CONFIGFS that I believe should
make it possible to handle configuration during runtime. So if we
should enable something for USB Function in our defconfigs then
CONFIG_USB_CONFIGFS is probably the way to go. Feel free to prove me
wrong though.

Valentine, can you check if CONFIG_USB_CONFIGFS is working for you with USBHS?

Thanks,

/ magnus
