From: Luca Santini <luca.santini@spesonline.com>
Date: Fri, 05 Sep 2008 08:14:43 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <48C0EA73.90402@spesonline.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,
sorry for my late...
Yes, i think the patch works in 2.6.27-rcX kernel (addresses are fine 
and the chip detected) but i have the irq masking problem that i'm 
unable to resolve(my ignorance... i can't imagine what else to use than 
  make_imask_irq() - i tried your suggestion masking ALSO irqs from 48 
to 52 but with no result; i repeat, in .26 masking irq 9 works and in 
kernel/irq/manage.c compat_irq_chip_set_default_handler() is called; 
otherwise in .27 the function called is __irq_set_trigger(), but with 
chip->set_type = NULL), so my .27 kernel won't work in NFS and i can't 
say i'm 100% sure it works completely.


(in .26 it don't work because of the lack of 'lp' structure... )

p.s.: a little question git-related... (i'm moving my first steps with 
git..) :

if i pull from

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

it asks for a password.... ???

currently, i pull from

	git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git

is it the same?


Magnus Damm wrote:
> Hi Luca,
> 
> On Thu, Aug 28, 2008 at 8:50 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Thu, Aug 28, 2008 at 12:00 PM, Paul Mundt <lethal@linux-sh.org> wrote:
>>> On Wed, Aug 27, 2008 at 06:32:02PM +0200, Luca Santini wrote:
>>>>>>> +static struct smc91x_platdata smc91x_info = {
>>>>>>> +  .flags = SMC91X_USE_16BIT,
>>>>>>> +};
>>>>>>> +
>>>>> For some reason your flags here and your later smc91x patch for edosk7760
>>>>> have absolutely nothing in common. This leads me to believe that you
>>>>> either couldn't get the dynamic configuration working, in which case this
>>>>> bit of code is useless, or that it works fine and there's no need for the
>>>>> changes to smc91x.h. If you need both, you are doing something very
>>>>> wrong.
>>>>>
>>>> you're right; what i really need is
>>>>
>>>> #define SMC_IO_SHIFT 1
>>>>
>>>> but using the platdata flag
>>>>
>>>> SMC91X_IO_SHIFT_1
>>>>
>>>> doesn't work.
>>>>
>>> Ok, so that's a real bug then. Magnus, can you take a look at this?
>> The io shift platform data configuration should be generic, but it
>> looks like it has been fully hooked in by some ARM platforms only at
>> this point. Someone forgot to fix the generic case. Try the attached
>> patch, that should get you going. Let me know if it solves your issue.
> 
> Did the patch help?
> 
> Thanks,
> 
> / magnus
> 
> 
