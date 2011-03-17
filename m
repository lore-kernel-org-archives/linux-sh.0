From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Mar 2011 07:10:41 +0000
Subject: Re: SH Core Linux 20110317
Message-Id: <AANLkTimxONu-eUssBfUt7WZ2PCxUoeJd-hPcU0iyXn_C@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTikhuHy8iZO+K6OOARG7fAt90hXbcEFE91dirMOX@mail.gmail.com>
In-Reply-To: <AANLkTikhuHy8iZO+K6OOARG7fAt90hXbcEFE91dirMOX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Mar 17, 2011 at 3:56 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday, March 17, 2011 02:40:01 Magnus Damm wrote:
>> This is the first public release of SH Core Linux, version 20110317.
>>
>> SH Core Linux brings the Linux to the SH core included in sh7372 -
>> running in parallel with the ARM core.
>>
>> Many modern SoCs contain multiple CPU cores in asymmetric
>> multiprocessing configurations. These asymmetric CPU configurations
>> often run multiple operating system instances; sometimes multiple
>> instances of Linux and sometimes Linux on the main CPU and some
>> customized software on the other CPU cores. Asymmetric CPU
>> configurations are different from symmetric multiprocessing
>> configurations which make use of a single Linux kernel together with
>> SMP to support multiple processor cores. To make things even more
>> complicated, come SoCs are configured to have some CPU cores operating
>> in SMP mode, and others in AMP.
>
> interesting. =A0we've been banging on similar issues with multiple Blackf=
ins.
> we've got an ICC (inter core communication) driver going atm. =A0but the
> protocol isnt limited to Blackfins ... we've made sure to design it so th=
at
> any other processor type can work, as well as any operating system.

Yeah, this problem isn't limited to ARM, SH or Renesas.
I agree that we all want to support multiple operating systems, but I
believe this has already been done by the virtualization/enterprise
community with their paravirtualized drivers using Virtio.

>> This SH Core Linux prototype is written for the sh7372 SoC from
>> Renesas. The sh7372 contains one ARM Cortex-A8 and one SH4AL-DSP core.
>> This release includes all that is needed to run two instances of
>> Linux; one on the ARM core and one on the SH core. The ARM core is the
>> main SoC processor which runs a user space program to control the SH
>> core. The SH core does not make use of any special hardware except a
>> mailbox interface where Virtio serves as a communication link.
>
> so this implementation isnt limited to Linux right ?

I'm sure other people are using different operating systems on sh7372,
but this SH Core Linux implementation is Linux-only. However, Virtio
is not Linux-only. In other words, the SH Core Linux release in this
thread is basically some SoC specific glue to get Virtio going for
interprocess communication on sh7372. I see no reason why other
vendors can't do the same. No need to invent your own drivers when we
have fully working virtio drivers.

> i think TI has been doing their own thing too ? =A0but they dont usually =
try
> hard to push back to mainline ...
>
> and then there's MCAPI ...

Yeah, each vendor unfortunately has their own solution. The situation
is similar to traditional embedded PM.

> i wonder if there's some way we can centralize/focus efforts on the Linux=
 side
> so each SoC vendor doesnt keep coming up with its own magic sauce to glue
> worlds together. =A0i really dont see this as being a useful area for eve=
ryone
> to "innovate" on their own. =A0the advantage to being the first one into
> mainline is that everyone else will have to migrate to it :).
>
> perhaps start a list on vger.kernel.org and a wiki on wiki.kernel.org ?

I believe the answer to all this is Virtio, but I'm not sure if
everyone will agree with me. =3D)

Thanks,

/ magnus
