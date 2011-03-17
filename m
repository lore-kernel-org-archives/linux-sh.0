From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Mar 2011 11:21:36 +0000
Subject: Re: SH Core Linux 20110317
Message-Id: <AANLkTimZd0ac9c4qaJHndzZ-f=4omQkHs49jKuVhjSGE@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTikhuHy8iZO+K6OOARG7fAt90hXbcEFE91dirMOX@mail.gmail.com>
In-Reply-To: <AANLkTikhuHy8iZO+K6OOARG7fAt90hXbcEFE91dirMOX@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Mar 17, 2011 at 4:55 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday, March 17, 2011 03:10:41 Magnus Damm wrote:
>> On Thu, Mar 17, 2011 at 3:56 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>> > i wonder if there's some way we can centralize/focus efforts on the Li=
nux
>> > side so each SoC vendor doesnt keep coming up with its own magic sauce
>> > to glue worlds together. =A0i really dont see this as being a useful a=
rea
>> > for everyone to "innovate" on their own. =A0the advantage to being the
>> > first one into mainline is that everyone else will have to migrate to =
it
>> > :).
>> >
>> > perhaps start a list on vger.kernel.org and a wiki on wiki.kernel.org ?
>>
>> I believe the answer to all this is Virtio, but I'm not sure if
>> everyone will agree with me. =3D)
>
> so if i had to summarize your SuperH effort, it'd be "use virtio" ? =A0i =
can
> work with that and see about driving stuff internally in that direction.

Yes! It would be great to see other vendors using Virtio.

I have not done any performance tuning yet though, so I guess the only
unknown factor is the overhead. But since Virtio is already used in
virtualized environments I believe that some optimization has been
done already. If that's not enough then future virtio specific driver
optimizations can be benefit both enterprise and embedded.

Thanks,

/ magnus
