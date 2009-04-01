From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 11:07:15 +0000
Subject: Re: [Proposal][PATCH] Fixed the irq interrupt line after a resume
Message-Id: <aec7e5c30904010407i5d448fa5rc8574a6f22613df1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Francesco,

On Wed, Mar 18, 2009 at 5:35 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi all
>
> Ad I said in a previous email the current hibernation suppont has a problem
> with
> every interrupt line enabled in the previous session by modules.

On suspend:

kernel/power/disk.c: create_image() calls device_power_down()
drivers/base/power/main.c: device_power_down() calls suspend_device_irqs()
kernel/irq/pm.c: suspend_device_irqs() calls __disable_irq()
kernel/irq/manage.c: __disable_irq() marks with IRQ_SUSPENDED and
calls chip->disable()

On resume:

kernel/power/disk.c: create_image() calls device_power_up()
drivers/base/power/main.c: device_power_up() calls resume_device_irqs()
kernel/irq/pm.c: resume_device_irqs() calls __enable_irq()
kernel/irq/manage.c: __enable_irq() calls check_irq_resend()

I suspect you want check_irq_resend() to re-enable the interrupt for
you somehow instead of doing it in restore_processor_state(). Does
that solve your problem?

> The right thing should be add sysdev device to the intc but it requires more
> work in the intc design.

Yes, upgrading intc to use sysdev for suspend and resume sounds like a
good idea. Adding wakeup support so we can do enable_irq_wake() and
set_irq_wake() is also needed.

On top of that we really need to re-init the entire interrupt
controller after coming back from U/R-standby.

/ magnus
