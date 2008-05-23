From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 23 May 2008 01:24:42 +0000
Subject: Re: [PATCH 01/03] uio: Add enable_irq() callback
Message-Id: <aec7e5c30805221824l5ecf0b53i1e1cce7c1c815912@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080520105132.1474.73941.sendpatchset@rx1.opensource.se>
	 <20080520105140.1474.59715.sendpatchset@rx1.opensource.se>
	 <aec7e5c30805210458m3d15b89am563e4a94b8eb6f2c@mail.gmail.com>
	 <20080522201829.GE3226@local>
In-Reply-To: <20080522201829.GE3226@local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Hans J. Koch" <hjk@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, gregkh@suse.de, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>

Hi Hans,

On Fri, May 23, 2008 at 5:18 AM, Hans J. Koch <hjk@linutronix.de> wrote:
> On Wed, May 21, 2008 at 08:58:24PM +0900, Magnus Damm wrote:
>> On Tue, May 20, 2008 at 7:51 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > Add enable_irq() callback to struct uio_info. This callback is needed by
>> > the uio_platform driver so interrupts can be enabled before blocking.
>>
>> We can most likely use a single uio platform driver if this patch is
>> acceptable. Any NAKs?
>
> Yes. Your approach only allows enabling interrupts, but not disabling
> them. And I don't like that it is not possible for generic userspace
> tools to find out if a UIO device has this auto-irq-enabling capability
> or not.

Thanks for your effort. I understand that you need to enable and
disable interrupts from user space, but that's a bit different from
what I want to do. I just want interrupts to be enabled before I do
read() or poll().

Also, adding the capability of disabling and enabling interrupts from
user space seems a bit error prone to me. Mainly since user space then
needs to know that the interrupt handler in kernel space can cope with
such changes. Not such a clean interface IMO. OTOH you may need that
to cope with some broken hardware.

But why does user space need to know if the auto-irq-enabling function
is there or not? If the user is interfacing to the wrong kernel UIO
driver with wrong behavior then he has obviously done something wrong.
Knowing if auto-irq-enabling is there from user space isn't going to
save users from themselves. They can and will mix and match things in
all sorts of wrong ways anyway.

> I just posted a patch that allows enabling _and_ disabling of irqs from
> userspace by writing 0 or 1 to /dev/uioX. I've CCed you, could you
> please test? If this doesn't do what you need, please let me know.

I'm sure your patch or the ioctl suggestion both allow re-enabling
interrupts from user space. That's great, but both of them add extra
syscall overhead compared to my suggestion. They also make the user
space interface in user space part of the driver a bit more
complicated.

I do understand that you don't want to mess up your UIO kernel
callbacks by introducing just merging new ones all the time. OTOH, my
patch is just a few lines. Is introducing one extra syscall good
enough performance wise?

Thanks for your help!

/ magnus
