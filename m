From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 23 Jun 2011 02:26:34 +0000
Subject: Re: [PATCH 02/02] virtio: Add virtio platform driver
Message-Id: <BANLkTimSj9iMeYJ8X7SCocVDfbGUPGotRw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110621102605.1382.90232.sendpatchset@t400s>
	<20110621102623.1382.71841.sendpatchset@t400s>
	<BANLkTi=tut=Y4fc4tkT8wt_q1azJOYaDoQ@mail.gmail.com>
In-Reply-To: <BANLkTi=tut=Y4fc4tkT8wt_q1azJOYaDoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, horms@verge.net.au, mst@redhat.com, iws@ovro.caltech.edu

Hi Mike,

On Wed, Jun 22, 2011 at 3:27 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Tue, Jun 21, 2011 at 06:26, Magnus Damm wrote:
>> +config VIRTIO_PLATFORM
>> + =A0 =A0 =A0 tristate "Platform driver for virtio devices (EXPERIMENTAL=
)"
>> + =A0 =A0 =A0 select VIRTIO
>> + =A0 =A0 =A0 select VIRTIO_RING
>> + =A0 =A0 =A0 select VIRTIO_LGUEST
>> + =A0 =A0 =A0 ---help---
>> + =A0 =A0 =A0 =A0This drivers provides support for virtio based paravirt=
ual device
>> + =A0 =A0 =A0 =A0drivers over a platform bus.
>> +
>> + =A0 =A0 =A0 =A0If unsure, say N.
>
> be nice to add a note as to the name of the module if the user selects "M"

Yes, good idea!

>> --- /dev/null
>> +++ work/drivers/virtio/virtio_platform.c =A0 =A0 =A0 2011-03-03 16:07:3=
1.000000000 +0900
>> --- /dev/null
>> +++ work/include/linux/virtio_platform.h =A0 =A0 =A0 =A02011-03-03 15:56=
:54.000000000 +0900
>
> both files lack a comment block at the top
> /*
> =A0* one line desc of file
> =A0*
> =A0* copyright
> =A0*
> =A0* license blurb
> =A0*/

Sure! I will include these changes in the next version!

Thank you!

/ magnus
