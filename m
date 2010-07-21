From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jul 2010 09:17:38 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Runtime PM prototype
Message-Id: <AANLkTimx-yexDDOjqJ-PBgbi21Y6cRhZfAPoLJHAsnmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100705092122.22936.76406.sendpatchset@t400s>
In-Reply-To: <20100705092122.22936.76406.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Thu, Jul 8, 2010 at 5:28 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 5 Jul 2010, Magnus Damm wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> This is a simple prototype that enables Runtime PM
>> on SH-Mobile ARM processors. Only clocks are managed
>> at this point. Needs more work, especially WRT the
>> shared ARM bits.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> I think, something like this is needed on top of your patch:

> + =A0 =A0 =A0 if (dev->driver && dev->driver->pm && dev->driver->pm->runt=
ime_suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_suspend(de=
v);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;

> + =A0 =A0 =A0 if (dev->driver && dev->driver->pm && dev->driver->pm->runt=
ime_resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev->driver->pm->runtime_resume(dev=
);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;

Thanks a lot for your suggestion!

Yes, something like the above is needed. But the code must be extended
to become power domain aware before we start suspending and resuming.
The drivers are supposed to save and restore context using the
runtime_suspend/resume callbacks, and doing that without being able to
power off is just pure overhead. So the drivers will be asked to save
context only when all drivers in the same power domain have been
runtime suspended.

> I.e., you also have to call driver runtime-pm methofs, similarly to how it
> is done on SuperH. Otherwise, e.g., lcdcfb doesn't work.

Drivers should not assume that the runtime_suspend/resume callbacks
will be invoked at a certain point. The power domain partitioning
varies with processor type but drivers are shared across multiple
processors. Drivers are unaware of the power domain partitioning, but
the runtime pm code knows how things fit together. Because of this it
is up to the runtime pm code to decide when to invoke the driver
callbacks.

Please update the LCDC driver to only save and restore context in the
runtime pm callbacks. And remove any code that assumes that the
callbacks will be invoked when the device is suspended.

Cheers,

/ magnus
