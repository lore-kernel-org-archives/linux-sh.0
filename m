From: Jean Pihet <jean.pihet@newoldbits.com>
Date: Fri, 30 Sep 2011 08:08:36 +0000
Subject: Re: [PATCH 3/3] PM / QoS: Add function dev_pm_qos_read_value() (v2)
Message-Id: <CAORVsuV4ccJvJg-zCrhVXJKmHkEYLLQh032=BMh7qH27bTK5uQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108310017.03103.rjw@sisk.pl>
	<201109242326.48485.rjw@sisk.pl>
	<CAORVsuUopAWQuFkn1cURiv+YhEUT6=SQV5NRL5N1Y1oYn9d2NQ@mail.gmail.com>
	<201109292233.52378.rjw@sisk.pl>
In-Reply-To: <201109292233.52378.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>, Ming Lei <tom.leiming@gmail.com>

Hi Rafael,

On Thu, Sep 29, 2011 at 10:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Thursday, September 29, 2011, Jean Pihet wrote:
>> Hi Rafael,
>>
>> I have a few minor remarks, inlined below.
>
> In the meantime it turned out that the patch caused a build failure
> for CONFIG_PM_SLEEP unset (your original patches won't really work
> in this case too), so I posted a patch to fix it. =A0However, since
> you had remarks anyway, I've simply folded the fix into the next
> version of the $subject patch, which is appended.
OK to me.

I have 2 remarks though:
- some drivers are using the power_state field in the suspend/resume
operation, IIUC without conflict. Can you confirm?
- the power_state field is scheduled for removal, cf.
Documentation/feature-removal-schedule.txt. That does not look
correct.

...
>> > +static void __dev_pm_qos_constraints_init(struct device *dev)
>> I would change the name or add a comment stating that this is an
>> internal function which reinits the constraints field under the lock.
>
> This function was used only once, so it wasn't really necessary. =A0I sim=
ply
> removed it.
>
> Thanks,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / QoS: Add function dev_pm_qos_read_value() (v3)
>
> To read the current PM QoS value for a given device we need to
> make sure that the device's power.constraints object won't be
> removed while we're doing that. =A0For this reason, put the
> operation under dev->power.lock and acquire the lock
> around the initialization and removal of power.constraints.
>
> Moreover, since we're using the value of power.constraints to
> determine whether or not the object is present, the
> power.constraints_state field isn't necessary any more and may be
> removed. =A0However, dev_pm_qos_add_request() needs to check if the
> device is being removed from the system before allocating a new
> PM QoS constraints object for it, so make it use the
> power.power_state field of struct device for this purpose.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Regards,
Jean
