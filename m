From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 24 Sep 2013 17:37:42 +0000
Subject: Re: [PATCH 1/3] media: i2c: Add ADV761X support
Message-Id: <5241CDE6.9010706@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380029916-10331-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 09/24/2013 06:19 PM, Guennadi Liakhovetski wrote:
> Hi Hans
> 
> On Tue, 24 Sep 2013, Hans Verkuil wrote:
> 
>> Shouldn't the interrupt_service_routine() op be implemented as well?
>> Usually these drivers will generate interrupts if e.g. the format changes.
> 
> Should it? AFAIU, .interrupt_service_routine() is a subde operation to be 
> called by a bridge driver, when it gets an interrupt for the respective 
> subdevice:
> 
>    interrupt_service_routine: Called by the bridge chip's interrupt service
> 	handler, when an interrupt status has be raised due to this subdev,
> 					 typo ^^
> 
> 	so that this subdev can handle the details.  It may schedule work to be
> 	performed later.  It must not sleep.  *Called from an IRQ context*.

Hmm, I have serious doubts whether the "It must not sleep.  *Called from an IRQ context*."
part is correct. I have to check that. I think it is actually the opposite,
especially since most i2c drivers will have to do i2c accesses which can always
sleep.

> 
> In this case the device does indeed have 2 interrupt output lines, but I 
> don't think they would be connected to dedicated bridge inputs, rather to 
> GPIOs, so, the driver can implement an ISR itself, when it decides to 
> implement support for those interrupts.

That's another option. But this driver implements neither option, which is
unusual.

Regards,

	Hans
