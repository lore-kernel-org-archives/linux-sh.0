From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 10:32:03 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <aec7e5c30905110332w3691edfdv62bc6ee5a5425346@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 7:15 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> On Mon, May 11, 2009 at 06:59:37PM +0900, Magnus Damm wrote:
>> On Mon, May 11, 2009 at 6:44 PM, Manuel Lauss
>> <mano@roarinelk.homelinux.net> wrote:
>> > On Mon, May 11, 2009 at 06:01:08PM +0900, Magnus Damm wrote:
>> >> From: Magnus Damm <damm@igel.co.jp>
>> >>
>> >> Update intc tables and platform data to use one linux irq
>> >> per maskable interrupt source instead of keeping the one-to-one
>> >> mapping between vectors and linux irqs.
>> >>
>> >> This fixes potential irq masking issues for sh7760 hardware
>> >> blocks such as DMAC/TMU2/REF.
>> >
>> > With this patch applied, my 7760 system no longer boots. ?I'll
>> > try to figure out why as soon as I get my JTAG probe back.
>>
>> Oops, that's no good. I'm converting sh7760 to make use of the new
>> timer driver, and while at it I wanted to fix the vectors because they
>> looked like they will generate warnings...
>>
>> Without this patch, do you see intc warning printouts like "intc:
>> missing unique irq mask for..."?
>
> In this particular instance, I see no outputs at all. =A0There are a
> few of those strings, but all for devices which I don't use.

Hm, that's strange. I guess something is wrong with my tables..

>> Are you using DMAC, TMU2 or REF on your system?
>
> DMAC is built-in, but no users other than DMABRG, which requests DMAC0
> on init.

So with this patch all DMA channels must use a single linux interrupt.
Requesting interrupt 34 should be ok in this case (the first DMAC
vector with value 0x640) but all other interrupt sources are disabled.
Interrupt 34 becomes a shared interrupt. We did similar changes for a
bunch of other processor models earlier this year, but we somehow
missed sh7760 then. Or ignored may be a better word, this since
there's no sh7760 hardware on my desk. =3D)

If you have a little time to spend on this, then feel free to test by
#ifdefing out various INTC_VECT() to check which vector that makes the
boot fail. A good start may be to disable all DMA users and see if
that helps.

Cheers,

/ magnus
