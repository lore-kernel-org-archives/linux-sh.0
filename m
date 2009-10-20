From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 20 Oct 2009 13:06:20 +0000
Subject: Re: [PATCH 04/14] sh: Obliterate the P1 area macros
Message-Id: <aec7e5c30910200606g5b4ca4d2l25118fc3fb7f03e6@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
In-Reply-To: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

>> On Wed, Oct 7, 2009 at 6:22 AM, Matt Fleming <matt@console-pimps.org> wr=
ote:
>> > =A0* Map an address to a certain privileged segment
>> > diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_k=
exec.c
>> > index 7ea2704..de7cf54 100644
>> > --- a/arch/sh/kernel/machine_kexec.c
>> > +++ b/arch/sh/kernel/machine_kexec.c
>> > @@ -49,7 +49,7 @@ int machine_kexec_prepare(struct kimage *image)
>> > =A0 =A0 =A0 =A0/* older versions of kexec-tools are passing
>> > =A0 =A0 =A0 =A0 * the zImage entry point as a virtual address.
>> > =A0 =A0 =A0 =A0 */
>> > - =A0 =A0 =A0 if (image->start !=3D PHYSADDR(image->start))
>> > + =A0 =A0 =A0 if (image->start !=3D __pa(image->start))
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL; /* upgrade your kexec-t=
ools */
>> >
>> > =A0 =A0 =A0 =A0return 0;
>>
>> This change unfortunately breaks kexec. The PHYSADDR() macro masks but
>> __pa() subtracts so this breaks the physical address case.
>>
>> Do you have any idea how to keep the previous behaviour? Worst case we
>> can just remove this check - it's been a while since I updated
>> kexec-tools now.
>>
>
> Damn, sorry I missed this. Is image->start a virtual address? If so,
> this check doesn't make sense when CONFIG_PMB is enabled because virtual
> addresses do not have to be mapped to physical addresses 1:1.

So the problem is that it _may_ be a virtual address if the
kexec-tools version is old enough. And the check is there to
gracefully reject the software and force people to upgrade.

> If image->start is a physical address, I don't think it's ever true that
> image->start =3D __pa(image->start) beacuse you can't apply __pa() to a
> physical address and get the same address, e.g.
>
> =A0 =A0 =A0 =A0 __pa(addr) !=3D __pa(__pa(addr))
>
> So, unless I'm mistaken this test can just be removed.

I think the easist thing is that I submit a patch that simply removes the t=
est.

Cheers,

/ magnus
