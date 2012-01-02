From: Paul Cercueil <pcercuei@gmail.com>
Date: Mon, 02 Jan 2012 21:57:09 +0000
Subject: Re: Dreamcast build broken
Message-Id: <4F022835.3030503@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4EC81660.3010109@gmail.com>
In-Reply-To: <4EC81660.3010109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Le 17/12/2011 11:24, Adrian McMenamin a =E9crit :
> On 25 November 2011 16:24, Paul Cercueil<pcercuei@gmail.com>  wrote:
>> Le 24/11/2011 08:29, Paul Mundt a =E9crit :
>>>
>
>> However, starting from commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba a=
nd
>> up to the latest vanilla Linux 3.1,
>> the vmlinux binary won't start on my dreamcast or on the lxdream emulato=
r.
>>
> No output at all?

Hi,
Sorry for the late reply.

That's right, there is no output at all. Perhaps the binary starts=20
correctly but then it crashes before the activation of the framebuffer.

I am facing another issue about the dreamcast build: the entry point of=20
the kernel is set to 0x8c002000, which does not appear to be correct.=20
When booting a CD, the bootloader (contained inside the IP.bin file)=20
loads the main executable at 0x8c010000.

On a side note, the kernel inside the old DCLinux (based on Linux 2.4)=20
has an entry point set to 0x8c012000.
