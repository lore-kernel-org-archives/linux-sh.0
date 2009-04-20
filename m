From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Apr 2009 10:26:36 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30904200326w2546cad1y6b63a68d4a1665e5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Francesco!

On Fri, Apr 17, 2009 at 9:00 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi Magnus
>>
>> For boot loader, do you use upstream U-boot? That would be interesting to
>> see.
>>
>
> We are moving on an internal light boot-loader.

Sounds lightweight and nice. =3D)

>> Apart from that, this approach is low on my list. This because it
>> affects a lot of code and it may be difficult to maintain. I want to
>> prioritize R-standby where we can power off most of the CPU but still
>> resume from RAM without boot loader modifications...
>
> This means the main CPU core is still powered. Is it?

Some part of the CPU is still powered on. So it remembers a little
state and can resume from internal on-chip RAM.

> While in the hibernation on memory the CPU runs from a standard power-on.

I understand.

>>
>> =A0Do you have a mode similar to R-standby?
>>
>
> No we haven't.

Ok.
Can you disable power to certain parts of the SoC? Do you have
multiple power domains?

Do you need functions for saving and restoring hardware state in
device drivers? I've been talking a bit about run time device power
management. Maybe that would be useful for you guys?

Cheers,

/ magnus
